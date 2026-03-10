%dw 2.0
output application/json
var payuResponse = vars.sapiResponse
---
{
  code: payuResponse.code,
  message: "Services retrieved successfully",
  result: {
    gateway: "PAYU",
    transactionId: payuResponse.data.transactionId,
    orderId: (payuResponse.data.orderId as String),
    status: payuResponse.data.state,
    responseCode: payuResponse.data.responseCode,
    responseMessage: payuResponse.data.responseMessage,
    paymentNetworkResponseCode: payuResponse.data.paymentNetworkResponseCode,
    traceabilityCode: payuResponse.data.trazabilityCode,
    authorizationCode: payuResponse.data.authorizationCode,
    operationDate: payuResponse.data.operationDate,
    extraParameters: {
      bankReferencedCode: payuResponse.data.extraParameters.BANK_REFERENCED_CODE
    },
    additionalInfo: {
      paymentNetwork: payuResponse.data.additionalInfo.paymentNetwork,
      rejectionType: payuResponse.data.additionalInfo.rejectionType,
      cardType: payuResponse.data.additionalInfo.cardType,
      transactionType: payuResponse.data.additionalInfo.transactionType
    }
  }
}