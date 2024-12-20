resource "aws_instance" "vault-ec2" {

  ami             = "ami-015f3596bb2ef1aaa"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.vault-sg.name]
  user_data       = file("./user_data/vault-setup.sh")

  tags = {
    created-by = "terrafrom"
  }
}

