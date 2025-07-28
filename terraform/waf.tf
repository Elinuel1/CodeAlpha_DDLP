resource "aws_wafv2_web_acl" "api_waf" {
  name        = "secure-api-waf"
  scope       = "REGIONAL"
  description = "WAF for API Gateway to block common attacks"
  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "secureApiWaf"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "AWS-AWSManagedRulesSQLiRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "sqlInjection"
      sampled_requests_enabled   = true
    }
  }
}
