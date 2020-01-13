
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

  root_block_device {
      volume_type = "standard"
      volume_size = 100
      delete_on_termination = true
    }

    lifecycle {
      create_before_destroy = true
    }
}



resource "aws_autoscaling_group" "this" {
  name                 = "${var.name}-asg"
  launch_configuration = "${aws_launch_configuration.this.name}"
  vpc_zone_identifier  = split(",", var.subnets)

  min_size             = "${var.min_size}"
  max_size             = "${var.max_size}"
  desired_capacity     = "${var.desired_capacity}"

  health_check_grace_period = "${var.health_check_grace_period}"
  target_group_arns     = var.target_group_arns == "" ? [] : split(",", var.target_group_arns)

}
