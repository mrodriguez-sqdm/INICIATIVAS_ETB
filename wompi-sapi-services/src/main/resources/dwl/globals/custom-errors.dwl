%dw 2.0
output application/json
import * from dw::Runtime
import * from module_error_handler_plugin::common
fun getMessage() = do {
var messages = if (!isEmpty(error.errorMessage.payload.error.messages) and error.errorMessage.payload.error.messages is Object)
					write(error.errorMessage.payload.error.messages, 'application/json') as String
				else null
var reason = error.errorMessage.payload.error.reason default error.errorMessage.payload.error."type"
---
messages default reason
}
var errorDescription = do {
    var nested = [
        try(() -> getMessage()) orElse null,
        error.description        
    ] dw::core::Arrays::firstWith !isEmpty($)
    ---
    if (nested is Array)
        toString(nested map (toString($)) distinctBy $)
    else
        toString(nested)
}
var statusCode = error.exception.errorMessage.attributes.statusCode
var reasonPhrase = error.errorMessage.payload.error.reason default error.exception.errorMessage.attributes.reasonPhrase
---
{
	"HTTP:CONFLICT": {
        code: 409,
        reason: reasonPhrase default "Request Conflict",
        message: errorDescription default "The request could not be completed"
    },
	"MULE:UNKNOWN": {
        code: statusCode default 500,
        reason: reasonPhrase default "Internal Server Error",
        message: errorDescription default "Something went wrong, please try again or contact a system administrator" 
    }	
}