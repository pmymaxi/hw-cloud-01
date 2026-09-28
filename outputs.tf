output "vpc" {
  description = "VPC module output"
  value = module.vpc.network
}
output "route_table" {
  description = "Route tables VPC"
  value = module.vpc.route_table
}