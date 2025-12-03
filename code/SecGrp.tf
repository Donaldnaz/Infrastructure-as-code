# Security Group

resource "aws_security_group" "secgroup" {
  name        = "secgroup"
  description = "Security_Group"

  tags = {
    Name = "firewall"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_my_ip" {
  security_group_id = aws_security_group.secgroup.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "net_80" {
  security_group_id = aws_security_group.secgroup.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "Allow_outbound_ipv4" {
  security_group_id = aws_security_group.secgroup.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # Equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "Allow_outbound_ipv6" {
  security_group_id = aws_security_group.secgroup.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # Equivalent to all ports
}
