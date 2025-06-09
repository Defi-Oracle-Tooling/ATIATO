// Main Bicep file for translation system infrastructure
// This file provisions App Service, SQL Databases, Key Vault, Application Insights, Log Analytics, and dependencies


param environmentName string
param location string
// resourceGroupName parameter removed (not used)
param AZURE_STORAGE_CONNECTION_STRING string
param EXCHANGE_RATE_API_KEY string

// Resource token for unique resource naming
var resourceToken = uniqueString(subscription().id, resourceGroup().id, environmentName)
var resourcePrefix = toLower('transsys${resourceToken}')

// Resource name prefix for uniqueness
// (removed duplicate resourcePrefix)

// Log Analytics Workspace
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: '${resourcePrefix}-log'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

// Application Insights
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: '${resourcePrefix}-ai'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalytics.id
  }
}

// Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: '${resourcePrefix}-kv'
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: []
    enableSoftDelete: true
    enablePurgeProtection: true
  }
}

// SQL Database for exchange rates
@secure()
param sqlAdminPassword string

resource exchangeRateSqlServer 'Microsoft.Sql/servers@2022-02-01-preview' = {
  name: '${resourcePrefix}-exsql'
  location: location
  properties: {
    administratorLogin: 'sqladminuser'
    administratorLoginPassword: sqlAdminPassword
    version: '12.0'
  }
}

resource exchangeRateDb 'Microsoft.Sql/servers/databases@2022-02-01-preview' = {
  parent: exchangeRateSqlServer
  name: 'exchange-rate-db'
  location: location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 2147483648
    sampleName: 'AdventureWorksLT'
  }
}

// SQL Database for currency registry
resource currencyRegistrySqlServer 'Microsoft.Sql/servers@2022-02-01-preview' = {
  name: '${resourcePrefix}-cursql'
  location: location
  properties: {
    administratorLogin: 'sqladminuser'
    administratorLoginPassword: sqlAdminPassword
    version: '12.0'
  }
}

resource currencyRegistryDb 'Microsoft.Sql/servers/databases@2022-02-01-preview' = {
  parent: currencyRegistrySqlServer
  name: 'currency-registry-db'
  location: location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 2147483648
    sampleName: 'AdventureWorksLT'
  }
}

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: '${resourcePrefix}-plan'
  location: location
  sku: {
    name: 'S1'
    tier: 'Standard'
  }
  properties: {
    reserved: false
  }
}


// User-assigned managed identity for App Service
resource translationAppIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${resourcePrefix}-identity'
  location: location
}

// App Service for Logic App integration
resource translationApp 'Microsoft.Web/sites@2022-03-01' = {
  name: '${resourcePrefix}-logicapp'
  location: location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${translationAppIdentity.id}': {}
    }
  }
  tags: {
    'azd-service-name': 'translation-logic-app'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'AZURE_STORAGE_CONNECTION_STRING'
          value: AZURE_STORAGE_CONNECTION_STRING
        }
        {
          name: 'EXCHANGE_RATE_API_KEY'
          value: EXCHANGE_RATE_API_KEY
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsights.properties.ConnectionString
        }
      ]
      cors: {
        allowedOrigins: [
          '*'
        ]
        supportCredentials: false
      }
    }
  }
  // dependsOn removed (not needed)
}

// App Service Site Extension for Logic Apps
resource siteExtension 'Microsoft.Web/sites/siteextensions@2022-03-01' = {
  parent: translationApp
  name: 'LogicAppsExtension'
}


output appServiceName string = translationApp.name
output keyVaultName string = keyVault.name
output exchangeRateDbName string = exchangeRateDb.name
output currencyRegistryDbName string = currencyRegistryDb.name
output appInsightsName string = appInsights.name
output logAnalyticsName string = logAnalytics.name
output RESOURCE_GROUP_ID string = resourceGroup().id
