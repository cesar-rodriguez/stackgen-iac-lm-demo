# SQS Queue Resource
resource "aws_sqs_queue" "this" {
  name                              = var.name
  visibility_timeout_seconds        = var.visibility_timeout_seconds
  message_retention_seconds         = var.message_retention_seconds
  max_message_size                  = var.max_message_size
  delay_seconds                     = var.delay_seconds
  receive_wait_time_seconds         = var.receive_wait_time_seconds
  fifo_queue                        = var.fifo_queue
  content_based_deduplication       = var.content_based_deduplication
  kms_master_key_id                 = var.use_custom_kms_key_for_encryption ? aws_kms_key.custom_sqs_kms_key[0].key_id : null
  kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds
  deduplication_scope               = var.fifo_queue ? var.deduplication_scope : null
  fifo_throughput_limit             = var.fifo_queue ? var.fifo_throughput_limit : null
  tags                              = var.tags
}


# SQS Queue Policy - Allowing specific AWS accounts to send and receive messages
resource "aws_sqs_queue_policy" "this" {
  queue_url = aws_sqs_queue.this.id
  policy    = data.aws_iam_policy_document.sqs_queue_policy.json
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "sqs_queue_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions = ["sqs:*"]
    resources = [
      aws_sqs_queue.this.arn
    ]
  }
}

# Optional Dead Letter Queue

# Dead Letter Queue Resource
resource "aws_sqs_queue" "dead_letter_queue" {
  count = var.setup_dead_letter_queue ? 1 : 0

  name       = var.ddl_queue_name
  fifo_queue = var.fifo_queue
}

# Provides a SQS Queue Redrive Allow Policy resource
resource "aws_sqs_queue_redrive_allow_policy" "this" {
  count = var.setup_dead_letter_queue ? 1 : 0

  queue_url = aws_sqs_queue.this.id

  redrive_allow_policy = jsonencode({
    redrivePermission = var.redrive_permission,
    sourceQueueArns   = [aws_sqs_queue.this.arn]
  })
}

# Allows you to set a redrive policy of an SQS Queue
resource "aws_sqs_queue_redrive_policy" "this" {
  count = var.setup_dead_letter_queue ? 1 : 0

  queue_url = aws_sqs_queue.this.id
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue[0].arn
    maxReceiveCount     = var.redrive_max_receive_count
  })
}

locals {
  kms_key_alias = replace(aws_sqs_queue.this.name, ".", "-")
}

resource "aws_kms_key" "custom_sqs_kms_key" {
  count                   = var.use_custom_kms_key_for_encryption ? 1 : 0
  description             = "Custom KMS key for SQS encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "a" {
  count         = var.use_custom_kms_key_for_encryption ? 1 : 0
  name          = "alias/sqs-${local.kms_key_alias}"
  target_key_id = aws_kms_key.custom_sqs_kms_key[0].key_id
}

resource "aws_kms_key_policy" "custom_sqs_key_policy" {
  count  = var.use_custom_kms_key_for_encryption ? 1 : 0
  key_id = aws_kms_key.custom_sqs_kms_key[0].id
  policy = data.aws_iam_policy_document.custom_sqs_key_policy.json
}

data "aws_iam_policy_document" "custom_sqs_key_policy" {
  statement {
    actions = [
      "kms:DescribeKey",
      "kms:ReEncrypt*",
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:GenerateDataKey*"
    ]
    effect    = "Allow"
    resources = ["*"]
    principals {
      type        = "Service"
      identifiers = ["sqs.amazonaws.com"]
    }
  }
  # Allows key management using AWS IAM
  statement {
    actions = [
      "kms:*"
    ]
    effect    = "Allow"
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}


