variable "aws_region" {
  default = "us-west-2"
}

variable "instance_type" {
  default = "t3.micro"
}

source "amazon-ebs" "apache" {
  region     = var.aws_region
  source_ami = "resolve:ssm:/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  instance_type = var.instance_type
  ssh_username = "ec2-user"
  ami_name = "apache-server-${local.timestamp}"

  tags = {
    Name = "Apache Server"
  }
}

build {
  sources = [
    "source.amazon-ebs.apache"
  ]

  provisioner "ansible" {
    playbook_file = "ansible/setup_apache.yml"
  }
}
