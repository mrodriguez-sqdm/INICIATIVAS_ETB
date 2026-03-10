%dw 2.0
output application/xml
ns ns1 http://www.etb.com.co/LTE/WS/BillingCorporate/CreateSystemsAccountsMsgs
ns ns2 http://www.etb.com.co/LTE/commons/WSResponseHeader2/v1.0
ns ns3 http://www.etb.com.co/LTE/WS/BillingCorporate/ResponseData
---
{
	ns1#CreateSystemsAccountsOUT: {
		ns2#WSResponseHeader2: {
			ns2#System: {
				ns2#name: vars.initialPayload.body.CreateSystemsAccountsIN.WSRequestHeader2.System.name,
				ns2#correlationID: vars.initialPayload.body.CreateSystemsAccountsIN.WSRequestHeader2.System.correlationID default correlationId,
				ns2#processingServer: "MuleSoft"
			},
			ns2#Service: {
				ns2#status: "OK",
				ns2#responseDate: now(),
				//(ns2#statusDetail: {
					//ns2#errorCode: payload.errorCode,
					//ns2#errorMessage: payload.errorMessage
				//}) if (payload.status == "NOK")
			}
		},
		ns1#CreateSystemsAccountsOutput: {
			ns3#ResponseData: {
				ns3#CreateBillingAccountResponse: {
					ns3#Code: payload.responseData.createBillingAccountResponse.code,
					ns3#Description: payload.responseData.createBillingAccountResponse.description,
					(ns3#response: payload.responseData.createBillingAccountResponse.response) if(payload.responseData.createBillingAccountResponse.response?)
				},
				ns3#CreateRMCAAccountResponse: {
					ns3#Code: payload.responseData.createRMCAAcountResponse.code,
					ns3#Description: payload.responseData.createRMCAAcountResponse.description
				},
				ns3#CreateMDMAccountResponse: {
					ns3#Code: payload.responseData.createMDMAccountResponse.code,
					ns3#Description: payload.responseData.createMDMAccountResponse.description
				}
			}
		}
	}
}