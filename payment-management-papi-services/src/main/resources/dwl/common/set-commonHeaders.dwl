%dw 2.0
output application/java
var paymentMethod = attributes.uriParams.paymentMethod
---
{
    "client_id" : Mule::p(paymentMethod ++ '.client_id') default Mule::p('sapi.client_id'),
    "client_secret" : Mule::p(paymentMethod ++ '.client_secret') default Mule::p('sapi.client_secret'),
    "name" : if(!isEmpty(attributes.headers.'name' )) attributes.headers.'systemId' else 'pasarelaPagos',
    "X-CORRELATION-ID": correlationId,
    "systemId": if(!isEmpty(attributes.headers.'systemId' )) attributes.headers.'systemId' else 'TRANSACCCIONES_OM',
    "source" : attributes.headers.'source'
}