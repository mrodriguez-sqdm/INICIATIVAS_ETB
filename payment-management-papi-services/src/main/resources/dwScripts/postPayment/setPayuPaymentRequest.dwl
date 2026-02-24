%dw 2.0
output application/json skipNullOn = "everywhere"
---
{
	// ===== ORDER =====
	order: {
		accountId: Mule::p("payu-sapi.fields.accountId"),
		referenceCode: payload.reference,
		description: payload.description,
		language: payload.language,
		notifyUrl: payload.notifyUrl,
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
			merchantBuyerId: payload.customer.document.number,
			fullName: payload.customer.firstname ++ " " ++ payload.customer.lastname,
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
		merchantPayerId: payload.customer.document.number,
		fullName: payload.customer.firstname ++ " " ++ payload.customer.lastname,
		emailAddress: payload.customer.email,
		contactPhone: payload.customer.phone,
		dniNumber: payload.customer.document.number,
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
	paymentMethod: payload.paymentMethod.code,
	paymentCountry: payload.paymentCountry,
	deviceSessionId: payload.deviceSessionId,
	ipAddress: payload.ipAddress,
	cookie: payload.cookie,
	userAgent: payload.userAgent,
	threeDomainSecure: payload.threeDomainSecure
}