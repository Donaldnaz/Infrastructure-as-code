# EC2 Instance

resource "aws_instance" "ikenna" {
  ami                    = data.aws_ami.ikenna.id
  instance_type          = "t3.micro"
  key_name               = "ikenna"
  vpc_security_group_ids = [aws_security_group.secgroup.id]
  availability_zone      = "us-east-2a"

  tags = {
    Name    = "IAC_Instance"
    Project = "IAC"
  }
}

resource "aws_ec2_instance_state" "web" {
  instance_id = aws_instance.web.id
  state       = "stopped"
}
