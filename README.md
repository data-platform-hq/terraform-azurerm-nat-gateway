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

  project  = "datahq"
  env      = "example"
  location = "eastus"
  suffix   = "databricks"
  tags     = { environment = "example" }

  resource_group = "example_rg"
  subnets        = {
    (data.azurerm_subnet.one.name) = data.azurerm_subnet.one.id,
    (data.azurerm_subnet.two.name) = data.azurerm_subnet.two.id
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                         | Version   |
| ---------------------------------------------------------------------------- | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform)    | >= 1.0.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)          | >= 3.69.0 |

## Providers

| Name                                                                   | Version |
| ---------------------------------------------------------------------- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm)          | 3.69.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                | Type      |
|---------------------------------------------------------------------------------------------------------------------|-----------|
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource  |
| [azurerm_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway)                                                                                        | resource  |
| [azurerm_nat_gateway_public_ip_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association)                                                                  | resource  |
| [azurerm_subnet_nat_gateway_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association)                                                                     | resource  |


## Inputs

| Name                                                                         | Description| Type| Default| Required |
|------------------------------------------------------------------------------|------------|-----|--------|----------|
| <a name="input_project"></a> [project](#input\_project)                      | Project name | `string`| n/a |    yes    |
| <a name="input_env"></a> [env](#input\_env)                                  | Environment name | `string`| n/a |    yes    |
| <a name="input_location"></a> [location](#input\_location)                   | Azure location | `string`| n/a |    yes    |
| <a name="input_tags"></a> [tags](#input\_tags)                               | Resource tags | `map(any)`| {} |    no    |
| <a name="input_resource_group"></a> [resource_group](#input\_resource_group) | Resource group | `string` | n/a |    yes    |
| <a name="input_subnets"></a> [subnets](#input\_subnets)                      | Name to id map of subnet associated with NAT Gateway | `map(string)`| {} |    no    |
| <a name="input_suffix"></a> [suffix](#input\_suffix)                         | Resources suffix | `string`| "" |    no    |
| <a name="input_public_ip"></a> [public_ip](#input\_public_ip)                | Configuration options for azurerm public ip | <pre>type = object({<br>  allocation_method = optional(string)<br>  sku               = optional(string)<br>  zones             = optional(list(string))<br>})</pre> |  <pre>type = object({<br>  allocation_method = optional(string, "Static")<br>  sku               = optional(string, "Standard")<br>  zones             = optional(list(string), ["1"])<br>})</pre> |    no    |
| <a name="input_nat"></a> [nat](#input\_nats)                                 | Configuration options for azurerm nat gateway | <pre>type = object({<br>  sku       = optional(string)<br>  idle_time = optional(number)<br>  zones     = optional(list(string))<br>})</pre> | <pre>type = object({<br>  sku       = optional(string, "Standard")<br>  idle_time = optional(number, 10)<br>  zones     = optional(list(string), ["1"])<br>})</pre> |    no    |

## Outputs

| Name                                                                                                                          | Description                                          |
| ----------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| <a name="output_nat_id"></a> [nat\_id](#output\_nat\_id)                     | Nat gateway id               |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | Public ip address              |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm<>/tree/master/LICENSE)
