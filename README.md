# Azure Nat Gateway Terraform module
Terraform module for creation Azure Nat Gateway

## Usage
This module is provisioning Public IP Address, Azure NAT Gateway which is associated with target subnets. 

```hcl
data "azurerm_subnet" "one" {
  name                 = "example_one"
  resource_group_name  = "example_rg"
  virtual_network_name = "example_vnet"
}

data "azurerm_subnet" "two" {
  name                 = "example_two"
  resource_group_name  = "example_rg"
  virtual_network_name = "example_vnet"
}

module "nat" {
  source  = "data-platform-hq/nat-gateway/azurerm"
  version = "~> 1.0"

  nat_gateway_name = "datahq-nat"
  location         = "eastus"
  tags             = { environment = "example" }
  resource_group   = "example_rg"

  subnets = {
    (data.azurerm_subnet.one.name) = data.azurerm_subnet.one.id,
    (data.azurerm_subnet.two.name) = data.azurerm_subnet.two.id
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.69.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.69.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet_nat_gateway_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Azure location | `string` | n/a | yes |
| <a name="input_nat_gateway_configuration"></a> [nat\_gateway\_configuration](#input\_nat\_gateway\_configuration) | Configuration options for azure nat gateway | <pre>object({<br>    sku       = optional(string, "Standard")<br>    idle_time = optional(number, 10)<br>    zones     = optional(list(string), [])<br>  })</pre> | `{}` | no |
| <a name="input_nat_gateway_name"></a> [nat\_gateway\_name](#input\_nat\_gateway\_name) | NAT Gateway name | `string` | n/a | yes |
| <a name="input_nat_gateway_public_ip_name"></a> [nat\_gateway\_public\_ip\_name](#input\_nat\_gateway\_public\_ip\_name) | NAT Gateway public ip resource name | `string` | `null` | no |
| <a name="input_public_ip_configuration"></a> [public\_ip\_configuration](#input\_public\_ip\_configuration) | Configuration options for public ip | <pre>object({<br>    allocation_method = optional(string, "Static")<br>    sku               = optional(string, "Standard")<br>    zones             = optional(list(string), [])<br>  })</pre> | `{}` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Resource group | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Name to id map of subnet associated with NAT Gateway | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Nat gateway id |
| <a name="output_name"></a> [name](#output\_name) | Nat gateway name |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | Public ip address |
<!-- END_TF_DOCS -->
