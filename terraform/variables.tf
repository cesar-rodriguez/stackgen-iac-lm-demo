
################################################################################

variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "dev"
}

variable "service_name" {
  description = "Service name used for resource naming"
  type        = string
  default     = "cesar-microservice"
}

variable "name" {
  description = "Legacy resource naming variable mapped to the service name"
  type        = string
  default     = "cesar-microservice"
}

