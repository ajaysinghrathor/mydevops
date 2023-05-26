variable "program" { default = "PES" }
variable "owner" { default = "demo" }
variable "location" { default = "south india" }
variable "enviroment" { default = "DEV" }


variable "azurerm_virtual_network" {
  default = "10.10.0.0/16"
}

variable "azurerm_subnet" {
  default = "10.10.1.0/24"
}

variable "azurerm_network_security_group" {
  default = {
    100 = "80",
    101 = "8080",
    102 = "443"
    103 = "22"
  }

}

variable "subscription_id" {
  
}

variable "tenant_id" {
  
}



