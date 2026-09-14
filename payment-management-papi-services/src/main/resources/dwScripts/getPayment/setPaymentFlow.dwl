%dw 2.0
output application/json
---
(lower(attributes.queryParams.PAYMENT_FLOW default ""))