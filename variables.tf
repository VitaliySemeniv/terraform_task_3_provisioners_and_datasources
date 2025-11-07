variable "resource_group_name" { default = "rg-nginx-demo" }
variable "location" { default = "West Europe" }

# Для демо можна пароль; у реалі краще SSH ключ
variable "vm_admin_username" { default = "azureuser" }
variable "vm_admin_password" { default = "DemoPass123!" }
