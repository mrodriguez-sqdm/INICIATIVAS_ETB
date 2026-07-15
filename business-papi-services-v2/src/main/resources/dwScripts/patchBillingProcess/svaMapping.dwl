%dw 2.0
var serviceEventId = "189"
var transaction = payload.transaction
var customer = payload.customer default {
}
var account = payload.account default {
}
var services = payload.services default []
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
	// services Mapping
	("billProdInstList": services map ((service) -> {
		"operate": operation,
		"areaCode": service.areaCode,
		"serviceNumber": service.serviceNumber,
		"socialLevel": service.socialLevel,
		"effDate": service.effectiveDate,
		"offerCode": service.offerCode,
		"bundleIdCRM": service.bundleIdCRM,
		"department": service.department,
		"city": service.city,
		"address": service.address,
		"originalDepartment": service.originalDepartment,
		"originalCity": service.originalCity,
		"originalAddress": service.originalAddress,
		"destDepartment": service.destDepartment,
		"destCity": service.destCity,
		"destAddress": service.destAddress,
		("contactDtoList": service.contacts map ((serviceContact) -> {
			"contactType": serviceContact.contactType,
			"operate": operation,
			"contactId": serviceContact.contactId,
			"firstName": serviceContact.firstName,
			"lastName": serviceContact.lastName,
			"email": serviceContact.email,
			"sms": serviceContact.sms,
			"mobilePhone": serviceContact.mobilePhone,
			"whatsapp": serviceContact.whatsApp,
			"fixedPhone": serviceContact.fixedPhone,
			"contactDocType": serviceContact.contactDocType,
			"contactDocNo": serviceContact.contactDocNo,
			"contactDocExpDate": serviceContact.DocExpDate,
			"country": serviceContact.country,
			"department": serviceContact.department,
			"city": serviceContact.city,
			"district": serviceContact.district,
			"addressName": serviceContact.addressName
		})) if (!isEmpty(service.contacts default []))
	})) if (!isEmpty(services default [])),
	// Service Attributes Mapping
	("billProdInstAttrList": services flatMap (bpi) -> bpi.attributes default [] map ((serviceAttr) -> {
		"operate": operation,
		"serviceNumber": bpi.serviceNumber,
		"attrCode": serviceAttr.attrCode,
		"value": serviceAttr.value,
		"effDate": serviceAttr.effectiveDate
	})) if (!isEmpty(flatten(services.attributes default []))),
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
		"operate": operation,
		"offerInstIdCRM": o.offerInstanceIdCRM,
		"attrCode": offerAttr.attrCode,
		"value": offerAttr.value,
		"effDate": offerAttr.effectiveDate
	})) if (!isEmpty(flatten(offers..attributes default []))),
	// Service Charges Mapping
	("chargeList": charges default [] map (charge) -> {
		"billingNbr": charge.billingNbr,
		"basicCharge": charge.basicCharge,
		"acctId": account.acctId,
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