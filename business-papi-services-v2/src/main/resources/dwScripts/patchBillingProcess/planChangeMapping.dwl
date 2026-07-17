%dw 2.0
import * from dw::Runtime
output application/json  skipNullOn = "everywhere"
var serviceEventId = payload.processCode  match {
	case "PLAN_CHANGE" -> "329"
    case "PLAN_CHANGE_BUNDLE" -> "809"
    else -> fail("Invalid Process Code")
}
var transaction = payload.transaction
var customer = payload.customer
var account = payload.account
var service = payload.service default {
}
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
	("billProdInst": {
		"operate": operation,
		"serviceNumber": service.serviceNumber,
		"socialLevel": service.socialLevel,
		"effDate": service.effectiveDate,
		"offerCode": service.newOfferCode,
		"department": service.department,
		"city": service.city,
		"address": service.address,
		"originalDepartment": service.originalDepartment,
		"originalCity": service.originalCity,
		"originalAddress": service.originalAddress,
		"destDepartment": service.destDepartment,
		"destCity": service.destCity,
		"destAddress": service.destAddress,
		("bundleMemberList": service.bundleMembers map ((bundleMember) -> {
			"operate": bundleMember.operate,
			"serviceNumber": bundleMember.serviceNumber
		})) if (!isEmpty(service.bundleMembers default [])),
		("contactDtoList": service.contacts map ((serviceContact) -> {
			"contactType": serviceContact.contactType,
			"operate": serviceContact.operate default operation,
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
	}) if (!isEmpty(service default {
	})),
	// Service Attributes Mapping
	("billProdInstAttrList": service.attributes default [] map ((serviceAttr) -> {
		"operate": serviceAttr.operate default operation,
		"serviceNumber": service.serviceNumber,
		"attrCode": serviceAttr.attrCode,
		"value": serviceAttr.value,
		"effDate": serviceAttr.effectiveDate
	})) if (!isEmpty(flatten(service.attributes default []))),
	// Service Offers Mapping
	("billOfferInstList": service.offers default [] map ((offer) -> {
		"operate": offer.operate default operation,
		"offerInstIdCRM": offer.offerInstanceIdCRM,
		"offerCode": offer.offerCode,
		"effDate": offer.effectiveDate,
		"expDate": offer.expirationDate,
		"instanceIdCRM": service.serviceNumber
	})) if (!isEmpty(flatten(service.offers default []))),
	// Service Offers Attributes Mapping
	("billOfferInstAttrList": service.offers default [] flatMap (so) -> so.attributes default [] map ((offerAttr) -> {
		"operate": offerAttr.operate default operation,
		"offerInstIdCRM": so.offerInstanceIdCRM,
		"attrCode": offerAttr.attrCode,
		"value": offerAttr.value,
		"effDate": offerAttr.effectiveDate
	})) if (!isEmpty(flatten(service.offers.attributes default []))),
	// Service Charges Mapping
	("chargeList": service.charges default [] map (charge) -> {
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
	}) if (!isEmpty(flatten(service.charges default [])))
}