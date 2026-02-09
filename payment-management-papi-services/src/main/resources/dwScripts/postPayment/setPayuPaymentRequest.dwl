%dw 2.0
output application/json skipNullOn = "everywhere"
---
{
	// ===== ORDER =====
	order: {
		accountId: Mule::p("payu-sapi.fields.accountId"),
		referenceCode: payload.reference,
		description: payload.description,
		language: Mule::p("payu-sapi.fields.language"),
		signature: Mule::p("payu-sapi.fields.signature") default payload.signature,
		notifyUrl: Mule::p("payu-sapi.fields.notifyUrl") default payload.notifyUrl,
		additionalValues: (payload.taxes default []) map ((item) -> {
			(if ( item.code == "CONSUMO" ) "TX_TAX_RETURN_BASE": {
				value: item.value,
				currency: payload.currency
			}
            else"TX_TAX": {
				value: item.value,
				currency: payload.currency
			})
		}) ++ [{
			"TX_VALUE": {
				"value": sum(payload.taxes.value),
				"currency": payload.currency
			}
		}] reduce ((item, acc = {
		}) -> item ++ acc),
		buyer: {
			merchantBuyerId: "1",
			fullName: payload.customer.firstname,
			emailAddress: payload.customer.email,
			contactPhone: payload.customer.phone,
			dniNumber: payload.customer.document.number,
			shippingAddress: payload.customer.address ++ {
				phone: payload.customer.phone
			}
		},
		shippingAddress: payload.customer.address ++ {
			phone: payload.customer.phone
		}
	},
	// ===== PAYER =====
	payer: {
		merchantPayerId: "1",
		fullName: "First name and second payer name",
		emailAddress: "payer_test@test.com",
		contactPhone: payload.customer.phone,
		dniNumber: "5415668464655",
		billingAddress: payload.customer.address ++ {
			phone: payload.customer.phone
		}
	},
	// ===== PAYMENT DATA =====
	creditCard: {
		number: payload.paymentMethod.number,
		securityCode: payload.paymentMethod.securityCode,
		expirationDate: payload.paymentMethod.expirationDate,
		name: payload.paymentMethod.name
	},
	extraParameters: payload.extraParameters,
	"type": Mule::p("payu-sapi.fields.type"),
	paymentMethod: Mule::p("payu-sapi.fields.paymentMethod"),
	paymentCountry: Mule::p("payu-sapi.fields.paymentCountry"),
	deviceSessionId: payload.deviceSessionId,
	ipAddress: payload.ipAddress,
	cookie: payload.cookie,
	userAgent: payload.userAgent,
	threeDomainSecure: payload.threeDomainSecure
}