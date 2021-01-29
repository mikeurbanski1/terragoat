resource "aws_sqs_queue" "q" {
  name                       = "${var.env}_${var.region}_pairs_dlp_no4"
  visibility_timeout_seconds = var.visibility_timeout_seconds
  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  message_retention_seconds  = var.message_retention_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  tags = {
    region                      = var.region
    env                         = var.env
    owner                       = "takashi.narikawa"
    team                        = "sre_team"
    description                 = "data-lifecycle-policyのNo4適応用"
    sensitivity                 = var.tag["sensitivity"][1]
    alert_window_hour           = 24
    is_research_and_development = true
  }
}
