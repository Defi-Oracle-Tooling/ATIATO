-- ISO 8583 Message Mapping Table (for card-based transactions)
CREATE TABLE iso8583_messages (
    id INT PRIMARY KEY IDENTITY(1,1),
    message_type NVARCHAR(16) NOT NULL,
    message_id NVARCHAR(64) NOT NULL,
    payload NVARCHAR(MAX) NOT NULL,
    received_at DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);

-- Add mapping/translation logic in application layer or via stored procedures as needed.
