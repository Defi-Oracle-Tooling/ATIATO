# Open Banking API Connector (Stub)
import requests

def initiate_payment(payment_data, api_url, access_token):
    """
    Initiates a payment via Open Banking API.
    Args:
        payment_data (dict): Payment details.
        api_url (str): Endpoint for payment initiation.
        access_token (str): OAuth2 access token.
    Returns:
        dict: API response.
    """
    headers = {'Authorization': f'Bearer {access_token}', 'Content-Type': 'application/json'}
    resp = requests.post(api_url, json=payment_data, headers=headers)
    resp.raise_for_status()
    return resp.json()
