provider "aws"{
  region = "ap-south-1"
}


terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-nxgcloud-infra-development"
    key            = "global/infra/asg.tfstate"
    region         = "ap-south-1"
  }
}



data "aws_ami" "ubuntu" {
most_recent = true
owners = ["099720109477"] # Canonical

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}



resource "aws_launch_configuration" "this" {
  name          = "${var.launch_config_name}"
  image_id      = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
}
