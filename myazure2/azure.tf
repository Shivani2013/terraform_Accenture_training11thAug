terraform {
 required_version = ">=0.12"

   required_providers {
     azurerm = {
       source = "hashicorp/azurerm"
       version = "~>2.0"
###   subscription_id = “*******************”     If multiple subscriptions are there in your account
     }
   }
 }

