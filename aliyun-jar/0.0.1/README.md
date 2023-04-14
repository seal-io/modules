
# Module `aliyun-jar`

Provider Requirements:
* **alicloud:** (any version)

## Input Variables
* `image_id` (default `"ubuntu_18_04_64_20G_alibase_20200914.vhd"`): The ID of the image used to launch the ECS instance
* `instance_type` (default `"ecs.t5-lc1m2.small"`): The instance type of the ECS instance
* `internet_charge_type` (default `"PayByTraffic"`): The billing method for the public network bandwidth
* `internet_max_bandwidth_out` (default `5`): The maximum outbound bandwidth of the public network
* `jar_url` (required): The URL of the Jar package to be deployed
* `system_disk_category` (default `"cloud_efficiency"`): The category of the system disk
* `system_disk_size` (default `40`): The size of the system disk

## Managed Resources
* `alicloud_instance.example` from `alicloud`
* `alicloud_security_group.example` from `alicloud`
* `alicloud_vpc.example` from `alicloud`
* `alicloud_vswitch.example` from `alicloud`

