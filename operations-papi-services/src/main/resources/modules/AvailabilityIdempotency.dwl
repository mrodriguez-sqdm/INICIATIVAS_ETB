%dw 2.0

fun normalizeOrderRecord(orderData) =
    if (orderData is Array)
        orderData[0] default {}
    else
        orderData default {}

fun commercialStatusCode(orderRecord) =
    upper((orderRecord.Estado_Orden_Comercial.Codigo default "") as String)

fun commercialStatusDescription(orderRecord) =
    (orderRecord.Estado_Orden_Comercial.Descripcion default "Proceso realizado exitosamente") as String

fun serviceAccountId(orderRecord) =
    orderRecord.Servicio_Tramite.Id_Cuenta_Servicio default null

fun shouldSimulateAvailability(orderRecord) = do {
    var code = commercialStatusCode(orderRecord)
    var numericCode = (code replace /[^0-9]/ with "") as Number default -1
    ---
    (code startsWith "O") and numericCode >= 70 and numericCode <= 90
}

fun simulateSuccessResponse(orderRecord, orderNumber) = {
    status: commercialStatusCode(orderRecord) default "O70",
    description: commercialStatusDescription(orderRecord),
    orderNumber: orderNumber,
    serviceAccountId: serviceAccountId(orderRecord)
}
