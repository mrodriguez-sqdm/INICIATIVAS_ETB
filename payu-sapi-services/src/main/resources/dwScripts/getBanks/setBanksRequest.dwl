%dw 2.0
output application/json
---
{
	"language": p('payu.language'),
	"test": p('payu.test'),
	"command": p('payu.getBanks.command'),
	"merchant": {
		"apiLogin": p('secure::payu.apiLogin'),
		"apiKey": p('secure::payu.apiKey')
	},
	"bankListInformation": {
		"paymentMethod": p('payu.getBanks.paymentMethod'),
		"paymentCountry": p('payu.paymentCountry')
	}
}

