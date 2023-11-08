variable "vwan-resource-group-name" {
  type    = string
  default = "chkp-tf-rg-vwan-demo"
}

variable "vwan-name" {
  type    = string
  default = "chkp-tf-vwan-demo"
}

variable "vwan-hub-name" {
  type    = string
  default = "chkp-tf-vwan-hub-demo"
}

variable "vwan-address-prefix" {
  type    = string
  default = "10.123.0.0/16"
  validation {
    condition     = can(cidrhost(var.vwan-address-prefix, 0))
    error_message = "Please provide a valid CIDR specification for the VWAN address space"
  }
}

variable "vwan-location" {
  type    = string
  default = "UK South"
}

variable "chkp-managed-app-name" {
  type    = string
  default = "chkp-tf-vwan-managed-app-nva-demo"
}

variable "chkp-managed-app-rg-name" {
  type    = string
  default = "chkp-tf-vwan-managed-app-rg-demo"
}

variable "chkp-cloudguard-version" {
  type    = string
  default = "R81.10 - Pay As You Go (NGTP)"
  validation {
    condition     = contains(["R81.10 - Pay As You Go (NGTP)", "R81.20 - Pay As You Go (NGTP)", "R81.10 - Pay As You Go (NGTX)", "R81.20 - Pay As You Go (NGTX)"], var.chkp-cloudguard-version)
    error_message = "Valid values for CloudGuard version are 'R81.10 - Pay As You Go (NGTP)','R81.20 - Pay As You Go (NGTP)','R81.10 - Pay As You Go (NGTX)' and 'R81.20 - Pay As You Go (NGTX)'"
  }
}

variable "chkp-scale-unit" {
  type    = number
  default = 2
}
variable "chkp-bootstrap-script" {
  type    = string
  default = ""
}
variable "chkp-admin-shell" {
  type    = string
  default = "/etc/cli.sh"
  validation {
    condition     = contains(["/etc/cli.sh", "/bin/bash", "/bin/tcsh", "/bin/csh"], var.chkp-admin-shell)
    error_message = "Valid shells are '/etc/cli.sh', '/bin/bash', '/bin/tcsh', '/bin/csh'"
  }
}
variable "chkp-sic-key" {
  type      = string
  default   = ""
  sensitive = true
}
variable "chkp-ssh-public-key" {
  type    = string
  default = ""
}
variable "chkp-bgp-asn" {
  type    = number
  default = "64512"
}
variable "chkp-nva-name" {
  type    = string
  default = "chkp-tf-vwan-nva"
}

variable "chkp-custom-metrics" {
  type    = string
  default = "yes"
  validation {
    condition     = contains(["yes", "no"], var.chkp-custom-metrics)
    error_message = "Valid options are string('yes' or 'no')"
  }
}

variable "chkp-smart1-cloud-token-a" {
  type    = string
  default = ""
}

variable "chkp-smart1-cloud-token-b" {
  type    = string
  default = ""
}

variable "chkp-smart1-cloud-token-c" {
  type    = string
  default = ""
}

variable "chkp-smart1-cloud-token-d" {
  type    = string
  default = ""
}
