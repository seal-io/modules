variable "jar_url" {
  description = "The URL of the Jar package to be deployed"
}

variable "instance_type" {
  description = "The instance type of the ECS instance"
  default     = "ecs.t5-lc1m2.small"
}

variable "image_id" {
  description = "The ID of the image used to launch the ECS instance"
  default     = "ubuntu_18_04_64_20G_alibase_20200914.vhd"
}

variable "system_disk_category" {
  description = "The category of the system disk"
  default     = "cloud_efficiency"
}

variable "system_disk_size" {
  description = "The size of the system disk"
  default     = 40
}

variable "internet_charge_type" {
  description = "The billing method for the public network bandwidth"
  default     = "PayByTraffic"
}

variable "internet_max_bandwidth_out" {
  description = "The maximum outbound bandwidth of the public network"
  default     = 5
}

resource "alicloud_instance" "example" {
  instance_name        = "example-instance"
  instance_type        = var.instance_type
  image_id             = var.image_id
  system_disk_category = var.system_disk_category
  system_disk_size     = var.system_disk_size
  internet_charge_type = var.internet_charge_type
  internet_max_bandwidth_out = var.internet_max_bandwidth_out

  security_groups      = [alicloud_security_group.example.id]
  vswitch_id           = alicloud_vswitch.example.id

  user_data = <<-EOF
              #!/bin/bash
              wget ${var.jar_url} -O /home/admin/example.jar
              java -jar /home/admin/example.jar
              EOF
}

resource "alicloud_security_group" "example" {
  name        = "example-security-group"
  description = "Example security group"

  ingress {
    action      = "accept"
    protocol    = "tcp"
    port_range  = "22/22"
    cidr_ip     = "0.0.0.0/0"
  }

  ingress {
    action      = "accept"
    protocol    = "tcp"
    port_range  = "8080/8080"
    cidr_ip     = "0.0.0.0/0"
  }

  egress {
    action      = "accept"
    protocol    = "all"
    cidr_ip     = "0.0.0.0/0"
  }
}

resource "alicloud_vpc" "example" {
  name       = "example-vpc"
  cidr_block = "10.0.0.0/8"
}

resource "alicloud_vswitch" "example" {
  vpc_id            = alicloud_vpc.example.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "cn-hangzhou-b"
}