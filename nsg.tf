resource "azurerm_network_security_group" "nsg_sap_001" {
  name                = join("-", [var.program, var.owner, var.enviroment, "web-nsg"])
  location            = azurerm_resource_group.rg_sap_001.location
  resource_group_name = azurerm_resource_group.rg_sap_001.name
  //tags                = local.tags

}


resource "azurerm_network_security_rule" "nsg-rule_inbound" {
  for_each                    = var.azurerm_network_security_group
  name                        = "inbound-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_sap_001.name
  network_security_group_name = azurerm_network_security_group.nsg_sap_001.name

}

resource "azurerm_subnet_network_security_group_association" "subnet-nsg-association" {
  subnet_id                 = azurerm_subnet.subnet_sap_001.id
  network_security_group_id = azurerm_network_security_group.nsg_sap_001.id
}