# SWIFT FIN MT Standard

SWIFT FIN MT (Message Types) is a set of message standards used for international financial messaging, especially for interbank payments and securities transactions. It is widely used for cross-border payments and is governed by SWIFT.

## Key Features

- Text-based message format (block structure)
- Used for payments (MT 103), cash management, securities, and trade
- Strict field and block definitions

## Reference

- [SWIFT FIN MT Standards](https://www.swift.com/standards/)
- [MT Message Reference Guide](https://www2.swift.com/knowledgecentre/publications/us7/us7.pdf)

---
For implementation details, see `schemas/swift_mt_mapping.sql` and `modules/swift_mt_parser.py`.
