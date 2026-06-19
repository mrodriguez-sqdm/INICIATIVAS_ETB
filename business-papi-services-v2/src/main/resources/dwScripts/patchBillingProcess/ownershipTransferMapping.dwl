%dw 2.0
var serviceEventId = "67"
var transaction = payload.transaction
var customer = payload.newCustomer default {}
var account = payload.newAccount default {}
var services = payload.services default []
var productInstId = transaction.prodInstId
var operationServices = "M"
var operation = "A"
var currency = "1"
output application/json  skipNullOn="everywhere"
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
    "prodInstId": productInstId,
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
      "operate": custContact.operate default operation,
      "contactType": custContact.contactType,
      "contactID": custContact.contactId,
      "firstName": custContact.firstName,
      "lastName": custContact.lastName,
      "email": custContact.email,
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
  }) if (!isEmpty(customer default {})),
  // Customer Attributes Mapping
  ("custAttrList": customer.attributes map ((custAttr) -> {
    "operate": operation,
    "custId": customer.custId,
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
    "departament": account.department,
    "city": account.city,
    "district": account.district,
    "address": account.address,
    "paymentTerm": account.paymentTerm,
    "effDate": account.effDate,
    ("contactDtoList": account.contacts map ((acctContact) -> {
      "operate": acctContact.operate default operation,
      "contactType": acctContact.contactType,
      "operate": operation,
      "contactID": acctContact.contactId,
      "firstName": acctContact.firstName,
      "lastName": acctContact.lastName,
      "email": acctContact.email,
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
  }) if (!isEmpty(account default {})),
  // Account Attributes Mapping
  ("acctAttrList": account.attributes map ((acctAttr) -> {
    "operate": operation,
    "acctId": account.acctId,
    "attrCode": acctAttr.attrCode,
    "value": acctAttr.value,
    "effDate": acctAttr.effectiveDate
  })) if (!isEmpty(account.attributes default [])),
  // services Mapping
  ("billProdInstList": services map ((service) -> {
    "operate": operationServices,
    "prodInstId": service.prodInstId,
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
      "operate": operationServices,
      "contactID": serviceContact.contactId,
      "firstName": serviceContact.firstName,
      "lastName": serviceContact.lastName,
      "email": serviceContact.email,
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
  // Service Charges Mapping
  ("chargeList": services flatMap (chl) -> chl.charges default [] map (charge) -> {
      "billingNbr": charge.billingNbr,
      "basicCharge": charge.basicCharge,
      "prodInstId": chl.prodInstId,
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