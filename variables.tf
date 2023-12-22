variable "nat_gateway_name" {
  type = string
  description = "NAT Gateway name"
}

variable "resource_group" {
  type        = string
  description = "Resource group"
}

variable "location" {
  type        = string
  description = "Azure location"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
  default     = {}
}

variable "nat_gateway_public_ip_name" {
  type = string
  description = "NAT Gateway public ip resource name"
  default = null
}

variable "subnets" {
  type        = map(string)
  description = "Name to id map of subnet associated with NAT Gateway"
  default     = {}
}

variable "public_ip_configuration" {
  type = object({
    allocation_method = optional(string, "Static")
    sku               = optional(string, "Standard")
    zones             = optional(list(string), [])
  })
  description = "Configuration options for public ip"
  default     = {}
}

variable "nat_gateway_configuration" {
  type = object({
    sku       = optional(string, "Standard")
    idle_time = optional(number, 10)
    zones     = optional(list(string), [])
  })
  description = "Configuration options for azure nat gateway"
  default     = {}
}
