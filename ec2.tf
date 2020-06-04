provider "aws" {
#  access_key = "ACCESS_KEY_HERE"
#  secret_key = "SECRET_KEY_HERE"
  region     = var.region
}

resource "aws_instance" "master" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.private_key
  security_groups = [var.security_group]
  #security_groups = ["aws_security_group.allow_tls"]
  #count = "${length(var.azs)}"
  count = var.node_count
  user_data = data.template_cloudinit_config.docker-cloudinit.rendered  

  root_block_device {
    volume_size = 30
  }
  
  tags = {
    Name = var.prefix
  }
}

output "ec2_address" {
  value = [aws_instance.master[*].public_ip]
}

output "ec2_address_private" {
  value = [aws_instance.master[*].private_ip]
}

data "template_cloudinit_config" "docker-cloudinit" {
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.userdata_docker.rendered
  }
}

data "template_file" "userdata_docker" {
  template = file("files/userdata_docker")

  vars = {
   docker_version_server = var.docker_version
   join_command = lookup(element(rancher2_cluster.foo-custom.cluster_registration_token, 0), "node_command", "not_found")
   user = var.user
}
}