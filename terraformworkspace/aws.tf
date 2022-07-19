provider "aws" {
  region = "us-east-1"
}



resource "aws_instance" "india" {
  ami                    = "ami-0cff7528ff583bf9a" # us-east-1
  instance_type          = "t2.micro"
  key_name               = "VishalShukla"
  vpc_security_group_ids = [aws_security_group.vishalshukla.id]


  tags = {

    Name = "vishalshuklaindia"

  }

}
resource "aws_key_pair" "VishalShukla" {
  key_name   = "VishalShukla"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDohCKzX+mQOtY45cGlS1aLTjADGDKh9i7zB9GsCSU+hsXU0jdXNUShhVZFSHj43Fq2j3/nh9SCaF+Wn8XjOK/LqVSDQVF/EfwPkkf8NpDY12fGp3Pghb5PiphA3PghA1Xdg557wJX6Opq491rXhN90KspE2TTMb/umgHI2IOQiNNFjEcfCN1hPgS2SCLOEq3C2sVltUt1lbsJLPf0Ucjv028UR37nokiSZbm3KakI/dd+NuXO6B4LjyhV40bZUCtOeTbxuBWdF/191BTdPLJGv6HOaA3oQ0BDqxaBz/LiXbmQRGkuzQ+QiCF3l/vJTR+fx0tavy+JMG/vDB9JbzmdeIzoZk35RlXzzJ8N6W+YTmG8ZbITxaqmy6guRqkko7812DQD8pCu/eFhXtV5yRMCGwZ3PB7aw396b4Jlp2HM0QnzBx8GyviFx10V3ZdI/Gy9TtA8n4UTvSWWrQ4pxlaqaqdINsOESH6S0Z5MW0mC16CXapcdFzPFtfq0VLWG9ZMk= root@TEQO-LT-070"
}


resource "aws_eip" "vishalshuklaeip" {
  instance = aws_instance.india.id
  vpc      = true
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "vishalshukla" {
  name        = "VishalShukla"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "VishalShukla"
  }
}
