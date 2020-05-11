
#This uses the default VPC.  It WILL NOT delete it on destroy.
resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "minecraft_server" {
  name        = "minecraft_server"
  description = "Allow ports for SSH, Minecraft Clients, and Minecraft RCON"
  vpc_id      = aws_default_vpc.default.id

  # ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  # game client
  ingress {
      from_port = 25565
      to_port = 25565
      protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
  }

  # rcon
  ingress {
      from_port = 25575
      to_port = 25575
      protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
  }

  # allow all internet traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
