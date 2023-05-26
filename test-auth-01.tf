terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.57.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "rg_sap_001" {
  name     = "rg_sap_001"
  location = "SouthEast Asia"
}

resource "azurerm_virtual_network" "vnet_sap_001" {
  name                = "vnet_sap_001"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_sap_001.location
  resource_group_name = azurerm_resource_group.rg_sap_001.name
}

resource "azurerm_subnet" "subnet_sap_001" {
  name                 = "subnet_sap_001"
  resource_group_name  = azurerm_resource_group.rg_sap_001.name
  virtual_network_name = azurerm_virtual_network.vnet_sap_001.name
  address_prefixes     = ["10.0.1.0/24"]
  
}

resource "azurerm_linux_virtual_machine_scale_set" "vm_scaleset_sap_001" {
  name                = "vm_scaleset_sap_001"
  resource_group_name = azurerm_resource_group.rg_sap_001.name
  location            = azurerm_resource_group.rg_sap_001.location
  sku = "Standard_F2"
  instances           = 1
    
  upgrade_mode = "Automatic"

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  admin_username      = "adminuser"
  admin_password = "manageus@123"
  computer_name_prefix = "host"
  disable_password_authentication = false
 # admin_ssh_key {
 #   username   = "adminuser"
 #   public_key = file("${path.module}/id_rsa.pub")
 # }
  custom_data = filebase64("${path.module}/install_httpd.sh")

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "ni_sap_001"
    primary = true
    network_security_group_id = azurerm_network_security_group.nsg_sap_001.id
    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.subnet_sap_001.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.lb_bknd_add_pool_sap_001.id]
      #load_balancer_inbound_nat_rules_ids = 
    }
  }

}

resource "azurerm_virtual_machine_scale_set_extension" "vm_scaleset_xtnsn_sap_001" {
  name                         = "vm_scaleset_xtnsn_sap_001"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.vm_scaleset_sap_001.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.0"
  settings = jsonencode({
    "commandToExecute" = "echo $HOSTNAME"
  })
}

resource "azurerm_public_ip" "publicid_sap_001" {
  name                = "publicid_sap_001"
  location            = azurerm_resource_group.rg_sap_001.location
  resource_group_name = azurerm_resource_group.rg_sap_001.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "lb_sap_001" {
  name                = "lb_sap_001"
  location            = azurerm_resource_group.rg_sap_001.location
  resource_group_name = azurerm_resource_group.rg_sap_001.name

  frontend_ip_configuration {
    name                 = "lb_frontend_publicip_sap_001"
    public_ip_address_id = azurerm_public_ip.publicid_sap_001.id
  }
}

resource "azurerm_lb_probe" "lb_probe_sap_001" {
  loadbalancer_id = azurerm_lb.lb_sap_001.id
  name            = "lb_probe_sap_001"
  port            = 80
  protocol = "Tcp"
}
resource "azurerm_lb_backend_address_pool" "lb_bknd_add_pool_sap_001" {
  loadbalancer_id = azurerm_lb.lb_sap_001.id
  name            = "lb_bknd_add_pool_sap_001"
}

resource "azurerm_lb_rule" "lb_rule_sap_001" {
  name                           = "lb_rule_sap_001"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "lb_frontend_publicip_sap_001"
  #azurerm_lb.lb_sap_001.frontend_ip_configuration[o].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_bknd_add_pool_sap_001.id]
  probe_id                       = azurerm_lb_probe.lb_probe_sap_001.id
  loadbalancer_id                = azurerm_lb.lb_sap_001.id
}

