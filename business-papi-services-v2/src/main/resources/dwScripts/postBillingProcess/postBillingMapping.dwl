%dw 2.0
import * from dw::Runtime
output application/json  skipNullOn = "everywhere"
var serviceEventId = payload.processCode  match {
	case "SALE" -> "1"
    case "NEW_CUSTOMER" -> "806"
    case "NEW_ACCOUNT" -> "807"
    case "SALE_BUNDLE" -> "808"
    else -> fail("Invalid Process Code")
}
var transaction = payload.transaction
var customer = payload.customer default {
}
var account = payload.account default {
}
var services = payload.services default []
var serviceNumber = transaction.serviceNumber
var operation = "A"
var currency = "1"
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
	// Customer Mapping
	("cust": {
		"operate": operation,
		"custId": customer.custId default transaction.custId,
		"custName": customer.custName,
		"firstName": customer.firstName,
		"lastName": customer.lastName,
		"middleName": customer.middleName,
		"secondLastName": customer.middleName,
		"gender": customer.gender,
		"title": customer.title,
		"birthday": customer.birthday,
		"docType": customer.docType,
		"docNumber": customer.docNumber,
		"issueLugar": customer.issueLugar,
		"issueDate": customer.issueDate,
		"docExpDate": customer.docExpDate,
		"typeFlag": customer.typeFlag default "1",
		"occupation": customer.occupation,
		"industry": customer.industry,
		"contactPhone": customer.contactPhone,
		"email": customer.email,
		"country": customer.country,
		"departament": customer.departament,
		"city": customer.city,
		"district": customer.district,
		"address": customer.address,
		"customerSegment": customer.customerSegment,
		"nombreJuridico": customer.nombreJuridico,
		"subSegmento": customer.subSegmento,
		"categoria": customer.categoria,
		"habeasData": customer.habeasData,
		"autoretentionFlag": customer.autoretentionFlag,
		"vipFlag": customer.vipFlag,
		"paymentRiskLevel": customer.paymentRiskLevel,
		"blockNotification": customer.blockNotification,
		("contactDtoList": customer.contacts map ((custContact) -> {
			"contactType": custContact.contactType,
			"operate": operation,
			"contactId": custContact.contactId,
			"firstName": custContact.firstName,
			"lastName": custContact.lastName,
			"email": custContact.email,
			"sms": custContact.sms,
			"mobilePhone": custContact.mobilePhone,
			"whatsapp": custContact.whatsApp,
			"fixedPhone": custContact.fixedPhone,
			"contactDocType": custContact.contactDocType,
			"contactDocNo": custContact.contactDocNo,
			"contactDocExpDate": custContact.DocExpDate,
			"country": custContact.country,
			"department": custContact.department,
			"city": custContact.city,
			"district": custContact.district,
			"addressName": custContact.addressName
		})) if (!isEmpty(customer.contacts default []))
	}) if (!isEmpty(customer default {
	})),
	// Customer Attributes Mapping
	("custAttrList": customer.attributes map ((custAttr) -> {
		"operate": operation,
		"custId": customer.custId default transaction.custId,
		"attrCode": custAttr.attrCode,
		"value": custAttr.value,
		"effDate": custAttr.effectiveDate
	})) if (!isEmpty(customer.attributes default [])),
	// Account Mapping
	("account": {
		"operate": operation,
		"acctId": account.acctId default transaction.acctId,
		"acctName": account.acctName,
		"billDeliveryType": account.billDeliveryType,
		"paymentMode": account.paymentMode,
		"corte": account.corte,
		"defaultAccount": account.defaultAccount,
		"parentAccountId": account.parentaccountId,
		"billFlag": account.billFlag,
		"taxExempt": account.taxExempt,
		"dunningExemption": account.dunningExemption,
		"dunningExemEff": account.dunningExemEff,
		"dunningExemExp": account.dunningExemExp,
		"contractName": account.contractName,
		"roundingAdjustmentFlag": account.roundingAdjustmentFlag,
		"previousBalanceFlag": account.previousBalanceFlag,
		"coverPageOnlyFlag": account.coverPageOnlyFlag,
		"interestChargeFlag": account.interestChargeFlag,
		"interestRateType": account.interestRateType,
		"dunningManagementTime": account.dunningManagementTime,
		"country": account.country,
		"departament": account.departament,
		"city": account.city,
		"district": account.district,
		"address": account.address,
		"paymentTerm": account.paymentTerm,
		"effDate": account.effDate,
		("contactDtoList": account.contacts map ((acctContact) -> {
			"contactType": acctContact.contactType,
			"operate": operation,
			"contactId": acctContact.contactId,
			"firstName": acctContact.firstName,
			"lastName": acctContact.lastName,
			"email": acctContact.email,
			"sms": acctContact.sms,
			"mobilePhone": acctContact.mobilePhone,
			"whatsapp": acctContact.whatsApp,
			"fixedPhone": acctContact.fixedPhone,
			"contactDocType": acctContact.contactDocType,
			"contactDocNo": acctContact.contactDocNo,
			"contactDocExpDate": acctContact.DocExpDate,
			"country": acctContact.country,
			"department": acctContact.department,
			"city": acctContact.city,
			"district": acctContact.district,
			"addressName": acctContact.addressName
		})) if (!isEmpty(account.contacts default []))
	}) if (!isEmpty(account default {
	})),
	// Account Attributes Mapping
	("acctAttrList": account.attributes map ((acctAttr) -> {
		"operate": operation,
		"acctId": account.acctId default transaction.acctId,
		"attrCode": acctAttr.attrCode,
		"value": acctAttr.value,
		"effDate": acctAttr.effectiveDate
	})) if (!isEmpty(account.attributes default [])),
	// services Mapping
	("billProdInstList": services map ((service) -> {
		"operate": operation,
		"areaCode": service.areaCode,
		"serviceNumber": service.serviceNumber,
		"socialLevel": service.socialLevel,
		"effDate": service.effectiveDate,
		"offerCode": service.offerCode,
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
	("billOfferInstList": services flatMap (boi) -> boi.offers default [] map ((offer) -> {
		"operate": operation,
		"offerInstIdCRM": offer.offerInstanceIdCRM,
		"offerCode": offer.offerCode,
		"effDate": offer.effectiveDate,
		"expDate": offer.expirationDate,
		"instanceIdCRM": boi.serviceNumber
	})) if (!isEmpty(flatten(services.offers default []))),
	// Service Offers Attributes Mapping
	("billOfferInstAttrList": services flatMap (boi) -> boi.offers default [] flatMap (o) -> o.attributes default [] map ((offerAttr) -> {
		"operate": operation,
		"offerInstIdCRM": o.offerInstanceIdCRM,
		"attrCode": offerAttr.attrCode,
		"value": offerAttr.value,
		"effDate": offerAttr.effectiveDate
	})) if (!isEmpty(flatten(services.offers..attributes default []))),
	// Service Charges Mapping
	("chargeList": services flatMap (chl) -> chl.charges default [] map (charge) -> {
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
	}) if (!isEmpty(flatten(services.charges default [])))
}