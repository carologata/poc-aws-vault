packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "= 1.3.4"
    }
  }
}

source "amazon-ebs" "vault-ebs" {
  ami_name      = "vault-ami-{{timestamp}}"
  instance_type = "t2.micro"
  region        = var.region
  source_ami    = "ami-015f3596bb2ef1aaa" # Ubuntu
  ssh_username  = "vault-admin"
}

build {
  sources = ["source.amazon-ebs.vault-ebs"]

  provisioner "shell" {
    inline = [
      "echo 'Configuring Vault...'",
      "sudo curl --silent -Lo /tmp/vault.zip https://releases.hashicorp.com/vault/1.18.3/vault_1.18.3_linux_amd64.zip"
      "cd /tmp"
      "sudo unzip vault.zip"
      "sudo mv vault /usr/local/bin"
    ]
  }
}

