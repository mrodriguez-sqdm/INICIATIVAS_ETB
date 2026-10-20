%dw 2.0
output application/json
---
{
  code: "200",
  message: "Services retrieved successfully",
  "result": {
		cus: payload.data.id,
		gatewayAttributes: {
            gateway: "WOMPI",
            gatewayType: "CHECKOUT"
        }
	} ++ payload.data
}