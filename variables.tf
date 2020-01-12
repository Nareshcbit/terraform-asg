variable "name" {default = "webapp01-dev"}

#Launch Config
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

#ASG
variable "subnets" { default = "subnet-0d66acf329840523a"}

variable "min_size" { default = 1}
variable "max_size" { default = 1}
variable "desired_capacity" { default = 1}
variable "health_check_grace_period" { default = 15}

variable "common_tags" {
    type = "map"
    default = {
        business_unit = "corp"
        department =  "cloud-engineering",
        team = "cloud-engineering",
        cost_center ="100786",
        app = "reporting-cto",
        env = "development",
        maintenance_window = "Friday 03:00 AM - Friday 05:00 AM",
        auto_approvals = "CORP, COSTOP"
  }
}
