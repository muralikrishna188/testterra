terraform {
  backend "azurerm" {
      resource_group_name = "terraform-state-rg"
      storage_account_name = "terraformprodapac"
      container_name = "testapp"
      key = "terraform.testapp"
      access_key = "li+OI6DKp8rDHi1VueWthD7aJMvFQtSCfgqlZcUGzlxIbMT0uNlXTmB1P/tDXbN7xe55VPeIi2F+J8gRjsa3Ng=="
  }
}
variable "subscription_id" {
    type = string
    default = "049cc0b9-2696-4e70-871b-4366be487c19"
    description = "Dev subcription id"
  
}

variable "client_id" {
    type = string
    default = "9b361e9c-d9e0-4e88-a010-bcd0ec348865"
    description = "client id"
  
}

variable "client_secret" {
    type = string
    default = "~Sp7Q~Z.5p~Hat-RixY5VfViQv.uhL1KqpQQD"
    description = "client secret"
  
}

variable "tenant_id" {
    type = string
    default = "477cf0a5-266c-4331-8f0a-865f4622d888"
    description = "tenant id"
  
}


  

provider "azurerm" {
    features {
      
    }
    subscription_id = var.subscription_id
    client_id = var.client_id
    client_secret = var.client_secret
    tenant_id = var.tenant_id
}
locals {
  setup_name ="practice-hyd"
}
resource "azurerm_resource_group" "testrglabel" {
    name = "testrgeastus"
    location = "East US"
    tags = {
      "name" = "${local.setup_name}-rsg"
    }

  
}
resource "azurerm_app_service_plan" "testappplan" {
    name = "testappplan"
    location = azurerm_resource_group.testrglabel.location
    resource_group_name = azurerm_resource_group.testrglabel.name
    sku {
      tier = "standard"
      size = "S1"
    }
    depends_on = [
      azurerm_resource_group.testrglabel
    ]
    tags = {
      "name" = "${local.setup_name}-appplan"
    }
  
}

resource "azurerm_app_service" "testwebapp" {
    name = "testwebapp568"
    location = azurerm_resource_group.testrglabel.location
    resource_group_name = azurerm_resource_group.testrglabel.name
    app_service_plan_id = azurerm_app_service_plan.testappplan.id
    tags = {
      "name" = "${local.setup_name}-webapp"
    }
    depends_on = [
      azurerm_app_service_plan.testappplan
    ]
  
}

