resource "aws_launch_template" "green_lt" {
  name_prefix   = "nodejs-green-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  user_data = base64encode(<<-EOF
        #!/bin/bash
         yum update -y
         amazon-linux-extras install docker -y
         systemctl start docker
         systemctl enable docker

        docker pull prathmesh1416/nodejs-app:latest
        docker run -d -p 3000:3000 prathmesh1416/nodejs-app:latest
EOF
)
}
