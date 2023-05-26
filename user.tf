resource "azuread_user" "user1" {
    user_principal_name = "webserveradmin@ajay21rathorgmail.onmicrosoft.com"
    display_name = "Namrita Rathor"
    mail_nickname = "webserveradmin"
    password = "manageus@23"
}


#resource "azuread_custom_directory_role" "custom-role" {
#    display_name = "custom role"
#    description = "allows user to restart azure vm "
#    template_id         = "62e90394-69f5-4237-9190-012177145e10"
#    enabled = true
#    version = "1.0"

#    permissions {
#      allowed_resource_actions = [
#        "Microsoft.Compute/virtualmachines/read",
#        "Microsoft.Compute/virtualmachines/start/action",
#        "Microsoft.Compute/virtualmachines/restart/action"
#      ]

#    }

#}

#resource "azuread_directory_role_assignment" "role-assign" {
#    role_id = azuread_custom_directory_role.custom-role.id
#    principal_object_id = azuread_user.user1.id
  
#}