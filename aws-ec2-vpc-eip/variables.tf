variable "count" {
  type = "string"
  description = "How many EC2 instances to deploy"

}

variable "instance_name" {
    type = "string"
    description = "Instance Name"
}


variable "aws_amis" {
    description = "AMI to use"
}

variable "instance_type" {
    type = "string"
    description = "EC2 instance type"
}

variable "key_name" {
    type = "string"
    description = "key-name to deploy with"
}


variable "subnet_id" {
    type = "string"
    description = "Resource Subnet ID"
}

variable "security_groups" {
    type = "string"
    description = "Resource secutiry group/s"
}

variable "aws_route53_zone_id" {
    type = "string"
    description = "Route53 Zone ID"
}


variable "aws_access_key" {
    type = "string"
    decscription = "Access key"
}

variable "aws_secret_key" {
    type = "string"
    description = "Secret Key"
}
