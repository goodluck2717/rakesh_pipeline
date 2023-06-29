provider "aws" {
    region = "ap-south-1"  
}

resource "aws_key_pair" "rakesh" {
  key_name   = "rakesh"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDYX8VA9dv+Y9rjvwNgIAYfiOZuqFZkJH+PnmwXhSdgjfXlkUylTZkFXmm7h6exyRbR8dDqGZx4Sjcc7wPmNQ+z6XYT/enGCvylRYc7LE3e+U1SH+YJ8CWEqZWmxGWz9zFZpZ3zWeQaiw+l+HnZV6nxuoj7VlwuAq/V6X3RjegJa4TG5BHsM3tdYd+Tp2AfXkHs1CvkKNiw2eLfRTE/B7WyWT0rQOBQGdUQaa9dtzWj20+MxZYsqXe9Cxx9t2MMY8C+vt0u99fvNOjmsCTBzq84WSQ6yR2eVB6wI38RDOTlAscphuv219caCTib2gZdZsv0qAabWCnhiGPF0Fryd5PoZAbhWJN72O6q1ezFRbjubnsifMoTH4IQxoZhDsdJ/hgmc/07ojsYRIAIfcZD4gC5dNR98jUU2C868AEXqzita5Y04Muu7Blm7pJDamLwUPO9+V7LIlG43if9a3eokxsGsCiK58/GETrttt+N/3wkXFhmoHbbtSgNBcVIZzgQVs0= ec2-user@ip-172-31-43-186.eu-north-1.compute.internal"
}

resource "aws_instance" "web" {
  ami                    = "ami-057752b3f1d6c4d6c"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-0e3e677c606646bd7"
  key_name               = "rakesh"
  vpc_security_group_ids = ["sg-07b2f51f43c970c5e"]


  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }



  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/home/ec2-user/rakesh_pipeline/rakesh")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo mv /tmp/index.html /var/www/html/",
      "sudo systemctl restart httpd"
    ]
  }


  tags = {
    Name = "HelloWorld"
  }
}

