%dw 2.0
import * from dw::core::Periods
output application/json
var refs = payload.references default []
var totalAmount = sum(refs map $.totalAmount)
var ivaValue = sum(refs flatMap ($.taxes default []) filter ($."type" == "IVA") map $.value)
var paymentDescription = (refs map $.description) joinBy ", "
var fechaHora =
  (now() >> "America/Bogota") as String {
    format: "yyyyMMddHHmmss"
  }
var documentTypeMap = {
	CC: "CedulaDeCiudadania",
	TI: "TarjetaDeIdentidad",
	RC: "RegistroCivilDeNacimiento",
	CE: "CedulaDeExtranjeria",
	TE: "TarjetaDeExtranjeria",
	PAS: "Pasaporte",
	DIE: "DocumentoDeIdentificacionExtranjero",
	NIT: "NIT"
}
var identificationType = documentTypeMap[payload.customer.documentType]
var referenceCode =
    if (sizeOf(refs) > 1)
        "MDM_PAGO_" ++ payload.customer.documentNumber ++ "_" ++ fechaHora
    else
        "MDM_PAGO_" ++ refs[0].reference ++ "_" ++ fechaHora
var userType =
	if (payload.customer.documentType == "NIT") "company"
	else "person"
---
{
	"financialInstitutionCode": payload.paymentMethod.pse.financialInstitutionCode,
	"entityCode": Mule::p('pse-sapi.fields.entityCode'),
	"serviceCode": payload.paymentMethod.pse.serviceCode default Mule::p('pse-sapi.fields.serviceCode'),
	"transactionValue": totalAmount,
	"vatValue": ivaValue default 0,
	"ticketId": payload.invoiceNumber,
	"entityurl": payload.paymentMethod.link.redirectUrl,
	"userType": userType,
	"soliciteDate": now() as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS"},
	"paymentDescription": paymentDescription,
	"referenceNumber1": referenceCode,
	"referenceNumber2": "",
	"referenceNumber3": "",
	"identificationType": identificationType,
	"identificationNumber": payload.customer.documentNumber,
	"fullName": payload.customer.fullName,
	"cellphoneNumber": payload.customer.phoneNumber as Number,
	"address": payload.customer.billingAddress.addressLine1 ++ " " ++ (payload.customer.billingAddress.addressLine2 default ""),
	"email": payload.customer.email,
	"beneficiaryEntityIdentificationType": Mule::p('pse-sapi.fields.beneficiaryEntityIdentificationType'),
	"beneficiaryEntityIdentification": Mule::p('pse-sapi.fields.beneficiaryEntityIdentification'),
	"beneficiaryEntityName": Mule::p('pse-sapi.fields.beneficiaryEntityName'),
	"beneficiaryEntityCIIUCategory": Mule::p('pse-sapi.fields.beneficiaryEntityCIIUCategory'),
	"beneficiaryIdentificationType": Mule::p('pse-sapi.fields.beneficiaryEntityIdentificationType'),
	"beneficiaryIdentification": Mule::p('pse-sapi.fields.beneficiaryEntityIdentification'),
	"indicator4per1000": Mule::p('pse-sapi.fields.indicator4per1000') as Number
}