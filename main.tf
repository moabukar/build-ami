provider "aws" {
  region = "us-west-2"
}

resource "aws_launch_template" "apache" {
  name_prefix   = "apache-server-"
  image_id      = "ami-123456"  # Replace with your AMI ID from Packer
  instance_type = "t2.micro"
  key_name      = "my-key"      

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 8
    }
  }
}

resource "aws_autoscaling_group" "apache" {
  launch_template {
    id      = aws_launch_template.apache.id
    version = "$Latest"
  }

  min_size         = 1
  max_size         = 3
  desired_capacity = 2
  vpc_zone_identifier = ["subnet-1234abcd"]  # Replace with your subnet IDs
}
