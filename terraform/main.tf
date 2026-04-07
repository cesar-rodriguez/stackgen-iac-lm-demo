module "stackgen_004ade55-48f5-4e14-9094-d99de07069e3" {
  source                       = "./modules/aws_s3"
  block_public_access          = true
  bucket_name                  = "${var.environment}-${var.name}"
  bucket_policy                = ""
  enable_versioning            = true
  enable_website_configuration = false
  sse_algorithm                = "aws:kms"
  tags                         = {}
  website_error_document       = "404.html"
  website_index_document       = "index.html"
}

