%dw 2.0
output application/json
---
{
  code: "200",
  message: "Services retrieved successfully",
  "result": {
		cus: payload.trazabilityCode,
		gatewayAttributes: {
            gateway: "PSE",
            gatewayType: "API"
        }
	} ++ payload
}