variable "PM_URL" {
    type = string
    sensitive = false
    description = "URL Proxmox"
    default = "https://0.0.0.0:8006/api2/json"
}


variable "PM_API_TOKEN_ID" {
    type = string
    sensitive = false
    description = "Proxmox Username"
    default = "root@pam"
}

variable "PM_API_TOKEN_SECRET" {
    type = string
    sensitive = true
    description = "Proxmox Secret Token"
}

variable "PM_TLS_INSECURE" {
    type = bool
    sensitive = false
    description = "Proxmox TLS/SSL is it default or no"
    default = true
}

variable "VM_TARGET_NODE" {
    type = string
    sensitive = false
    description = "Target Node to create"
    default = "pve"
}

variable "VM_NAME" {
    type = string
    sensitive = false
    description = "VM Name"
    default = "vm"
}

variable "VM_TOTAL" {
    type = number
    sensitive = false
    description = "Total VM that will be created."
}

variable "VM_START_ID" {
    type = number
    sensitive = false
    description = "Number ID to start with"
    default = 900
}

variable "VM_TEMPLATE" {
    type = string
    sensitive = false
    description = "VM Template name to clone"
    default = "jalanbuntu"
}

variable "VM_CPU_CORES" {
    type = number
    sensitive = false
    description = "Total of VM Cores"
    default = 1
}

variable "VM_CPU_SOCKETS" {
    type = number
    sensitive = false
    description = "Total of VM Sockets"
    default = 1
}

variable "VM_RAM" {
    type = number
    sensitive = false
    description = "VM Ram Total"
    default = 1024 # 1 GB
}

variable "VM_FULL_CLONE" {
    type = bool
    sensitive = false
    description = "Full clone / no"
    default = true
}

variable "CI_USER" {
    type = string
    sensitive = false
    description = "Username that will be created on vm"
    default = ""
}

variable "CI_PASSWORD" {
    type = string
    sensitive = true
    description = "Pass that will be created on vm"
}

variable "SSH_PUBKEY" {
  type = string
  sensitive = true
  description = "PUBKEY FOR SSH"
}
