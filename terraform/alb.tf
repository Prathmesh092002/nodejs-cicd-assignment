resource "aws_lb" "app_alb" {
  name               = "nodejs-app-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  tags = {
    Name = "nodejs-app-alb"
  }
}
resource "aws_lb_target_group" "blue_tg" {
  name     = "nodejs-blue-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "nodejs-blue-tg"
  }
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue_tg.arn       
  }
}
#target_group_arn = aws_lb_target_group.green_tg.arn (green deplyment) change this to the blue