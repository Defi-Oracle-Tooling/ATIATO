# Azure Key Vault Integration Module
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
import os

KEY_VAULT_URL = os.getenv('KEY_VAULT_URL')

credential = DefaultAzureCredential()
client = SecretClient(vault_url=KEY_VAULT_URL, credential=credential)

def get_secret(secret_name):
    return client.get_secret(secret_name).value
