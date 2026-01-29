%dw 2.0
import * from dw::core::Periods
output application/json
---
{
	"financialInstitutionCode": vars.payloadOri.bank.code,
	"entityCode": Mule::p('pse-sapi.fields.entityCode'),
	"serviceCode": Mule::p('pse-sapi.fields.serviceCode'),
	"transactionValue": vars.payloadOri.amount,
	"vatValue": (vars.payloadOri.taxes filter $.item == Mule::p('pse-sapi.fields.iva'))[0].value default 0,
	"ticketId": vars.payloadOri.invoiceNumber,
	"entityurl": vars.payloadOri.extraParameters.entityurl,
	"userType": vars.payloadOri.customer.document.userType default Mule::p('pse-sapi.fields.userType'),
	"soliciteDate": now() as String {
		format: "yyyy-MM-dd'T'HH:mm:ss.SSS"
	},
	"paymentDescription": vars.payloadOri.description,
	"referenceNumber1": vars.payloadOri.reference,
	"referenceNumber2": vars.payloadOri.reference2,
	"referenceNumber3": vars.payloadOri.reference3,
	"identificationType": vars.payloadOri.customer.document."type",
	"identificationNumber": vars.payloadOri.customer.document."number",
	"fullName": vars.payloadOri.customer.firstname ++ " " ++ vars.payloadOri.customer.lastname,
	"cellphoneNumber": vars.payloadOri.customer.phone as Number,
	"address": vars.payloadOri.customer.address.street1 ++ " " ++ vars.payloadOri.customer.address.street2,
	"email": vars.payloadOri.customer.email,
	"beneficiaryEntityIdentificationType": Mule::p('pse-sapi.fields.beneficiaryEntityIdentificationType'),
	"beneficiaryEntityIdentification": Mule::p('pse-sapi.fields.beneficiaryEntityIdentification'),
	"beneficiaryEntityName": Mule::p('pse-sapi.fields.beneficiaryEntityName'),
	"beneficiaryEntityCIIUCategory": Mule::p('pse-sapi.fields.beneficiaryEntityCIIUCategory'),
	"beneficiaryIdentificationType": vars.payloadOri.beneficiary.document."type",
	"beneficiaryIdentification": vars.payloadOri.beneficiary.document."number",
	"indicator4per1000": vars.payloadOri.extraParameters.indicator4per1000 default 0
}