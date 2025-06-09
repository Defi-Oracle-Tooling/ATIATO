-- ISO 20022 Message Mapping Table (example for pain.001)
CREATE TABLE iso20022_messages (
    id INT PRIMARY KEY IDENTITY(1,1),
    message_type NVARCHAR(32) NOT NULL,
    message_id NVARCHAR(64) NOT NULL,
    payload NVARCHAR(MAX) NOT NULL,
    received_at DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);

-- Add mapping/translation logic in application layer or via stored procedures as needed.
