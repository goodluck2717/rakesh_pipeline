provider "aws" {
    region = "ap-south-1"  
}

resource "aws_instance" "jenkis" {
  ami           = "ami-0b9ecf71fe947bbdd" # ap-south-1
  instance_type = "t3.micro"
  tags = {
      Name = "jenkins-Instance"
  }
}
