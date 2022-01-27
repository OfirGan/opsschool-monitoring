variable "aws_region" {
  default = "us-east-1"
}

variable "monitor_instance_type" {
  default = "t2.micro"
}

variable "monitor_servers" {
  default = "1"
}

variable "owner" {
  default = "Monitoring"
}

variable "vpc_id" {
  description = "ID of vpc to create instances in in the format vpc-xxxxxxxx"
  default     = "vpc-0825e8644aecb14ec"
}

variable "private_key_file" {
  type        = string
  description = "Private Key File Path"
  default     = "C:\\Downloads\\OpsSchool\\Private-Keys\\Monitoring_Private_Key.pem"
}
