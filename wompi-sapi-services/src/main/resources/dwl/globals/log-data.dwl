%dw 2.0
output application/json
import * from dw::Runtime
var statusCode = if(!isEmpty(vars.httpStatus)) vars.httpStatus as String 
                else if (try (()-> payload.overallStatusCode).success == false or isEmpty(payload.overallStatusCode)) "201" 
                else payload.overallStatusCode
var attr = if(attributes == null) vars.attributes else attributes
var transactionId = if(!isEmpty(vars.headers)) vars.headers."x-correlation-id" else if (!isEmpty(attributes.headers."x-correlation-id")) attributes.headers."x-correlation-id" else correlationId
var host = if(isEmpty(attributes.remoteAddress)) vars.attributes.remoteAddress else attributes.remoteAddress
---
{
	transactionId: transactionId,
	correlationId: correlationId,
	processname: attributes.headers.processname,
	systemId: attributes.headers.systemId,
	attributes: write(attr, 'application/json') as String,
	appName: Mule:p('app.name'),
	host: host
} 