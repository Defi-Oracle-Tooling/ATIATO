# Fraud Detection Rule Engine (Template)
# Supports rule-based and ML-based checks

def check_fraud(transaction, rules=None, model=None):
    """
    Checks a transaction for fraud using rules and/or a machine learning model.
    Args:
        transaction (dict): Transaction data.
        rules (list): List of rule functions.
        model (object): ML model with a predict method.
    Returns:
        dict: {'fraud': bool, 'reason': str}
    """
    # Rule-based checks
    if rules:
        for rule in rules:
            result = rule(transaction)
            if result.get('fraud'):
                return result
    # ML-based check
    if model:
        pred = model.predict([transaction])
        if pred[0] == 1:
            return {'fraud': True, 'reason': 'ML model flagged'}
    return {'fraud': False, 'reason': 'No issues detected'}

# Example rule

def large_amount_rule(tx):
    if tx.get('amount', 0) > 100000:
        return {'fraud': True, 'reason': 'Amount exceeds threshold'}
    return {'fraud': False}
