resource "alicloud_instance" "example" {
  instance_name        = "demo-instance"
  instance_type        = var.instance_type
  image_id             = var.image_id
  system_disk_category = var.system_disk_category
  system_disk_size     = var.system_disk_size
  internet_charge_type = var.internet_charge_type
  internet_max_bandwidth_out = var.internet_max_bandwidth_out

  vswitch_id = data.alicloud_vswitches.default.vswitches.0.id
  
  key_name = "seal-demo"

  security_groups = [
    data.alicloud_security_groups.default.groups.0.id
  ]

  user_data = <<-EOF
              #!/bin/bash
              apt update && apt install openjdk-17-jre-headless -y
              wget -O example.jar ${var.jar_url}
              java -jar example.jar
              EOF
}

data "alicloud_vpcs" "default" {
  name_regex = "default"
}

data "alicloud_vswitches" "default" {
  vpc_id = data.alicloud_vpcs.default.vpcs.0.id
}

data "alicloud_security_groups" "default" {
  name_regex = "default"
}

resource "null_resource" "health_check" {
  depends_on = [
    alicloud_instance.example,
  ]

  provisioner "local-exec" {
    command     = "for i in `seq 1 60`; do if `command -v wget > /dev/null`; then wget --no-check-certificate -O - -q $ENDPOINT >/dev/null && exit 0 || true; else curl -k -s $ENDPOINT >/dev/null && exit 0 || true;fi; sleep 5; done; echo TIMEOUT && exit 1"
    interpreter = ["/bin/sh", "-c"]
    environment = {
      ENDPOINT = "http://${alicloud_instance.example.public_ip}:8888"
    }
  }
}
