variable "resource_group_name" {
  type        = string
  description = "Resource group name that is unique in your Azure subscription."
}

variable "resource_group_location" {
  type        = string
  default     = "Norway East"
  description = "Location of the resource group in your Azure subscription."
}

variable "environment_name" {
  type        = string
  description = "Name of the container app environment"
}

variable "app_name" {
  type        = string
  description = "Name of the container app that will be provisjoned"
}