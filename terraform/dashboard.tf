resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "nimbus-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          title = "ALB Request Count"
          metrics = [
            [
              "AWS/ApplicationELB",
              "RequestCount",
              "LoadBalancer",
              module.compute.alb_arn_suffix
            ]
          ]
          period = 300
          stat   = "Sum"
          region = "eu-central-1"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          title = "ALB Target Response Time"
          metrics = [
            [
              "AWS/ApplicationELB",
              "TargetResponseTime",
              "LoadBalancer",
              module.compute.alb_arn_suffix
            ]
          ]
          period = 300
          stat   = "Average"
          region = "eu-central-1"
        }
      }
    ]
  })
}
