variable "user_uuid" {
  type    = string
  description = "Unique user identifier"
  
  validation {
    condition = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "user_uuid must be in the format of a UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)"
  }
}

# variable "bucket_name" {
#   type        = string
#   description = "Name of the AWS S3 bucket"

#   validation {
#     condition     = can(regex("^[a-zA-Z0-9.-]{3,63}$", var.bucket_name))
#     error_message = "Bucket name must be 3-63 characters long and can only contain alphanumeric characters, hyphens, or periods. It must start and end with an alphanumeric character."
#   }
# }

variable "public_path" {
  description = "File path for the public directory"
  type        = string
}

variable "content_version" {
  description = "The content version (positive integer, starting from 1)"
  type        = number
  
  validation {
    condition     = can(regex("^[1-9][0-9]*$", var.content_version))
    error_message = "Content version must be a positive integer starting from 1."
  }
}
