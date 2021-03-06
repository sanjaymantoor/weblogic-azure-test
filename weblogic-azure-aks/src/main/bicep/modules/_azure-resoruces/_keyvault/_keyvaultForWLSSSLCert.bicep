// Copyright (c) 2021, Oracle Corporation and/or its affiliates.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

@description('Property to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault.')
param enabledForTemplateDeployment bool = true
@description('Name of the vault')
param keyVaultName string
param location string
@description('Price tier for Key Vault.')
param sku string = 'Standard'
param utcValue string = utcNow()
param wlsIdentityKeyStoreData string = newGuid()
param wlsIdentityKeyStoreDataSecretName string = 'myIdentityKeyStoreData'
@secure()
param wlsIdentityKeyStorePassphrase string = newGuid()
param wlsIdentityKeyStorePassphraseSecretName string = 'myIdentityKeyStorePsw'
param wlsPrivateKeyAlias string = 'server-cert'
param wlsPrivateKeyAliasSecretName string = 'privateKeyAlias'
@secure()
param wlsPrivateKeyPassPhrase string = newGuid()
param wlsPrivateKeyPassPhraseSecretName string = 'privateKeyPsw'
param wlsTrustKeyStoreData string = newGuid()
param wlsTrustKeyStoreDataSecretName string = 'myTrustKeyStoreData'
@secure()
param wlsTrustKeyStorePassPhrase string = newGuid()
param wlsTrustKeyStorePassPhraseSecretName string = 'myTrustKeyStorePsw'

resource keyvault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    accessPolicies: []
    enabledForTemplateDeployment: enabledForTemplateDeployment
    sku: {
      name: sku
      family: 'A'
    }
    tenantId: subscription().tenantId
  }
  tags: {
    'managed-by-azure-weblogic': utcValue
  }
}

resource identityKeyStoreDataSecret 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
  name: '${keyVaultName}/${wlsIdentityKeyStoreDataSecretName}'
  properties: {
    value: wlsIdentityKeyStoreData
  }
  dependsOn: [
    keyvault
  ]
}

resource identityKeyStorePswSecret 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
  name: '${keyVaultName}/${wlsIdentityKeyStorePassphraseSecretName}'
  properties: {
    value: wlsIdentityKeyStorePassphrase
  }
  dependsOn: [
    keyvault
  ]
}

resource privateKeyAliasSecret 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
  name: '${keyVaultName}/${wlsPrivateKeyAliasSecretName}'
  properties: {
    value: wlsPrivateKeyAlias
  }
  dependsOn: [
    keyvault
  ]
}

resource privateKeyPswSecret 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
  name: '${keyVaultName}/${wlsPrivateKeyPassPhraseSecretName}'
  properties: {
    value: wlsPrivateKeyPassPhrase
  }
  dependsOn: [
    keyvault
  ]
}

resource trustKeyStoreDataSecret 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
  name: '${keyVaultName}/${wlsTrustKeyStoreDataSecretName}'
  properties: {
    value: wlsTrustKeyStoreData
  }
  dependsOn: [
    keyvault
  ]
}

resource trustKeyStorePswSecret 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
  name: '${keyVaultName}/${wlsTrustKeyStorePassPhraseSecretName}'
  properties: {
    value: wlsTrustKeyStorePassPhrase
  }
  dependsOn: [
    keyvault
  ]
}
