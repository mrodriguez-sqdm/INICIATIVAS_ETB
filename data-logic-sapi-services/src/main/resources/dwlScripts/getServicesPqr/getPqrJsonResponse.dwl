%dw 2.0
var pqrResponse = payload.body.Get_PQRResponse.Get_PQRResult.WSResponseBody.PQR_PQR
output application/json  
---
{
  "code": "200",
  "message": "PQR encontrada con éxito",
  "pqr": [
    {
      "id": pqrResponse.Id,
      "rowId": pqrResponse.row_id_pqr,
      "pqrNumber": pqrResponse.numero_pqr,
      "documentType": pqrResponse.tipo_documento,
      "identificationNumber": pqrResponse.numero_identificacion,
      "contactDocumentType": pqrResponse.contacto_tipo_documento,
      "contactDocumentNumber": pqrResponse.contacto_numero_documento,
      "serviceId": pqrResponse.id_servicio,
      "connectionNumber": pqrResponse.numero_conexion,
      "serviceAccount": pqrResponse.cuenta_servicio,
      "billingAccount": pqrResponse.cuenta_facturacion,
      "product": pqrResponse.producto,
      "pqrStatus": pqrResponse.estado_pqr
    }
  ]
}