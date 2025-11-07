resource "azurerm_linux_virtual_machine" "nginx_vm" {
  name                = "nginx-vm"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = "Standard_B1s"

  # ЛОГІН ПО КЛЮЧУ (тільки цей варіант)
  admin_username                  = var.vm_admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
  }

  network_interface_ids = [data.azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo systemctl enable nginx",
      "sudo systemctl restart nginx"
    ]
  }

  # Підключення для провізіонерів — ПРИВАТНИЙ КЛЮЧ
  connection {
    type        = "ssh"
    host        = data.azurerm_public_ip.pip.ip_address
    user        = var.vm_admin_username
    private_key = file(pathexpand("~/.ssh/id_rsa"))
  }
}
