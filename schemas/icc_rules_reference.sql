-- ICC Rules Reference Table (UCP 600, URDTT)
CREATE TABLE icc_rules (
    id INT PRIMARY KEY IDENTITY(1,1),
    rule_code NVARCHAR(16) NOT NULL,
    rule_name NVARCHAR(128) NOT NULL,
    description NVARCHAR(1024) NULL,
    is_active BIT NOT NULL DEFAULT 1
);
-- Example insert
INSERT INTO icc_rules (rule_code, rule_name, description) VALUES
('UCP600', 'Uniform Customs and Practice for Documentary Credits', 'Standard for documentary credit operations'),
('URDTT', 'Uniform Rules for Digital Trade Transactions', 'Rules for digital transferable titles');
