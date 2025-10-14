targetScope = 'subscription'

// Deploy a resource group using Azure Verified Module (AVM)
// Module reference: br/public:resource-group:1.0.0

param location string = 'uksouth'
param resourceGroupName string = 'example-avm-rg'

module resourceGroup 'br/public:avm/res/resources/resource-group:0.4.2' = {
  name: 'resourceGroupDeployment'
  params: {
    name: resourceGroupName
  }
}

output resourceGroupId string = resourceGroup.outputs.resourceId
