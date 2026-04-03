resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "nimbus-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    AutoScalingGroupName = module.compute.autoscaling_group_name
  }

  alarm_description = "Alarm when CPU exceeds 70%"

  tags = {
    Name        = "nimbus-high-cpu"
    Environment = var.environment
    Project     = "nimbus"
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  alarm_name          = "nimbus-alb-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 1

  dimensions = {
    LoadBalancer = module.compute.alb_arn_suffix
  }

  alarm_description = "ALB 5XX errors detected"

  tags = {
    Name        = "nimbus-alb-5xx-errors"
    Environment = var.environment
    Project     = "nimbus"
  }
}
