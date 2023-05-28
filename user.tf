data "azurerm_client_config" "azure-cli-2023-05-26-17-40-23" {
    id = "azure-cli-2023-05-26-17-40-23"
}

data "azurerm_subscription" "primary" {
}
resource "azuread_user" "startstopserver" {
    user_principal_name = "startstopserver@ajay21rathorgmail.onmicrosoft.com"
    display_name = "startstopserver"
    mail_nickname = "startstopserver"
    password = "manageus@23"  
}

resource "azurerm_role_definition" "startstopwebserver" {
    name = "startstopwebserver"
    role_definition_id = "00000000-0000-0000-0000-000000000000"

    scope = data.azurerm_subscription.primary.id

    permissions {
      actions = ["Microsoft.Compute/virtualmachines/read",
        "Microsoft.Compute/virtualmachines/start/action",
        "Microsoft.Compute/virtualmachines/restart/action"]
    }

    assignable_scopes = [
        data.azurerm_subscription.primary.id
    ]
}

resource "azurerm_role_assignment" "assign_role" {
  name = "00000000-0000-0000-0000-000000000000"
  scope = data.azurerm_subscription.primary.id
  role_definition_id = azurerm_role_definition.startstopwebserver.role_definition_id
  principal_id = data.azurerm_client_config.azure-cli-2023-05-26-17-40-23.object_id
}
