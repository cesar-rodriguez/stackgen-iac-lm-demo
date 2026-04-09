module "stackgen_3e39bc8c-3c4a-4b14-b41f-ab626153be71" {
  source                = "./modules/aws_lambda"
  architecture          = "x86_64"
  authorization_type    = "NONE"
  cors                  = []
  create_function_url   = false
  description           = null
  environment_variables = null
  event_source_arn      = null
  event_source_mapping  = []
  filename              = null
  function_name         = "${var.lambda_function_name}"
  handler               = "main.lambda_handler"
  image_uri             = null
  log_format            = null
  log_group_name        = "${var.cloudwatch_log_group_name}"
  memory_size           = 128
  role                  = "${var.lambda_execution_role_arn}"
  runtime               = "python3.8"
  s3_bucket             = null
  s3_key                = null
  s3_object_version     = null
  system_log_level      = null
  tags                  = null
  timeout               = 3
}

module "stackgen_c99bfdd6-036a-49e1-8f6d-5eedcdc32c0e" {
  source            = "./modules/aws_cloudwatch_log_group"
  name              = "${var.cloudwatch_log_group_name}"
  retention_in_days = 7
  tags              = {}
}

