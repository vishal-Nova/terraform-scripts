provider "aws" {
region = "us-east-1"
}

variable "instancetag" {
type = list 
default = ["dev-dep","test-dep","prod-dep"]
}

variable "instancetype" {
type = list 
default = ["t2.nano", "t2.small", "t2.medium"]

}



resource "aws_instance" "dev-team" {
ami  = "ami-0cff7528ff583bf9a"
instance_type = var.instancetype[count.index]
count = 3


tags = {
Name  = var.instancetag[count.index]


}

}
