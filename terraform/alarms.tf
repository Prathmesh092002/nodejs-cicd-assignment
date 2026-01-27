#alarm_description
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "nodejs-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.green_asg.name
  }

  alarm_description = "CPU > 70% for 10 minutes"
}
#alarm_description
resource "aws_cloudwatch_metric_alarm" "unhealthy_targets" {
  alarm_name          = "nodejs-unhealthy-targets"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 1

  dimensions = {
    TargetGroup  = aws_lb_target_group.green_tg.arn_suffix
    LoadBalancer = aws_lb.app_alb.arn_suffix
  }

  alarm_description = "No healthy targets behind ALB"
}
#alarm_description
resource "aws_cloudwatch_metric_alarm" "high_latency" {
  alarm_name          = "nodejs-high-latency"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 2

  dimensions = {
    LoadBalancer = aws_lb.app_alb.arn_suffix
  }

  alarm_description = "ALB response time > 2 seconds"
}
