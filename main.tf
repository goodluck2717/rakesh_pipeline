provider "aws" {
    region = "eu-north-1"  
}

resource "aws_instance" "foo" {
  ami           = "ami-04e4606740c9c9381" # eu-north-1
  instance_type = "t3.micro"
  tags = {
      Name = "TF-Instance"
  }
}
