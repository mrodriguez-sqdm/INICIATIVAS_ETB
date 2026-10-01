%dw 2.0

// Pasa cualquier valor a texto. Si viene null, deja "".
fun asText(value) =
    if (value == null)
        ""
    else
        value as String

// Busca un header probando varios nombres (ej. host y Host).
// Si no está el primero, intenta el siguiente.
fun headerOf(headers, names) =
    if (headers == null or isEmpty(names default []))
        null
    else
        headers[names[0]] default (
            if (sizeOf(names) > 1)
                headerOf(headers, names[1 to -1])
            else
                null
        )

// Limpia la IP del cliente. Quita "/" y el puerto si vienen juntos.
fun cleanClientIp(remoteAddress) =
    do {
        var value = asText(remoteAddress)
        ---
        if (value == "")
            ""
        else
            ((value replace "/" with "") splitBy ":")[0]
    }

// Convierte queryParams a un mapa simple { clave: valor }.
// Evita el tipo Java que no se serializa bien a JSON.
fun toPlainMap(params) =
    if (params == null)
        {}
    else
        params mapObject ((value, key) -> {
            (key as String): value
        })

// Arma el contexto al inicio del request (primera vez).
// Guarda hora de inicio, datos HTTP y attributes para el insert.
fun buildAuditContext(attrs, correlationId, appName) =
{
    startTimeMs: now() as Number {unit: "milliseconds"},
    correlationId: asText(
        headerOf(attrs.headers, ["X-CORRELATION-ID", "x-correlation-id"])
            default correlationId
    ),
    apiName: asText(appName),
    httpMethod: asText(attrs.method),
    path: asText(attrs.requestPath),
    processName: trim(asText(attrs.method) ++ " " ++ asText(attrs.requestPath)),
    host: asText(headerOf(attrs.headers, ["host", "Host"])),
    ip: cleanClientIp(
        headerOf(attrs.headers, ["x-forwarded-for", "X-Forwarded-For"])
            default attrs.remoteAddress
    ),
    attributes: {
        method: asText(attrs.method),
        requestPath: asText(attrs.requestPath),
        remoteAddress: attrs.remoteAddress,
        headers: attrs.headers,
        queryParams: toPlainMap(attrs.queryParams)
    }
}

// Deja solo los headers útiles y los queryParams para guardar en ATTRIBUTES.
fun auditAttributesSnapshot(attrs, tipo) =
    {
        tipo: tipo default "REQUEST",
        headers: {
            systemId: headerOf(attrs.headers, ["systemid", "SYSTEMID"]),
            source: headerOf(attrs.headers, ["source", "SOURCE"]),
            contentType: headerOf(attrs.headers, ["content-type", "Content-Type"]),
            accept: headerOf(attrs.headers, ["accept", "Accept"]),
            userAgent: headerOf(attrs.headers, ["user-agent", "User-Agent"])
        },
        queryParams: toPlainMap(attrs.queryParams)
    }

// Junta el contexto guardado con lo actual y arma los campos del POST a audits.
// Si falta algo en el contexto, lo saca de attributes o del correlationId.
fun resolveAudit(auditContext, appName, currentAttributes, currentCorrelationId, tipo) =
    do {
        var ctx = auditContext default {}
        var eventType = tipo default "REQUEST"
        var attrs = ctx.attributes default currentAttributes default {}
        var method = asText(ctx.httpMethod default attrs.method)
        var path = asText(ctx.path default attrs.requestPath)
        var processName = asText(ctx.processName default trim(method ++ " " ++ path))
        ---
        {
            tipo: eventType,
            host: asText(
                ctx.host default headerOf(attrs.headers, ["host", "Host"])
            ),
            correlationId: asText(
                ctx.correlationId
                    default headerOf(attrs.headers, ["X-CORRELATION-ID", "x-correlation-id"])
                    default currentCorrelationId
            ),
            apiName: asText(ctx.apiName default appName),
            processName: eventType ++ " | " ++ processName,
            path: path,
            httpMethod: method,
            ip: cleanClientIp(
                ctx.ip
                    default headerOf(attrs.headers, ["x-forwarded-for", "X-Forwarded-For"])
                    default attrs.remoteAddress
            ),
            attributes: auditAttributesSnapshot(attrs, eventType)
        }
    }
