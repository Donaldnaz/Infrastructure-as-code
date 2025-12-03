variable "region" {
  default = "us-east-2"
}

variable "zone1" {
  default = "us-east-2a"
}

variable "ami" {
  description = "Map of AWS regions to Ubuntu AMI IDs"
  type        = map(any)
  default = {
    us-east-1 = "ami-07df274a488ca919a"
    us-east-2 = "ami-0f5fcdfbd140e4ab7"
    us-west-1 = "ami-0cc7a0c8d6e4b2162"
    us-west-2 = "ami-09ebacdc178ae23d0"
  }
}

variable "webuser" {
  default = "ubuntu"
}