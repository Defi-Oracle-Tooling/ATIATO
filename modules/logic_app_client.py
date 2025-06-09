# Azure Logic App HTTP Trigger Client Example
import requests
import os

LOGIC_APP_URL = os.getenv('LOGIC_APP_URL')

def trigger_workflow(payload):
    response = requests.post(LOGIC_APP_URL, json=payload)
    response.raise_for_status()
    return response.json()
