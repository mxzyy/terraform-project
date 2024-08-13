terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
    pm_tls_insecure     = var.PM_TLS_INSECURE
    pm_api_url          = var.PM_URL
    pm_api_token_id     = var.PM_API_TOKEN_ID
    pm_api_token_secret = var.PM_API_TOKEN_SECRET
    pm_parallel     = 10
    pm_timeout      = 600
    pm_debug = true
    pm_log_enable = true
    pm_log_file   = "terraform-plugin-proxmox.log"
    pm_log_levels = {
      _default    = "debug"
      _capturelog = ""
    }
}

resource "proxmox_vm_qemu" "Dockers" {
    target_node = "prx"
    count       = var.VM_TOTAL
    name        = "${var.VM_NAME}-${count.index + 1}"
    clone       = var.VM_TEMPLATE
    vmid        = 816 + count.index
    os_type     = "ubuntu"
    cores       = var.VM_CPU_CORES
    sockets     = var.VM_CPU_SOCKETS
    cpu         = "host"
    memory      = var.VM_RAM
    scsihw      = "virtio-scsi-single"
    bootdisk    = "scsi0"
    agent       = 1
    full_clone  = var.VM_FULL_CLONE
    define_connection_info = true

    disks {
        ide {
            ide0 {
                cloudinit {
                    storage = "local-lvm"
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                    size            = 32
                    storage         = "local-lvm"
                    iothread        = true  
                    discard         = true
                    emulatessd      = true  
                }
            }
        }
    }

    network {
        model  = "virtio"
        bridge = "vmbr0"
    }

    lifecycle {
        ignore_changes = [
        network,
        ]
    }

    ciuser     = var.CI_USER
    cipassword = var.CI_PASSWORD
    ipconfig0  = "ip=dhcp"
    nameserver = "1.1.1.1"
    sshkeys    = <<EOF
      ${var.SSH_PUBKEY}
      EOF
    
    provisioner "remote-exec" {
      connection {
        host = self.ssh_host
        user = "user"
        private_key = file("id_rsa")
      }
      inline = [
        "sleep 5m", 
        "sudo apt update",
       ]
    }

}

