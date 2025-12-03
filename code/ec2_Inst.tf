# EC2 Instance

resource "aws_instance" "ikenna" {
  ami                    = var.ami[var.region]
  instance_type          = "t3.micro"
  key_name               = "ikenna"
  vpc_security_group_ids = [aws_security_group.secgroup.id]
  availability_zone      = var.zone1

  tags = {
    Name    = "IAC_Instance"
    Project = "IAC"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  connection {
    type        = "ssh"
    user        = var.webuser
    private_key = file("ikenna")
    host        = self.public_ip
  }

  provisioner "remote-exec" {

    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

}

resource "aws_ec2_instance_state" "web" {
  instance_id = aws_instance.ikenna.id
  state       = "running"
}
