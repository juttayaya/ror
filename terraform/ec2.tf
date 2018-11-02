provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "ror-sg" {
  name = "ror-sg"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

## VM definition
resource "aws_instance" "ror01" {
  ami = "ami-0c7d8678e345b414c"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.ror-sg.id}"]
  key_name = "ashton-kp"

}

output "ror01_ip" {
  value = "${aws_instance.ror01.public_ip}"
}


