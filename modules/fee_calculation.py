# Fee Calculation Template

def calculate_fee(transaction, fee_rules=None):
    """
    Calculates transaction fee based on rules.
    Args:
        transaction (dict): Transaction data.
        fee_rules (list): List of rule functions.
    Returns:
        float: Calculated fee.
    """
    base_fee = 2.0  # Default base fee
    if fee_rules:
        for rule in fee_rules:
            fee = rule(transaction)
            if fee is not None:
                return fee
    # Example: dynamic fee by amount
    amount = transaction.get('amount', 0)
    if amount > 10000:
        return base_fee + 0.01 * amount
    return base_fee

# Example rule

def high_value_fee_rule(tx):
    if tx.get('amount', 0) > 50000:
        return 100.0  # Flat fee for high value
    return None
