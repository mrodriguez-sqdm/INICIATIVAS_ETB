%dw 2.0
var serviceEventId = "189"
var transaction = payload.transaction
var customer = payload.customer default {
}
var account = payload.account default {
}
var attributes = payload.attributes default []
var offers = payload.offers default []
var charges = payload.charges  default []
var serviceNumber = transaction.serviceNumber
var operation = "M"
var currency = "1"
output application/json  skipNullOn = "everywhere"
---
{
	// Header Mapping
	"header": {
		"transactionId": transaction.id,
		"createDate": transaction.timestamp,
		"orderItemId": transaction.orderItemId,
		"serviceEventId": serviceEventId,
		"custId": transaction.custId,
		"acctId": transaction.acctId,
		"serviceNumber": serviceNumber,
		"salesChannel": transaction.salesChannel,
		"salesDepartment": transaction.salesDepartment,
		"salesCity": transaction.salesCity,
		"po": transaction.po,
		"billType": transaction.billType,
		"comments": transaction.comments
	},
	// Service Attributes Mapping
	("billProdInstAttrList": attributes default [] map ((serviceAttr) -> {
		"operate": operation,
		"serviceNumber": serviceNumber,
		"attrCode": serviceAttr.attrCode,
		"value": serviceAttr.value,
		"effDate": serviceAttr.effectiveDate
	})) if (!isEmpty(flatten(attributes default []))),
	// Service Offers Mapping
	("billOfferInstList": offers default [] map ((offer) -> {
		"operate": offer.operate,
		"offerInstIdCRM": offer.offerInstanceIdCRM,
		"offerCode": offer.offerCode,
		"effDate": offer.effectiveDate,
		"expDate": offer.expirationDate,
		"instanceIdCRM": serviceNumber
	})) if (!isEmpty(flatten(offers default []))),
	// Service Offers Attributes Mapping
	("billOfferInstAttrList": offers default [] flatMap (o) -> o.attributes default [] map ((offerAttr) -> {
		"operate": offerAttr.operate,
		"offerInstIdCRM": o.offerInstanceIdCRM,
		"attrCode": offerAttr.attrCode,
		"value": offerAttr.value,
		"effDate": offerAttr.effectiveDate
	})) if (!isEmpty(flatten(offers..attributes default []))),
	// Service Charges Mapping
	("chargeList": charges default [] map (charge) -> {
		"billingNbr": charge.billingNbr,
		"basicCharge": charge.basicCharge,
		"acctId": charge.acctId default transaction.acctId,
		"chargeType": charge."type",
		"perCharge": charge.perCharge,
		"acctItemTypeCode": charge.acctItemTypeCode,
		"installmentPlanId": charge.installmentPlanId,
		"prodInstFlag": charge.prodInstFlag,
		"origAcctItemTypeCode": charge.origAcctItemTypeCode,
		"currencyId": currency,
		"paidFlag": charge.paidFlag
	}) if (!isEmpty(flatten(charges default [])))
}