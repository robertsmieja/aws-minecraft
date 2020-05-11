data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # canonical

  filter {
    name   = "name"
    values = ["*ubuntu-focal-20.04-amd64-server*"]
  }

  filter {
      name = "architecture"
      values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_ebs_volume" "minecraft_server_data" {
  availability_zone = var.availability_zone
  size              = 8 # GiB
  type = "standard"

  tags = {
    Name = "minecraft-server"
  }
}


resource "aws_instance" "minecraft_server" {
  ami                    = data.aws_ami.ubuntu.id
  availability_zone      = var.availability_zone
  instance_type          = "t3.nano"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.minecraft_server.id]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt upgrade -y",
      "sudo apt install ansible -y"
    ]
  }

  root_block_device {
      delete_on_termination = true
      volume_size = 8 # GiB
      volume_type = "standard"
  }
}

resource "aws_volume_attachment" "minecraft_server_data" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.minecraft_server_data.id
  instance_id = aws_instance.minecraft_server.id
}
