%dw 2.0
output application/json
---
lower(payload.gateway.paymentFlow default "")