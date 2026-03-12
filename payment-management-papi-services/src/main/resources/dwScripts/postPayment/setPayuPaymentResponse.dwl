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
    paymentNetworkResponseErrorMessage: payuResponse.data.paymentNetworkResponseErrorMessage,
    traceabilityCode: payuResponse.data.trazabilityCode,
    authorizationCode: payuResponse.data.authorizationCode,
    pendingReason: payuResponse.data.pendingReason,
    errorCode: payuResponse.data.errorCode,
    transactionDate: payuResponse.data.transactionDate,
    transactionTime: payuResponse.data.transactionTime,
    operationDate: payuResponse.data.operationDate,
    referenceQuestionnaire: payuResponse.data.referenceQuestionnaire,
    extraParameters: {
      bankReferencedCode: payuResponse.data.extraParameters.BANK_REFERENCED_CODE
    },
    additionalInfo: {
      paymentNetwork: payuResponse.data.additionalInfo.paymentNetwork,
      rejectionType: payuResponse.data.additionalInfo.rejectionType,
      responseNetworkMessage: payuResponse.data.additionalInfo.responseNetworkMessage,
      travelAgencyAuthorizationCode: payuResponse.data.additionalInfo.travelAgencyAuthorizationCode,
      cardType: payuResponse.data.additionalInfo.cardType,
      transactionType: payuResponse.data.additionalInfo.transactionType
    }
  }
}