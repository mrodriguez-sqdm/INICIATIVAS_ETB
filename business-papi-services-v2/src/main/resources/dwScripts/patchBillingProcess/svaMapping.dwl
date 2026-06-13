%dw 2.0
var serviceEventId = "189"
var transaction = payload.transaction
var customer = payload.customer
var account = payload.account
var services = payload.services default []
var productInstId = transaction.prodInstId
var operation = "M"
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
    "prodInstId": productInstId,
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
      "operate": operation,
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
  // Service Attributes Mapping
  ("billProdInstAttrList": services flatMap (bpi) -> bpi.attributes default [] map ((serviceAttr) -> {
      "operate": operation,
      "prodInstId": bpi.prodInstId,
      "attrCode": serviceAttr.attrCode,
      "value": serviceAttr.value,
      "effDate": serviceAttr.effectiveDate
    })) if (!isEmpty(flatten(services.attributes default []))),
  // Service Offers Mapping
  ("billOfferInstList": services flatMap (boi) -> boi.offers default [] map ((offer) -> {
      "operate": offer.operate,
      "offerInstId": offer.offerInstanceId,
      "offerCode": offer.offerCode,
      "effDate": offer.effectiveDate,
      "expDate": offer.expirationDate,
      "intanceId": boi.prodInstId
    })) if (!isEmpty(flatten(services.offers default []))),
  // Service Offers Attributes Mapping
  ("billOfferInstAttrList": services flatMap (boi) -> boi.offers default [] flatMap (o) -> o.attributes default [] map ((offerAttr) -> {
        "operate": operation,
        "offerInstId": o.offerInstanceId,
        "attrCode": offerAttr.attrCode,
        "value": offerAttr.value,
        "effDate": offerAttr.effectiveDate
      })) if (!isEmpty(flatten(services.offers..attributes default []))),
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