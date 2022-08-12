resource "aws_vpc" "vpc" {
        cidr_block = "${var.cidr_block}"            ## this value will come from module call
        tags = {
        Name = "rps-vpc1"
        }
}

resource "aws_internet_gateway" "gateway"{
        vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "route"{
        route_table_id = aws_vpc.vpc.main_route_table_id
        destination_cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gateway.id
}

data "aws_availability_zones" "availableAZ"{}

#output "AZs" {
#       description = "lets find out no of  AZ in region"
#       value = data.aws_availability_zones.availableAZ.names
#}

resource "aws_subnet" "main" {
        vpc_id = aws_vpc.vpc.id
        cidr_block = "${var.cidr_block}"
        map_public_ip_on_launch = true
}

resource "aws_security_group" "default" {
        name = "http-https-ssh-allow"
        description = "Allow HTTP, HTTPS and SSH Connections"
        vpc_id = aws_vpc.vpc.id
        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
                from_port = 443
                to_port = 443
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }
}
resource "aws_instance" "ab_foo" {
  ami           = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  key_name = "test"
  subnet_id = aws_subnet.main.id
  security_groups = [aws_security_group.default.id]
  user_data = <<-EOF
    #!/bin/bash
    echo "installing apache"
    sudo yum install httpd -y
    echo "hello from Ec2 Instance" > /var/www/html/index.html
    sudo systemctl restart httpd
    sudo systemctl enable httpd
    EOF

  tags =  {
   Name = "ab_instance"
  }
}

