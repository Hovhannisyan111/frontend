output "frontend_service_url" {
  value = "http://${module.lb.lb_dns_name}"
}

output "frontend_ecr_url" {
  value = module.ecr.frontend_ecr_url
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

