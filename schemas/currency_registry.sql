-- ISO 4217 Currency Registry Table
CREATE TABLE currency_registry (
    currency_code CHAR(3) PRIMARY KEY,
    currency_name NVARCHAR(64) NOT NULL,
    minor_unit INT NOT NULL
);
