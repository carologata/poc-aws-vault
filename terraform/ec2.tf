resource "aws_key_pair" "ec2_vault_public_key" {
  key_name   = "ec2-vault-public-key"
  public_key = file("~/.ssh/ec2_vault/id_rsa.pub") # Path to your public key file
}

resource "aws_instance" "vault-ec2" {

  ami             = "ami-015f3596bb2ef1aaa" #replace
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.vault-sg.name]
  key_name        = aws_key_pair.ec2_vault_public_key.key_name

  tags = {
    created-by = "terrafrom"
  }
}

