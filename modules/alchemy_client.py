# Alchemy Blockchain API Client (Ethereum/EVM)
import requests
import os

ALCHEMY_API_KEY = os.getenv('ALCHEMY_API_KEY')
ALCHEMY_URL = f"https://eth-mainnet.g.alchemy.com/v2/{ALCHEMY_API_KEY}"


def get_eth_balance(address):
    resp = requests.post(ALCHEMY_URL, json={
        "jsonrpc": "2.0",
        "method": "eth_getBalance",
        "params": [address, "latest"],
        "id": 1
    })
    resp.raise_for_status()
    return int(resp.json()['result'], 16) / 1e18


def send_raw_transaction(signed_tx):
    resp = requests.post(ALCHEMY_URL, json={
        "jsonrpc": "2.0",
        "method": "eth_sendRawTransaction",
        "params": [signed_tx],
        "id": 1
    })
    resp.raise_for_status()
    return resp.json()['result']
