packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.2.0"
    }
  }
}

source "amazon-ebs" "linux" {
  region        = "us-east-1"
  instance_type = "t3.micro"
  source_ami    = "ami-0fc5d935ebf8bc3bc" # Amazon Linux 2023 (example)
  ssh_username  = "ec2-user"
  ami_name      = "myapp-ami-{{timestamp}}"
}

build {
  sources = ["source.amazon-ebs.linux"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y docker",
      "sudo systemctl enable docker"
    ]
  }
}

