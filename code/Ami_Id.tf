# AMI ID for EC2 Instance

data "aws_ami" "ikenna" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

output "Inst_ID" {
  description = "AMI ID OF UBUNTU INSTANCE"
  value       = data.aws_ami.ikenna.id
}
