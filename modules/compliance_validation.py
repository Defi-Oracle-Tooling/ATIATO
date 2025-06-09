# Compliance Validation Template
# Supports AML, KYC, and regulatory checks

def validate_compliance(transaction, sanctions_list=None, kyc_db=None):
    """
    Validates a transaction for compliance (AML, KYC, sanctions).
    Args:
        transaction (dict): Transaction data.
        sanctions_list (set): Set of blacklisted entities.
        kyc_db (dict): KYC database keyed by customer ID.
    Returns:
        dict: {'compliant': bool, 'reason': str}
    """
    # Sanctions check
    if sanctions_list and transaction.get('payee') in sanctions_list:
        return {'compliant': False, 'reason': 'Payee on sanctions list'}
    # KYC check
    if kyc_db and not kyc_db.get(transaction.get('payer')):
        return {'compliant': False, 'reason': 'Payer not KYC verified'}
    # AML pattern (simple example)
    if transaction.get('amount', 0) > 50000 and transaction.get('country') not in {'US', 'UK', 'DE'}:
        return {'compliant': False, 'reason': 'AML pattern detected'}
    return {'compliant': True, 'reason': 'Compliant'}
