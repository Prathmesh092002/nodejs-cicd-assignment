resource "aws_autoscaling_group" "green_asg" {
  name                = "nodejs-green-asg"
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1

  vpc_zone_identifier = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  target_group_arns = [
    aws_lb_target_group.green_tg.arn
  ]

  launch_template {
    id      = aws_launch_template.green_lt.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "nodejs-green-instance"
    propagate_at_launch = true
  }
}