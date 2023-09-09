locals {
  suffix = length(var.suffix) == 0 ? "" : "-${var.suffix}"
}

resource "azurerm_public_ip" "this" {
  name                = "nat-${var.project}-${var.env}-${var.location}${local.suffix}"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = var.public_ip.allocation_method
  sku                 = var.public_ip.sku
  zones               = var.public_ip.zones
  tags                = var.tags

  lifecycle {
    precondition {
      condition     = var.nat.sku == "Standard" && var.public_ip.allocation_method == "Static" ? true : false
      error_message = "Public IP Standard SKUs require allocation_method to be set to Static"
    }
  }
}

resource "azurerm_nat_gateway" "this" {
  name                    = "nat-${var.project}-${var.env}-${var.location}${var.suffix}"
  location                = var.location
  resource_group_name     = var.resource_group
  sku_name                = var.nat.sku
  idle_timeout_in_minutes = var.nat.idle_time
  zones                   = var.nat.zones
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
