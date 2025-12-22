%dw 2.0
import * from dw::Runtime
import * from dw::core::Strings
fun titleCase(text) = (lower(text) splitBy " " map ((item, index) -> capitalize(item)) joinBy " ")
fun getMessageType() = do {
var muleType = titleCase(error.errorType.namespace ++ " " ++ error.errorType.identifier) default "Server Error"
---
//Verificar aqui como viene el error en el payload de payu
try(() -> error.errorMessage.payload.error."type" default muleType) orElse "Server Error"
}
output application/json
---
payload.error ++ {	
	status: getMessageType(),
	"timestamp": now() as String {format: "yyyy-MM-dd'T'HH:mm:ss"},
	correlationId: correlationId
}