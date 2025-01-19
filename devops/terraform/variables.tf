variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "ansible-control-node"
}

variable "memory" {
  description = "Amount of memory in MB"
  type        = number
  default     = 2048
}

variable "cpus" {
  description = "Number of CPUs"
  type        = number
  default     = 2
}

variable "disk_size" {
  description = "Disk size in MB"
  type        = number
  default     = 20000
}

variable "ubuntu_version" {
  description = "Ubuntu version to use"
  type        = string
  default     = "20.04"
}
