resource "aws_vpc" "ab_myvpc1" {
 cidr_block = "10.0.0.0/16"
 tags = {
   Name = "testing"
}
}
resource "aws_internet_gateway" "ab_myigw" {
 vpc_id = aws_vpc.ab_myvpc1.id
 tags = {
  Name = "myigw"
}
}

resource "aws_subnet" "ab_mypub1" {
  vpc_id = aws_vpc.ab_myvpc1.id
  map_public_ip_on_launch = true
  cidr_block = "10.0.10.0/24"
  tags = {
   Name = "pubsub"
 }
}
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.ab_myvpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ab_myigw.id
  }
}

resource "aws_route_table_association" "ab_associate" {
  subnet_id      = aws_subnet.ab_mypub1.id
  route_table_id = aws_route_table.example.id
}

resource "aws_instance" "ab_foo" {
  ami           = "${var.aminame["${var.myregion}"]}"
  instance_type = "t2.micro"
  key_name = "test"
  subnet_id = aws_subnet.ab_mypub1.id
  security_groups = [aws_security_group.ab_sg.id]
  user_data = <<-EOF
    #!/bin/bash
    echo "installing apache"
    sudo yum install httpd -y
    echo "hello from Ec2 Instance" > /var/www/html/index.html
    sudo systemctl restart httpd
    sudo systemctl enable httpd
    EOF

  tags =  {
   Name = "ab_istance1"
  }
}

resource "aws_security_group" "ab_sg" {
  name        = "allow_ssh_http"
  description = "Allow ssh http inbound traffic"
  vpc_id      = aws_vpc.ab_myvpc1.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh_http"
  }
}

