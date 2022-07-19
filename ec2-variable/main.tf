provider "aws" {
region  =  "us-east-1"
}



resource "aws_instance" "new" {

ami    		= var.image
instance_type 	= var.instancetype


tags =  {

Name = "New-instance"

}

}


resource  "aws_instance" "old" {

ami	= var.image
instance_type 	= var.instancetype


tags = {

Name = "old-instance"


}


}
