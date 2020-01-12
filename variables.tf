variable "name" {default = "webapp01-dev"}

variable "image_id" { default = ""}
variable "instance_type" { default = "t2.micro"}
variable "iam_profile" { default = "EC2-DynamoDb"}
variable "security_group_ids" { default = ""}

variable "key_name" { default = "terraform_instances"}

variable "user_data" {
  default = <<-EOF
  #!/bin/bash
  hostname
  EOF
}
