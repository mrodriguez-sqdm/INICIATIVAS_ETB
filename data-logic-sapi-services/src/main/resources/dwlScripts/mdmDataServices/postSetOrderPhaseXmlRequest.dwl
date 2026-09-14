%dw 2.0
output application/xml skipNullOn = "everywhere"
ns mdm http://www.etb.com.co/Gateway/MDM_Data_Services
var req = payload
---
{
	mdm#Set_Order_Phase: {
		mdm#WSRequestHeader: {
			mdm#system: {
				mdm#name: req.requestHeader.system.name,
				mdm#correlationId: req.requestHeader.system.correlationId,
				mdm#processingServer: req.requestHeader.system.processingServer
			},
			mdm#property: {
				mdm#Property: req.requestHeader.properties map (item) -> {
					mdm#name: item.name,
					mdm#value: item.value
				}
			}
		},
		mdm#WSRequestBody: {
			mdm#order_number: req.requestBody.orderNumber,
			mdm#result: req.requestBody.result,
			mdm#phase: req.requestBody.phase,
			mdm#causal_phase: req.requestBody.phaseCause,
			mdm#update_user: req.requestBody.updateUser,
			mdm#status: req.requestBody.status,
			mdm#code: req.requestBody.code,
			mdm#detail: req.requestBody.detail,
			mdm#retry: req.requestBody.retry
		}
	}
}