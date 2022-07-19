provider "aws" {

region   = "us-east-1"


}


variable "elbname" {
   type = string

}

variable "azname" {
type = list 
default = ["us-east-1a", "us-east-1b", "us-east-1c"]

}

variable "timeout" {
type = number

}

variable "instancetype" {
type = list
default = ["t2.micro","t2.medium","t2.small", "dev","test" , "prod"]

}

variable "tagname" {
type = list

default = ["dev-dep","test-dep","prod-dep"]

}

variable "mapvar" {
type = map
default = {

us-east-1a = "t2.micro"
us-east-1b = "t2.small"
us-east-1c = "t2.nano"


}

}



# Create a new load balancer
resource "aws_elb" "bar" {
  name               = var.elbname
  availability_zones = var.azname


  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = var.timeout
  connection_draining         = true
  connection_draining_timeout = var.timeout

  tags = {
    Name = "vishalshukla"
  }
}

resource "aws_instance" "dev-team" {
ami = "ami-0cff7528ff583bf9a"
instance_type = var.mapvar["us-east-1a"]

tags = {
Name = var.tagname[0]

}


}


resource "aws_instance" "test-team" {
ami = "ami-0cff7528ff583bf9a"
instance_type = var.mapvar["us-east-1b"]

tags = {
Name = var.tagname[1]

}


}

resource "aws_instance" "prod-team" {
ami = "ami-0cff7528ff583bf9a"
instance_type = var.mapvar["us-east-1c"]

tags = {
Name = var.tagname[2]


}


}
