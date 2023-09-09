variable "project" {
  type        = string
  description = "Project name"
}

variable "env" {
  type        = string
  description = "Environment name"
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

variable "resource_group" {
  type        = string
  description = "Resource group"
}

variable "subnets" {
  type        = map(string)
  description = "Name to id map of subnet associated with NAT Gateway"
  default     = {}
}

variable "suffix" {
  type        = string
  description = "Resources suffix"
  default     = ""
}

variable "public_ip" {
  type = object({
    allocation_method = optional(string, "Static")
    sku               = optional(string, "Standard")
    zones             = optional(list(string), ["1"])
  })
  description = "Configuration options for public ip"
  default     = {}
}

variable "nat" {
  type = object({
    sku       = optional(string, "Standard")
    idle_time = optional(number, 10)
    zones     = optional(list(string), ["1"])
  })
  description = "Configuration options for azure nat gateway"
  default     = {}
}
