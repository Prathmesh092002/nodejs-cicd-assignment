data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "app_lt" {
  name_prefix   = "nodejs-app-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

user_data = base64encode(<<-EOF
        #!/bin/bash
         yum update -y
         amazon-linux-extras install docker -y
         yum install -y amazon-cloudwatch-agent
         systemctl start docker
         systemctl enable docker

        docker pull prathmesh1416/nodejs-app:latest
        docker run -d -p 3000:3000 prathmesh1416/nodejs-app:latest
EOF
)


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "nodejs-app-instance"
    }
  }
}
