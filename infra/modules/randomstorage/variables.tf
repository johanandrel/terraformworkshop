
variable "resource_group_name" {
  type        = string
  description = "Resource group name that is unique in your Azure subscription."
}

variable "location" {
  type        = string
  default     = "Norway East"
  description = "Location in your Azure subscription."
}

variable "tags" {
  type        = map(string)
  description = "Tags to put metadata on the resource."
}