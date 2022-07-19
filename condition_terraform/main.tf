provider "aws" {                                                           
region = "us-east-1"                                                                                                                             
}   

 

variable instancetype {
type  = map 
default = {
"dev" = "t2.nano"
"test" = "t2.small"
"prod" = "t2.micro"

}

}
variable image {
type = list
default = ["ami-0cff7528ff583bf9a","ami-052efd3df9dad4825","ami-06640050dc3f556bb"]
}


variable input {}


resource "aws_instance" "dev" {
instance_type = var.instancetype["dev"]
ami = var.image[0]
count  = var.input  != "dev" ? 1 : 0

tags = {
Name = "dev-department"

}
}

resource "aws_instance" "test" {
instance_type = var.instancetype["test"]
ami = var.image[1]
count  = var.input  != "test" ? 2 : 0
tags = {
Name = "test-department"

}
}


resource "aws_instance" "prod" {
instance_type = var.instancetype["prod"]
ami = var.image[2]
count  = var.input  != "prod" ? 3 : 0

tags = {
Name = "prod-department"

}
}
