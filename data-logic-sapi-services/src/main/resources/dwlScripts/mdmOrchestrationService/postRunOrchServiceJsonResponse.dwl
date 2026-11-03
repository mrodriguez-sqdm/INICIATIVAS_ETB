%dw 2.0
output application/json skipNullOn = "everywhere"
var result = payload.body.RunOrchServiceResponse.OrchOutput
var header = result.OrchResponseHeader
var body = result.OrchResponseBody
---
{
	responseHeader: {
		externalId: header.ExternalId,
		system: header.System
	},
	responseBody: {
		id: body.Id,
		response: {
			code: body.Response.Code,
			status: body.Response.Status,
			description: body.Response.Description,
			customDescription: body.Response.DescCustom
		},
		xmlData: body.XmlData
	}
}