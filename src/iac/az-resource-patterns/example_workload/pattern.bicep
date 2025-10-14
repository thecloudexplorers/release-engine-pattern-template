metadata resources = {
  version: '0.1.0'
  author: '<Author Name>'
  description: '<Description>'
}

// WORKLOAD CONFIGURATIONS

// scope must be set to subscription to allow for the creation of a resource group
targetScope = 'subscription'

@allowed([
  'westeurope'
])
@description('Region in which the workload should be deployed')
param resourceLocation string

param tags object

@description('Name of the target resource group ')
param resourceGroupName string = 'example-avm-rg'

// // VARIABLES

// // Deployment name variables
// // LIMITS: Tenant = 64, Management Group = 64, Subscription = 64, Resource Group = 64
// var deploymentNames = {
//   createResourceGroup: take('rg-create-${uniqueString(deployment().name, subscription().id)}', 64) 
// }

// // MODULES

// module resourceGroup '../../az-resources/Microsoft.Resources/resourceGroups/standardResourceGroup.bicep' = {
//   name: deploymentNames.createResourceGroup
//   params: {
//     resourceGroupName: resourceGroupName
//     resourceLocation: resourceLocation
//     tags: tags
//   }
// }

// Deploy a resource group using Azure Verified Module (AVM)
// Module reference: br/public:resource-group:1.0.0

param location string = 'westeurope'
// param resourceGroupName string = 'example-avm-rg'

module resourceGroup 'br/public:avm/res/resources/resource-group:0.4.2' = {
  name: 'resourceGroupDeployment'
  params: {
    name: resourceGroupName
  }
}

output resourceGroupId string = resourceGroup.outputs.resourceId
