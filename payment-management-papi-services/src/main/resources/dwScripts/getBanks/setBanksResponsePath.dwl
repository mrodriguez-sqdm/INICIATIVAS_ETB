%dw 2.0
output application/json
---
(attributes.uriParams.paymentMethod) match {
	case "payu" -> readUrl('classpath://dwScripts/getBanks/setPayuBanksResponse.dwl')
	case "wompi" -> readUrl('classpath://dwScripts/getBanks/setWompiBanksResponse.dwl')
	case "pse" -> readUrl('classpath://dwScripts/getBanks/setPseBanksResponse.dwl')
	else -> ""
}
