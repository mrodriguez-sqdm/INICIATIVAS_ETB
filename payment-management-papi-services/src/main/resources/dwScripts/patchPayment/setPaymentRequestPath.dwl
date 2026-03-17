%dw 2.0
output application/json

var gateway = (lower(payload.gateway default ""))

---
gateway match {

	case "pse" ->
		readUrl('classpath://dwScripts/patchPayment/setPatchPseRequest.dwl', 'text/plain')

	case "etb" ->
		readUrl('classpath://dwScripts/patchPayment/setPatchMongoRequest.dwl', 'text/plain')

	else -> ""
}