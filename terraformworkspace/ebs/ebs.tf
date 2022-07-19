provider "aws" {                                                           
  region = "ap-south-1"                                                                                                                              
}                                                                          

resource "aws_ebs_snapshot_copy" "example_copy" {
  source_snapshot_id = "snap-0432b4f85012fbe05"
  source_region      = "us-east-1"

  tags = {
    Name = "HelloWorld_copy_snap"
  }
}

