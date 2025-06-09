# Barclays Open Banking API Client (OAuth2, Payments, Accounts)
import requests
import os

BARCLAYS_TOKEN_URL = os.getenv('BARCLAYS_TOKEN_URL')
BARCLAYS_CLIENT_ID = os.getenv('BARCLAYS_CLIENT_ID')
BARCLAYS_CLIENT_SECRET = os.getenv('BARCLAYS_CLIENT_SECRET')
BARCLAYS_API_BASE = os.getenv('BARCLAYS_API_BASE')


def get_access_token():
    resp = requests.post(BARCLAYS_TOKEN_URL, data={
        'grant_type': 'client_credentials',
        'client_id': BARCLAYS_CLIENT_ID,
        'client_secret': BARCLAYS_CLIENT_SECRET,
        'scope': 'accounts payments'
    })
    resp.raise_for_status()
    return resp.json()['access_token']


def get_accounts():
    token = get_access_token()
    resp = requests.get(f"{BARCLAYS_API_BASE}/accounts", headers={
        'Authorization': f'Bearer {token}'
    })
    resp.raise_for_status()
    return resp.json()


def initiate_payment(payment_data):
    token = get_access_token()
    resp = requests.post(f"{BARCLAYS_API_BASE}/payments", json=payment_data, headers={
        'Authorization': f'Bearer {token}',
        'Content-Type': 'application/json'
    })
    resp.raise_for_status()
    return resp.json()
