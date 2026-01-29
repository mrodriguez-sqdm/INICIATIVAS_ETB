%dw 2.0
import * from dw::core::Periods
output application/json
---
{
	"name": vars.payloadOri.name,
	"description": vars.payloadOri.description,
	"single_use": Mule::p('wompi.fields.singleUse') == "true" default true,
	"collect_shipping": Mule::p('wompi.fields.collectShipping') default false,
	"amount_in_cents": vars.payloadOri.amount,
	"currency": vars.payloadOri.currency,
	"reference": vars.payloadOri.reference,
	"sku": vars.payloadOri.sku,
	"expires_at": vars.payloadOri.expiresAt default (now() + hours(4)) as String {
		format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
	},
	"redirect_url": vars.payloadOri.redirectUrl default Mule::p('wompi.fields.redirectUrl'),
	"image_url": vars.payloadOri.imageUrl default Mule::p('wompi.fields.imageUrl'),
	"active": true,
	"customer_data": {
		"customer_references": payload.customerData.customerReferences map ((item, index) -> {
			"label": item.label,
			"is_required": item.isRequired
		})
	},
	"taxes": vars.payloadOri.taxes map ((item, index) ->
          {
		"type": item.code,
		"amount_in_cents": item.value
	}
        )
} 