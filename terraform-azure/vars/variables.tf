variable "storageAccountName" {
  type        = string
  description = "Name"
  default     = "mysa1"
  validation {
    condition     = length(var.storageAccountName) <= 50
    error_message = "Name must be less than 50 characters"
  }
}

variable "storageAccountTier" {
  type        = string
  description = "Tier"
  default     = "Standard"
  validation {
    condition     = var.storageAccountTier == "Standard" || var.storageAccountTier == "Premium"
    error_message = "Either Standard or Premium"
  }
}

variable "location" {
  description = "Region - location"
  type        = string
  default     = "westeurope"
}

variable "account_replication_type" {
  description = "Account replication type"
  type        = string
  default     = "LRS"
}

variable "minimal_tls_version" {
  description = "Minimal TLS version"
  type        = string
  default     = "TLS1_2"
}

variable "route_tables" {
  description = "route tables"
  type        = any
  default     = {}
}

variable "network_security_groups" {
  description = "network security groups"
  type        = any
  default     = {}
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "Subnets"
  type        = any
}

variable "environment" {
  description = "Azure Environment"
  type        = string
}
