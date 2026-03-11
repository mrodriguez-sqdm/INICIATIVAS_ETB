%dw 2.0
output application/json
---
(lower(attributes.queryParams.GATEWAY_PAYMENT default "")) match {
	case "payu" -> readUrl('classpath://dwScripts/getBanks/setPayuBanksResponse.dwl', 'text/plain')
	case "wompi" -> readUrl('classpath://dwScripts/getBanks/setWompiBanksResponse.dwl', 'text/plain')
	case "pse" -> readUrl('classpath://dwScripts/getBanks/setPseBanksResponse.dwl', 'text/plain')
	else -> ""
}
