module "stackgen_8a65caca-be84-40a6-89b4-98b855ebccb9" {
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
  name                              = "simple-sqs"
  receive_wait_time_seconds         = 0
  redrive_max_receive_count         = 4
  redrive_permission                = "byQueue"
  setup_dead_letter_queue           = false
  tags                              = {}
  use_custom_kms_key_for_encryption = true
  visibility_timeout_seconds        = 30
}

