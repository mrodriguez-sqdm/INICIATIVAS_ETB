%dw 2.0
output application/json
---
(lower(attributes.queryParams.GATEWAY_PAYMENT default ""))