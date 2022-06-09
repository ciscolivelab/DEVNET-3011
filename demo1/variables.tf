variable "dcnm_username" {
  description = "dcnm username"
  type        = string
  default     = "admin"
}
variable "dcnm_password" {
  description = "dcnm password"
  type        = string
  sensitive   = true
}

variable "fabric" {
  description = "fabric name"
  type        = string
  default     = "myfabric"
}

variable "leaf" {
  type = list(string)
  default = [
  "Leaf-2",
  "leaf-3"
  ]
}

variable "int_grp" {
  description = "inteface group"
  type        = list(any)
  default = [
    "Ethernet1/4"
  ]
}
