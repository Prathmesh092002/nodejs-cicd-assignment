resource "aws_cloudwatch_dashboard" "nodejs_dashboard" {
  dashboard_name = "nodejs-app-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x    = 0,
        y    = 0,
        width  = 12,
        height = 6,

        properties = {
          region = "ap-south-1"
          title  = "EC2 CPU Utilization"

          metrics = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "AutoScalingGroupName",
              aws_autoscaling_group.green_asg.name
            ]
          ]

          period      = 300
          stat        = "Average"
          view        = "timeSeries"
          stacked     = false
          annotations = {}
        }
      },
      {
        type = "metric",
        x    = 12,
        y    = 0,
        width  = 12,
        height = 6,

        properties = {
          region = "ap-south-1"
          title  = "Healthy Targets"

          metrics = [
            [
              "AWS/ApplicationELB",
              "HealthyHostCount",
              "TargetGroup",
              aws_lb_target_group.green_tg.arn_suffix,
              "LoadBalancer",
              aws_lb.app_alb.arn_suffix
            ]
          ]

          period      = 60
          stat        = "Average"
          view        = "timeSeries"
          stacked     = false
          annotations = {}
        }
      }
    ]
  })
}
