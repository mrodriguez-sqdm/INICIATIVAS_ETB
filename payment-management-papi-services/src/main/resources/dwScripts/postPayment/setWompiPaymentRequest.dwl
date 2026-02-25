%dw 2.0
output application/json
---
{
	"name": vars.payloadOri.name,
	"description": vars.payloadOri.description,
	"single_use": Mule::p('wompi.fields.singleUse') == "true" default true,
	"collect_shipping": Mule::p('wompi.fields.collectShipping') default false,
	"amount_in_cents": (vars.payloadOri.amount * 100),
	"currency": vars.payloadOri.currency,
	"reference": vars.payloadOri.reference,
	"sku": vars.payloadOri.sku,
	"expires_at": (vars.payloadOri.expiresAt) default (now() + |PT4H|) as String {
		format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
	},
	"redirect_url": vars.payloadOri.redirectUrl default Mule::p('wompi.fields.redirectUrl'),
	"active": true,
	"customer_data": {
		"customer_references": vars.payloadOri.customerData.customerReferences map (item, index) -> {
			"label": item.label,
			"is_required": item.isRequired
		}
	},
	"taxes": payload.taxes map (item, index) -> 
        (item.code) match {
		case "IVA" -> {
			"type": "VAT",
			"amount_in_cents": (item.value * 100)
		}
            case "CONSUMO" -> {
			"type": "CONSUMPTION",
			"amount_in_cents": (item.value * 100)
		}
            else -> {
			"type": item.code,
			"amount_in_cents": (item.value * 100)
		}
	}
} 