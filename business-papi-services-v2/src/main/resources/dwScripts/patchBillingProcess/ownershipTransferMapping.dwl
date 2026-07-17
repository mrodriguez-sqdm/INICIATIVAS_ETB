%dw 2.0
var serviceEventId = "67"
var transaction = payload.transaction
var customer = payload.newCustomer default {
}
var account = payload.newAccount default {
}
var serviceNumber = transaction.serviceNumber
var operationServices = "M"
var operation = "A"
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
		"newCustId": transaction.newCustId,
		"newAcctId": transaction.newAcctId,
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
		"custId": customer.custId,
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
		"department": customer.department,
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
		("contactDtoList": customer.contacts default [] map ((custContact) -> {
			"operate": custContact.operate default operation,
			"contactType": custContact.contactType,
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
	("custAttrList": customer.attributes default [] map ((custAttr) -> {
		"operate": custAttr.operate default operation,
		"custId": custAttr.custId default transaction.custId,
		"attrCode": custAttr.attrCode,
		"value": custAttr.value,
		"effDate": custAttr.effectiveDate
	})) if (!isEmpty(customer.attributes default [])),
	// Account Mapping
	("account": {
		"operate": operation,
		"acctId": account.acctId,
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
		"department": account.department,
		"city": account.city,
		"district": account.district,
		"address": account.address,
		"paymentTerm": account.paymentTerm,
		"effDate": account.effDate,
		("contactDtoList": account.contacts map ((acctContact) -> {
			"operate": acctContact.operate default operation,
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
		"operate": acctAttr.operate default operation,
		"acctId": acctAttr.acctId default transaction.acctId,
		"attrCode": acctAttr.attrCode,
		"value": acctAttr.value,
		"effDate": acctAttr.effectiveDate
	})) if (!isEmpty(account.attributes default [])),
}