resource "aws_launch_configuration" "this" {
  name = "${var.launch_config_name}"
}
