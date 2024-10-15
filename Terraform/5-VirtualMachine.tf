#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# MasterNode-01

#Define Public IP....................
resource "azurerm_public_ip" "project-az-masternode01-ip" {
  name                = "project-az-masternode01-ip"
  location            = azurerm_resource_group.project-az-rg01.location
  resource_group_name = azurerm_resource_group.project-az-rg01.name
  allocation_method   = "Dynamic"

  tags = {
    Name = "project-az-masternode01-ip"
  }
}

#Define network_interface..............
resource "azurerm_network_interface" "project-az-masternode01" {
  name                = "project-az-masternode01"
  location            = azurerm_resource_group.project-az-rg01.location
  resource_group_name = azurerm_resource_group.project-az-rg01.name

  ip_configuration {
    name                          = "project-az-masternode01"
    subnet_id                     = azurerm_subnet.project-az-vm.id
    private_ip_address_allocation = "Static"
	  private_ip_address            = "192.168.1.11"
    public_ip_address_id          = azurerm_public_ip.project-az-masternode01-ip.id
  }
  
   tags = {
    Name = "project-az-masternode01"
  }
}

#ConfigureVirtualMachine...............
resource "azurerm_linux_virtual_machine" "project-az-masternode01" {
  name                = "project-az-masternode01"
  resource_group_name = azurerm_resource_group.project-az-rg01.name
  location            = azurerm_resource_group.project-az-rg01.location
  size                = "Standard_B2s"
  disable_password_authentication = false
  admin_username      = "myadmin"
  admin_password      = "Admin@123456"
  network_interface_ids = [
  azurerm_network_interface.project-az-masternode01.id,
  ]
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  connection {
    type     = "ssh"
    user     = "myadmin"
    password = "Admin@123456"
    host     = self.public_ip_address
  }
  provisioner "remote-exec" {
    inline = [
      "wget https://raw.githubusercontent.com/Mehul-Kubernetes/k8scluster/refs/heads/main/k8s_cluster_masternode01.sh",
      "sudo sh k8s_cluster_masternode01.sh",
    ]
  }
    tags = {
    Name = "project-az-masternode01"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
  resource "azurerm_dev_test_global_vm_shutdown_schedule" "project-az-masternode01" {
  location              = azurerm_resource_group.project-az-rg01.location
  virtual_machine_id    = azurerm_linux_virtual_machine.project-az-masternode01.id
  enabled               = true
  daily_recurrence_time = "1900"  # Time in HHmm format
  timezone              = "Pacific Standard Time"
  notification_settings {
    enabled          = true
    time_in_minutes  = 60
    webhook_url      = "https://example.com/webhook"
  }
}
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# WorkerNode-01

#Define Public IP....................
resource "azurerm_public_ip" "project-az-workernode01-ip" {
  name                = "project-az-workernode01-ip"
  location            = azurerm_resource_group.project-az-rg01.location
  resource_group_name = azurerm_resource_group.project-az-rg01.name
  allocation_method   = "Dynamic"
  tags = {
    environment = "project-az-workernode01-ip"
  }
}

#Define network_interface..............
resource "azurerm_network_interface" "project-az-workernode01" {
  name                = "project-az-workernode01"
  location            = azurerm_resource_group.project-az-rg01.location
  resource_group_name = azurerm_resource_group.project-az-rg01.name
  ip_configuration {
    name                          = "project-az-workernode01"
    subnet_id                     = azurerm_subnet.project-az-vm.id
    private_ip_address_allocation = "Static"
  	private_ip_address            = "192.168.1.12"
    public_ip_address_id          = azurerm_public_ip.project-az-workernode01-ip.id
  }
  tags = {
    Name = "project-az-workernode01"
  }
}

#ConfigureVirtualMachine...............
resource "azurerm_linux_virtual_machine" "project-az-workernode01" {
  name                = "project-az-workernode01"
  resource_group_name = azurerm_resource_group.project-az-rg01.name
  location            = azurerm_resource_group.project-az-rg01.location
  size                = "Standard_B2s"
  disable_password_authentication = false
  admin_username      = "myadmin"
  admin_password      = "Admin@123456"
  network_interface_ids = [
  azurerm_network_interface.project-az-workernode01.id,
  ]
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  connection {
    type     = "ssh"
    user     = "myadmin"
    password = "Admin@123456"
    host     = self.public_ip_address
  }
  provisioner "remote-exec" {
    inline = [
      "wget https://raw.githubusercontent.com/Mehul-Kubernetes/k8scluster/refs/heads/main/k8s_cluster_workernode01.sh",
      "sudo sh k8s_cluster_workernode01.sh",
    ]
  }
  tags = {
    Name = "project-az-workernode01"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
  resource "azurerm_dev_test_global_vm_shutdown_schedule" "project-az-workernode01" {
  location              = azurerm_resource_group.project-az-rg01.location
  virtual_machine_id    = azurerm_linux_virtual_machine.project-az-workernode01.id
  enabled               = true
  daily_recurrence_time = "1900"  # Time in HHmm format
  timezone              = "Pacific Standard Time"
    notification_settings {
    enabled          = true
    time_in_minutes  = 60
    webhook_url      = "https://example.com/webhook"
  }
}

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# WorkerNode-02

#Define Public IP....................
resource "azurerm_public_ip" "project-az-workernode02-ip" {
  name                = "project-az-workernode02-ip"
  location            = azurerm_resource_group.project-az-rg01.location
  resource_group_name = azurerm_resource_group.project-az-rg01.name
  allocation_method   = "Dynamic"
  tags = {
    environment = "project-az-workernode02-ip"
  }
}

#Define network_interface..............
resource "azurerm_network_interface" "project-az-workernode02" {
  name                = "project-az-workernode02"
  location            = azurerm_resource_group.project-az-rg01.location
  resource_group_name = azurerm_resource_group.project-az-rg01.name
  ip_configuration {
    name                          = "project-az-workernode02"
    subnet_id                     = azurerm_subnet.project-az-vm.id
    private_ip_address_allocation = "Static"
	  private_ip_address            = "192.168.1.13"
    public_ip_address_id          = azurerm_public_ip.project-az-workernode02-ip.id
  }
  tags = {
    Name = "project-az-workernode02"
  }
}

#ConfigureVirtualMachine...............
resource "azurerm_linux_virtual_machine" "project-az-workernode02" {
  name                = "project-az-workernode02"
  resource_group_name = azurerm_resource_group.project-az-rg01.name
  location            = azurerm_resource_group.project-az-rg01.location
  size                = "Standard_B2s"
  disable_password_authentication = false
  admin_username      = "myadmin"
  admin_password      = "Admin@123456"
  network_interface_ids = [
  azurerm_network_interface.project-az-workernode02.id,
  ]
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  connection {
    type     = "ssh"
    user     = "myadmin"
    password = "Admin@123456"
    host     = self.public_ip_address
  }
  provisioner "remote-exec" {
    inline = [
      "wget https://raw.githubusercontent.com/Mehul-Kubernetes/k8scluster/refs/heads/main/k8s_cluster_workernode02.sh",
      "sudo sh k8s_cluster_workernode02.sh",
    ]
  }
tags = {
    Name = "project-az-workernode02"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
resource "azurerm_dev_test_global_vm_shutdown_schedule" "project-az-workernode02" {
  location              = azurerm_resource_group.project-az-rg01.location
  virtual_machine_id    = azurerm_linux_virtual_machine.project-az-workernode02.id
  enabled               = true
  daily_recurrence_time = "1900"  # Time in HHmm format
  timezone              = "Pacific Standard Time"
  notification_settings {
    enabled          = true
    time_in_minutes  = 60
    webhook_url      = "https://example.com/webhook"
  }
}

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# WorkerNode-03

#Define Public IP....................
resource "azurerm_public_ip" "project-az-workernode03-ip" {
  name                = "project-az-workernode03-ip"
  location            = azurerm_resource_group.project-az-rg01.location
  resource_group_name = azurerm_resource_group.project-az-rg01.name
  allocation_method   = "Dynamic"
  tags = {
    Name = "project-az-workernode03-ip"
  }

}

#Define network_interface..............
resource "azurerm_network_interface" "project-az-workernode03" {
  name                = "project-az-workernode03"
  location            = azurerm_resource_group.project-az-rg01.location
  resource_group_name = azurerm_resource_group.project-az-rg01.name
  ip_configuration {
    name                          = "project-az-workernode03"
    subnet_id                     = azurerm_subnet.project-az-vm.id
    private_ip_address_allocation = "Static"
	  private_ip_address            = "192.168.1.14"
    public_ip_address_id          = azurerm_public_ip.project-az-workernode03-ip.id
  }
   tags = {
    Name = "project-az-workernode03"
  }

}

#ConfigureVirtualMachine...............
resource "azurerm_linux_virtual_machine" "project-az-workernode03" {
  name                = "project-az-workernode03"
  resource_group_name = azurerm_resource_group.project-az-rg01.name
  location            = azurerm_resource_group.project-az-rg01.location
  size                = "Standard_B2s"
  disable_password_authentication = false
  admin_username      = "myadmin"
  admin_password      = "Admin@123456"
  network_interface_ids = [
  azurerm_network_interface.project-az-workernode03.id,
  ]
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  connection {
    type     = "ssh"
    user     = "myadmin"
    password = "Admin@123456"
    host     = self.public_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "wget https://raw.githubusercontent.com/Mehul-Kubernetes/k8scluster/refs/heads/main/k8s_cluster_workernode03.sh",
      "sudo sh k8s_cluster_workernode03.sh",
    ]
  }
  
  tags = {
    Name = "project-az-workernode03"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
  resource "azurerm_dev_test_global_vm_shutdown_schedule" "project-az-workernode03" {
  location              = azurerm_resource_group.project-az-rg01.location
  virtual_machine_id    = azurerm_linux_virtual_machine.project-az-workernode03.id
  enabled               = true
  daily_recurrence_time = "1900"  # Time in HHmm format
  timezone              = "Pacific Standard Time"
  notification_settings {
    enabled          = true
    time_in_minutes  = 60
    webhook_url      = "https://example.com/webhook"
  }
}

#---------------------------------------------------------------------------------------------------------------------------------------------------
# WorkerNode-04

#Define Public IP....................

/*resource "azurerm_public_ip" "project-az-workernode04-ip" {
  name                = "project-az-workernode04-ip"
  location            = azurerm_resource_group.project-az-rg01.location
  resource_group_name = azurerm_resource_group.project-az-rg01.name
  allocation_method   = "Dynamic"

  tags = {
    Name = "project-az-workernode04-ip"
  }

}

#Define network_interface..............

resource "azurerm_network_interface" "project-az-workernode04" {
  name                = "project-az-workernode04"
  location            = azurerm_resource_group.project-az-rg01.location
  resource_group_name = azurerm_resource_group.project-az-rg01.name

  ip_configuration {
    name                          = "project-az-workernode04"
    subnet_id                     = azurerm_subnet.project-az-vm.id
    private_ip_address_allocation = "Static"
	  private_ip_address            = "192.168.1.15"
    public_ip_address_id          = azurerm_public_ip.project-az-workernode04-ip.id
  }
  
   tags = {
    Name = "project-az-workernode04"
  }

}

#ConfigureVirtualMachine...............

resource "azurerm_windows_virtual_machine" "project-az-workernode04" {
  name                = "workernode04"
  resource_group_name = azurerm_resource_group.project-az-rg01.name
  location            = azurerm_resource_group.project-az-rg01.location
  size                = "Standard_B2s"
  admin_username      = "myadmin"
  admin_password      = "Admin@123456"
  network_interface_ids = [
    azurerm_network_interface.project-az-workernode04.id,
  ]
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  
  tags = {
    Name = "project-az-workernode04"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  connection {
    type     = "winrm"
    user     = "myadmin"
    password = "Admin@123456"
    host     = self.public_ip_address
    port     = 5986
    https    = true
    insecure = true
  }

#provisioner "file" {
#    source      = "index.html"
#    destination = "C:/Windows"
#  }

#    provisioner "remote-exec" {
#    inline = [
#      "echo Hello, World! > C:\\hello.txt",
#      "mkdir C:\\example"
#    ]
#  }

}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "project-az-workernode04" {
  location              = azurerm_resource_group.project-az-rg01.location
  virtual_machine_id    = azurerm_windows_virtual_machine.project-az-workernode04.id
  enabled               = true
  daily_recurrence_time = "1900"  # Time in HHmm format
  timezone              = "Pacific Standard Time"

  notification_settings {
    enabled          = true
    time_in_minutes  = 60
    webhook_url      = "https://example.com/webhook"
  }

}*/

#-------------------------------------------------------------------------------------------------------------------------------------------------------