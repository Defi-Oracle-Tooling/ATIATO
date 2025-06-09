-- GRU M0/M1 Balances Table
CREATE TABLE gru_balances (
    id INT PRIMARY KEY IDENTITY(1,1),
    account_id NVARCHAR(64) NOT NULL,
    balance_type NVARCHAR(2) NOT NULL CHECK (balance_type IN ('M0', 'M1')),
    currency_code CHAR(3) NOT NULL,
    balance DECIMAL(18,4) NOT NULL,
    as_of DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT fk_currency FOREIGN KEY (currency_code) REFERENCES currency_registry(currency_code)
);

-- Exchange Rate Table
CREATE TABLE exchange_rates (
    id INT PRIMARY KEY IDENTITY(1,1),
    from_currency CHAR(3) NOT NULL,
    to_currency CHAR(3) NOT NULL,
    rate DECIMAL(18,8) NOT NULL,
    valid_from DATETIME2 NOT NULL,
    valid_to DATETIME2 NULL,
    CONSTRAINT fk_from_currency FOREIGN KEY (from_currency) REFERENCES currency_registry(currency_code),
    CONSTRAINT fk_to_currency FOREIGN KEY (to_currency) REFERENCES currency_registry(currency_code)
);
