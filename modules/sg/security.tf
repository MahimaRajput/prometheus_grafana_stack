provider "azurerm" {
  features {
    
  }
}
resource "azurerm_network_security_group" "promesecurity" {
  name = var.securitygroup
  location = var.location
  resource_group_name = var.rgname
}


# # Ingress rules for CIDR blocks
# locals {
#   ingress_rules = [
#   for_each = var.create_ingress_cidr ? toset(range(length(var.ingress_cidr_from_port))) : []{
#   content {
#     from_port   = var.ingress_cidr_from_port[ingress.key]
#     to_port     = var.ingress_cidr_to_port[ingress.key]
#     protocol    = var.ingress_cidr_protocol[ingress.key]
#     cidr_blocks = var.ingress_cidr_block
#     description = var.ingress_cidr_description[ingress.key]
#   }
#   }
#   ]
# }

# resource "azurerm_network_security_rule" "ingress" {
#   resource_group_name = var.rgname
#   for_each           = var.create_ingress_cidr ? toset(keys(local.ingress_rules)) : []
#   name               = local.ingress_rules[each.key].name
#   network_security_group_name = var.securitygroup
#   priority           = each.key + 100
#   direction          = "Inbound"
#   access             = "Allow"
#   protocol           = local.ingress_rules[each.key].protocol
#   source_address_prefix = local.ingress_rules[each.key].cidr_blocks
#   source_port_range  = "${local.ingress_rules[each.key].from_port}-${local.ingress_rules[each.key].to_port}"
#   destination_port_range = "*"
#   destination_address_prefix = "*"
#   description        = local.ingress_rules[each.key].description
# }

# # Egress rules for CIDR blocks
# locals {
#   egress_rules = [
#     for idx, from_port in var.egress_cidr_from_port : {
#       name        = "egress-rule-${idx}"
#       from_port   = from_port
#       to_port     = var.egress_cidr_to_port[idx]
#       protocol    = var.egress_cidr_protocol[idx]
#       cidr_blocks = var.egress_cidr_block
#     }
#   ]
# }

# resource "azurerm_network_security_rule" "egress" {
#   resource_group_name = var.rgname
#   for_each           = var.create_egress_cidr ? toset(keys(local.egress_rules)) : []
#   name               = local.egress_rules[each.key].name
#   network_security_group_name = var.securitygroup
#   priority           = each.key + 100
#   direction          = "Outbound"
#   access             = "Allow"
#   protocol           = local.egress_rules[each.key].protocol
#   source_port_range  = "*"
#   source_address_prefix = "*"
#   destination_port_range = "${local.egress_rules[each.key].from_port}-${local.egress_rules[each.key].to_port}"
#   destination_address_prefix = local.egress_rules[each.key].cidr_blocks
# }

