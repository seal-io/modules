terraform {
  required_version = ">= 1.0"

  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
    }

    byteset = {
      source = "seal-io/byteset"
    }
  }
}
