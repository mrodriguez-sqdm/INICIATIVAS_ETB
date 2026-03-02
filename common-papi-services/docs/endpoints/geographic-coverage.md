# Geographic Coverage

## Descripción

Endpoint para consultar la cobertura de direcciones normalizadas o coordenadas geográficas según el estándar TMF675 v4.

## Endpoint

```
GET /geographicAddressManagement/v1/geographicCoverage
```

## Parámetros

### Query Parameters

| Parámetro | Tipo | Requerido | Descripción | Ejemplo |
|-----------|------|-----------|-------------|---------|
| `address` | string | No | Dirección a consultar | `DG 159B 14A 40 IN 21` |
| `municipality` | string | No | Código de municipio asociado | `11001` |
| `departament` | string | No | Código de departamento asociado | `11` |
| `latitude` | string | No | Latitud asociada a la ubicación geográfica | `4.653928605` |
| `longitude` | string | No | Longitud asociada a la ubicación geográfica | `-74.06588058` |

## Ejemplos de Request

### Consulta por Dirección

```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicCoverage?address=DG+159B+14A+40+IN+21&municipality=11001&departament=11" \
  -H "Accept: application/json"
```

### Consulta por Coordenadas

```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicCoverage?latitude=4.653928605&longitude=-74.06588058" \
  -H "Accept: application/json"
```

### Consulta Combinada

```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicCoverage?address=DG+159B+14A+40+IN+21&municipality=11001&latitude=4.653928605&longitude=-74.06588058" \
  -H "Accept: application/json"
```

## Respuestas

### Respuesta Exitosa (200)

```json
{
  "coverage": {
    "available": true,
    "serviceType": "Fiber",
    "speed": "100 Mbps",
    "technology": "GPON"
  },
  "location": {
    "address": "DG 159B 14A 40 IN 21",
    "municipality": "BOGOTA",
    "coordinates": {
      "latitude": 4.653928605,
      "longitude": -74.06588058
    }
  }
}
```

### Respuesta sin Cobertura (200)

```json
{
  "coverage": {
    "available": false,
    "reason": "No coverage in this area"
  },
  "location": {
    "address": "DG 159B 14A 40 IN 21",
    "municipality": "BOGOTA",
    "coordinates": {
      "latitude": 4.653928605,
      "longitude": -74.06588058
    }
  }
}
```

## Estructura de Respuesta

### Campos de Respuesta

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `coverage` | object | Información de cobertura |
| `coverage.available` | boolean | Indica si hay cobertura disponible |
| `coverage.serviceType` | string | Tipo de servicio disponible |
| `coverage.speed` | string | Velocidad máxima disponible |
| `coverage.technology` | string | Tecnología utilizada |
| `coverage.reason` | string | Razón si no hay cobertura |
| `location` | object | Información de ubicación |
| `location.address` | string | Dirección consultada |
| `location.municipality` | string | Municipio |
| `location.coordinates` | object | Coordenadas geográficas |

## Lógica de Negocio

### Validación de Parámetros

- Al menos uno de los parámetros debe ser proporcionado
- Si se proporcionan coordenadas, se validan los rangos
- Si se proporciona dirección, se valida el formato

### Procesamiento

1. **Validación**: Se validan los parámetros de entrada
2. **Geocodificación**: Si se proporciona dirección, se obtienen coordenadas
3. **Consulta de Cobertura**: Se consulta la base de datos de cobertura
4. **Formateo**: Se estructura la respuesta según TMF675 v4

## Códigos de Error

| Código | Descripción | Causa |
|--------|-------------|-------|
| 400 | Bad Request | Parámetros inválidos o faltantes |
| 404 | Not Found | Ubicación no encontrada |
| 500 | Internal Server Error | Error interno del servidor |

## Estándar TMF675 v4

Este endpoint implementa el estándar TMF675 v4 para consulta de cobertura geográfica, proporcionando:

- **Normalización de Direcciones**: Estandarización según formatos locales
- **Geocodificación**: Conversión de direcciones a coordenadas
- **Consulta de Cobertura**: Verificación de disponibilidad de servicios
- **Respuesta Estructurada**: Formato estándar para información de cobertura

## Notas de Implementación

- Los parámetros son opcionales pero al menos uno debe ser proporcionado
- Las coordenadas deben estar en formato decimal
- La respuesta incluye información tanto de cobertura como de ubicación
- Se mantiene compatibilidad con el estándar TMF675 v4
