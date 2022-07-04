# launch a server on aws

# who is the cloud provider AWS
provider "aws" {

# where do you want to create resources eu-west-1
  region = "eu-west-1"
}
################################# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name        = "${var.infra_env}-vpc"
    Environment = var.infra_env
  }
}

################################# PUBLIC SUBNET
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = "eu-west-1a"
  cidr_block = "10.0.142.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.infra_env}-public-subnet"
    Environment = var.infra_env
  }
}

resource "aws_subnet" "public2" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = "eu-west-1b"
  cidr_block = "10.0.142.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.infra_env}-public-subnet"
    Environment = var.infra_env
  }
}

################################# PRIVATE SUBNET
resource "aws_subnet" "private" {

  vpc_id = aws_vpc.vpc.id
  availability_zone = "eu-west-1a"
  cidr_block = "10.0.141.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.infra_env}-private-subnet"
    Environment = var.infra_env
#    Subnet = "${each.key}-${each.value}"
  }
}

################################# INTERNET GATEWAY
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.infra_env}-igw"
    Environment = var.infra_env
  }
}

################################# ROUTE TABLE
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "${var.infra_env}-route-table"
    Environment = var.infra_env
  }
}

################################# ROUTE FROM (PUBLIC)
resource "aws_route" "public_internet_gateway" {
  route_table_id = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.ig.id
}

################################# SUBNET ASSOCIATIONS (PUBLIC)
resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public-route-table.id
}

################################# SECURITY GROUP/S
resource "aws_security_group" "allow_nginx" {
  name = "allow_nginx"
  description = "Allow port 80"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_nginx"
  }
}

resource "aws_security_group" "allow_node" {
  name = "allow_node"
  description = "Allow port 3000"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 3000
    protocol  = "tcp"
    to_port   = 3000
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_node"
  }
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  description = "Allow port 22"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_mongodb" {
  name = "allow_mongodb"
  description = "Allow port 27017"
  vpc_id = aws_vpc.vpc.id

#  for_each = aws_instance.app_instance

  ingress {
    from_port = 27017
    protocol  = "tcp"
    to_port   = 27017
    cidr_blocks = ["${aws_instance.app_instance.private_ip}/32"]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_mongodb"
  }
}

## what type server - ubuntu 18.04 LTS ami
resource "aws_instance" "app_instance" {

# size of the server - t2.micro
#  for_each = aws_subnet.public
  ami = var.node_ami_id
  instance_type = "t2.micro"
  key_name = var.aws_key
# do we need it to have a public access
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_nginx.id, aws_security_group.allow_node.id, aws_security_group.allow_ssh.id]

# what do we want to name it
	tags = {
		Name = "eng114_florent_terraform_app"
	}
}

resource "aws_instance" "db_instance" {
  ami = var.db_ami_id
  instance_type = "t2.micro"
  key_name = var.aws_key
#  for_each = aws_security_group.allow_mongodb
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_mongodb.id, aws_security_group.allow_ssh.id]
  tags = {
    Name = "eng114_florent_terraform_db"
  }
}

resource "aws_instance" "controller" {
  ami = var.ubuntu_ami
  instance_type = "t2.micro"
  key_name = var.aws_key
  associate_public_ip_address = true
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Name = "eng114_florent_ansible_controller"
  }
}

resource "aws_launch_template" "app_lt" {
  name   = "florent_terraform_lt"
  image_id      = aws_instance.app_instance.ami
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_nginx.id, aws_security_group.allow_node.id, aws_security_group.allow_ssh.id]
}

resource "aws_autoscaling_group" "bar" {
  name = "eng114_florent_terraform_app_asg"
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1
  vpc_zone_identifier = [aws_subnet.public.id]
#  load_balancers = [aws_lb.app-lb.id]
#  vpc_zone_identifier = [aws_subnet.public.id]
  tag {
    key                 = "Name"
    propagate_at_launch = false
    value               = "eng114_florent_app"
  }
  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }
}

resource "aws_launch_template" "db_lt" {
  name   = "florent_db_lt"
  image_id      = aws_instance.db_instance.ami
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_mongodb.id, aws_security_group.allow_ssh.id]
}

resource "aws_autoscaling_group" "db_asg" {
  name = "eng114_florent_terraform_db_asg"
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1
  vpc_zone_identifier = [aws_subnet.private.id]
#  load_balancers = [aws_lb.app-lb.id]
#  vpc_zone_identifier = [aws_subnet.public.id]
  tag {
    key                 = "Name"
    propagate_at_launch = false
    value               = "eng114_florent_db"
  }
  launch_template {
    id      = aws_launch_template.db_lt.id
    version = "$Latest"
  }
}

resource "aws_lb" "app-lb" {
  name = "app-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.allow_node.id, aws_security_group.allow_nginx.id, aws_security_group.allow_ssh.id]
  subnets = [
    aws_subnet.public2.id,
    aws_subnet.public.id
  ]

  tags = {
    Name = "eng114_florent_lb"
  }
}