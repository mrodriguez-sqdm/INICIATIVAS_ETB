%dw 2.0
output application/xml skipNullOn = "everywhere"
ns orc http://orchestration.cloud.etb.com.co
---
{
	orc#RunOrchService: {
		orc#OrchInput: {
			orc#OrchRequestHeader: {
				orc#ExternalId: payload.requestHeader.externalId,
				orc#System: payload.requestHeader.system
			},
			orc#OrchRequestBody: {
				orc#Id: payload.requestBody.id,
				orc#Version: payload.requestBody.version,
				orc#Parameters: {
					orc#Parameter: payload.requestBody.parameters map (param) -> {
						orc#Attribute: param.attribute,
						orc#Value: param.value
					}
				}
			}
		}
	}
}