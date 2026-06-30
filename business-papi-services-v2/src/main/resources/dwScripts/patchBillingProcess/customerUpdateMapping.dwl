%dw 2.0
var serviceEventId = "802"
var transaction = payload.transaction
var customer = payload.customer default {}
var account = payload.account default {}
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
      "operate": custContact.operate,
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
    "operate": custAttr.operate,
    "custId": customer.custId default transaction.custId,
    "attrCode": custAttr.attrCode,
    "value": custAttr.value,
    "effDate": custAttr.effectiveDate
  })) if (!isEmpty(customer.attributes default []))
}