module "stackgen_b6021ad8-e74f-4c4f-aad9-4db2fd318b02" {
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
  name                              = "cesar"
  receive_wait_time_seconds         = 0
  redrive_max_receive_count         = 4
  redrive_permission                = "byQueue"
  setup_dead_letter_queue           = false
  tags                              = {}
  use_custom_kms_key_for_encryption = true
  visibility_timeout_seconds        = 30
}

