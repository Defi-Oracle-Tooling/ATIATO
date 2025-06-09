# Currency Conversion Utility
import requests

def convert_currency(amount, from_currency, to_currency, rates_api_url, api_key=None):
    """
    Converts amount from one currency to another using a rates API.
    Args:
        amount (float): Amount to convert.
        from_currency (str): Source currency code.
        to_currency (str): Target currency code.
        rates_api_url (str): API endpoint for exchange rates.
        api_key (str): Optional API key.
    Returns:
        float: Converted amount.
    """
    params = {'base': from_currency, 'symbols': to_currency}
    headers = {'apikey': api_key} if api_key else {}
    resp = requests.get(rates_api_url, params=params, headers=headers)
    resp.raise_for_status()
    rate = resp.json()['rates'][to_currency]
    return amount * rate
