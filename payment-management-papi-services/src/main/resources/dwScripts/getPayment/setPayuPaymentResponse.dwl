%dw 2.0
output application/json
---
{
  code: "200",
  message: "Services retrieved successfully",
  "result": {
		cus: vars.paymentId,
		gatewayAttributes: {
            gateway: "PAYU",
            gatewayType: "API"
        }
	} ++ payload.data
}