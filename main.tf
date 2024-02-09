resource "azurerm_public_ip" "this" {
  name                = coalesce(var.nat_gateway_public_ip_name, "pip-${var.nat_gateway_name}")
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = var.public_ip_configuration.allocation_method
  sku                 = var.public_ip_configuration.sku
  zones               = var.public_ip_configuration.zones
  tags                = var.tags

  lifecycle {
    precondition {
      condition     = var.nat_gateway_configuration.sku == "Standard" && var.public_ip_configuration.allocation_method == "Static" ? true : false
      error_message = "Public IP Standard SKUs require allocation_method to be set to Static"
    }
  }
}

resource "azurerm_nat_gateway" "this" {
  name                    = var.nat_gateway_name
  location                = var.location
  resource_group_name     = var.resource_group
  sku_name                = var.nat_gateway_configuration.sku
  idle_timeout_in_minutes = var.nat_gateway_configuration.idle_time
  zones                   = var.nat_gateway_configuration.zones
  tags                    = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = azurerm_public_ip.this.id
}

resource "azurerm_subnet_nat_gateway_association" "this" {
  for_each = var.subnets

  nat_gateway_id = azurerm_nat_gateway.this.id
  subnet_id      = each.value
}
