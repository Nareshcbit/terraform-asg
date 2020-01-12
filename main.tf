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
  name                  = "${var.name}-config"
  image_id              = var.image_id == "" ? data.aws_ami.ubuntu.id : var.image_id
  instance_type         = var.instance_type
  iam_instance_profile  = var.iam_profile
  security_groups       = var.security_group_ids == "" ? [] : split(",", var.security_group_ids)
  user_data             = "${var.user_data}"
  key_name              = "${var.key_name}"
}
