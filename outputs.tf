output "bucket_name" {
  description = "Bucket name for our static website hosting"
  value = module.home_arcanum_hosting.bucket_name
}

output "cloudfront_url" {
  description = "The Cloudfront Distribution Domain Name"
  value = module.home_arcanum_hosting.domain_name
}

output "s3_website_endpoint" {
  description = "S3 Static Website Hosting endpoint"
  value = module.home_arcanum_hosting.website_endpoint
}

