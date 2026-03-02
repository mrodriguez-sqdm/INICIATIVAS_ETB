# Geographic Address Complements

## Descripción

Endpoint para obtener información de complementos asociados a una dirección actual, incluyendo patrones de complemento y direcciones relacionadas.

## Endpoint

```
GET /geographicAddressManagement/v1/geographicAddress/{operation}
```

## Parámetros

### Path Parameters

| Parámetro | Tipo | Requerido | Descripción | Valores Válidos |
|-----------|------|-----------|-------------|-----------------|
| `operation` | string | Sí | Operación a realizar | `complements` |

### Query Parameters

| Parámetro | Tipo | Requerido | Descripción | Ejemplo |
|-----------|------|-----------|-------------|---------|
| `address` | string | Sí | Dirección actual a consultar | `AK 45 108A 50` |
| `cityId` | number | Sí | Código de municipio o ciudad | `11001` |
| `limit` | number | No | Límite de complementos consultados | `10` |

## Ejemplos de Request

### Request Básico

```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicAddress/complements?address=AK+45+108A+50&cityId=11001" \
  -H "Accept: application/json"
```

### Request con Límite

```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicAddress/complements?address=AK+45+108A+50&cityId=11001&limit=5" \
  -H "Accept: application/json"
```

## Respuestas

### Respuesta Exitosa (200)

```json
{
  "address": "AK 45 108A 50",
  "city": "BOGOTA",
  "geographicSubAddress": [],
  "characteristic": [
    {
      "name": "complementPatterns",
      "value": ["LC ###", "OF ###"]
    },
    {
      "name": "relatedAddresses",
      "value": [
        "AK 45 108A 50 LC 102",
        "AK 45 108A 50 LC 105",
        "AK 45 108A 50 OF 201",
        "AK 45 108A 50 OF 301",
        "AK 45 108A 50 OF 402"
      ]
    }
  ]
}
```

### Respuesta sin Resultados (200)

```json
{
  "address": "AK 45 108A 50",
  "geographicSubAddress": [],
  "characteristic": [
    {
      "name": "complementPatterns",
      "value": []
    },
    {
      "name": "relatedAddresses",
      "value": []
    }
  ]
}
```

### Respuesta de Error (400)

```json
{
  "status": 400,
  "code": "BAD_REQUEST",
  "message": {
    "message": "Invalid parameters"
  }
}
```

## Estructura de Respuesta

### Campos de Respuesta

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `address` | string | Dirección base consultada |
| `city` | string | Ciudad o municipio de la dirección |
| `geographicSubAddress` | array | Sub-direcciones geográficas (siempre vacío) |
| `characteristic` | array | Características de la dirección |

### Características

#### complementPatterns
- **Descripción**: Patrones de complemento extraídos de las direcciones relacionadas
- **Formato**: Array de strings con números reemplazados por `###`
- **Ejemplo**: `["LC ###", "OF ###"]`

#### relatedAddresses
- **Descripción**: Lista de direcciones relacionadas encontradas
- **Formato**: Array de strings con direcciones completas
- **Ejemplo**: `["AK 45 108A 50 LC 102", "AK 45 108A 50 OF 201"]`

## Lógica de Negocio

### Procesamiento de Datos

1. **Consulta a MongoDB**: Se consulta la base de datos de direcciones geográficas
2. **Extracción de Complementos**: Se extraen los complementos quitando la dirección base
3. **Generación de Patrones**: Se reemplazan números por `###` para crear patrones
4. **Distinct**: Se eliminan patrones duplicados
5. **Formateo**: Se estructura la respuesta según el formato requerido

### Manejo de Casos Especiales

- **Sin Resultados**: Retorna arrays vacíos manteniendo la estructura
- **Límite**: Si se especifica `limit`, se aplica a la consulta MongoDB
- **Parámetros Opcionales**: `limit` es opcional, si no se especifica retorna todos los resultados

## Códigos de Error

| Código | Descripción | Causa |
|--------|-------------|-------|
| 400 | Bad Request | Parámetros inválidos o faltantes |
| 404 | Not Found | Operación no encontrada |
| 500 | Internal Server Error | Error interno del servidor |

## Integración

### Dependencias

- **MongoDB SAPI Services**: Proporciona los datos de direcciones geográficas
- **ETB Common Library**: Librerías comunes de ETB
- **Audits SAPI**: Sistema de auditorías

### Flujo de Datos

```
Request → Handler → Orchestrator → MongoDB Client → Transform → Response
```

## Notas de Implementación

- Los patrones de complemento se generan dinámicamente basándose en los datos reales
- La dirección base se preserva incluso cuando no hay resultados
- Los headers opcionales se manejan condicionalmente para evitar errores de validación
