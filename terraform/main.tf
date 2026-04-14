module "stackgen_06525f8d-78ea-47c3-b75b-32dadf4cbb2c" {
  source                            = "./modules/aws_sqs"
  content_based_deduplication       = false
  ddl_queue_name                    = null
  deduplication_scope               = "queue"
  delay_seconds                     = 0
  fifo_queue                        = false
  fifo_throughput_limit             = "perQueue"
  kms_data_key_reuse_period_seconds = 300
  max_message_size                  = 262144
  message_retention_seconds         = 345600
  name                              = "${var.app_name}-${var.environment}-queue"
  receive_wait_time_seconds         = 0
  redrive_max_receive_count         = 5
  redrive_permission                = "byQueue"
  setup_dead_letter_queue           = true
  tags                              = null
  use_custom_kms_key_for_encryption = true
  visibility_timeout_seconds        = 30
}

module "stackgen_3445c80e-798c-4965-82f6-af1314ede787" {
  source                = "./modules/aws_lambda"
  architecture          = "x86_64"
  authorization_type    = "NONE"
  cors                  = []
  create_function_url   = true
  description           = "Serverless Lambda handler for the application"
  environment_variables = null
  event_source_arn      = null
  event_source_mapping  = []
  filename              = null
  function_name         = "${var.app_name}-${var.environment}-handler"
  handler               = "main.lambda_handler"
  image_uri             = null
  log_format            = null
  log_group_name        = "${module.stackgen_bac83389-1494-441b-b8bd-2ecebeef10e2.name}"
  memory_size           = 256
  role                  = null
  runtime               = "python3.11"
  s3_bucket             = null
  s3_key                = null
  s3_object_version     = null
  system_log_level      = null
  tags                  = null
  timeout               = 10
}

module "stackgen_acb64804-5f52-43ba-84e5-545d06851293" {
  source     = "./modules/aws_api_gateway_http_api"
  name       = "${var.app_name}-${var.environment}-http-api"
  stage_name = "${var.environment}"
  tags       = null
}

module "stackgen_bac83389-1494-441b-b8bd-2ecebeef10e2" {
  source            = "./modules/aws_cloudwatch_log_group"
  name              = "/aws/lambda/${var.app_name}-${var.environment}-handler"
  retention_in_days = 14
  tags              = {}
}

module "stackgen_e22ab376-df5a-4d1d-8c42-efa686dc93cc" {
  source = "./modules/aws_dynamodb"
  attribute = [{
    name = "id"
    type = "S"
  }]
  billing_mode                   = "PROVISIONED"
  global_secondary_indexes       = []
  hash_key                       = "id"
  local_secondary_indexes        = []
  point_in_time_recovery_enabled = true
  range_key                      = ""
  read_capacity                  = 1
  server_side_encryption_enabled = true
  stream_view_type               = "NEW_IMAGE"
  table_name                     = "${var.app_name}-${var.environment}-table"
  tags                           = {}
  ttl                            = []
  write_capacity                 = 1
}

