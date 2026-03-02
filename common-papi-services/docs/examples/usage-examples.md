# Ejemplos de Uso - Common PAPI Services

## Tabla de Contenidos

1. [Consultas de Complementos de Dirección](#consultas-de-complementos-de-dirección)
2. [Consultas de Cobertura Geográfica](#consultas-de-cobertura-geográfica)
3. [Normalización de Direcciones](#normalización-de-direcciones)
4. [Casos de Error](#casos-de-error)
5. [Integración con Postman](#integración-con-postman)

## Consultas de Complementos de Dirección

### Ejemplo 1: Consulta Básica

**Request:**
```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicAddress/complements?address=AK+45+108A+50&cityId=11001" \
  -H "Accept: application/json" \
  -H "Content-Type: application/json"
```

**Response:**
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

### Ejemplo 2: Consulta con Límite

**Request:**
```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicAddress/complements?address=CL+94A+67A+74&cityId=11001&limit=3" \
  -H "Accept: application/json"
```

**Response:**
```json
{
  "address": "CL 94A 67A 74",
  "city": "BOGOTA",
  "geographicSubAddress": [],
  "characteristic": [
    {
      "name": "complementPatterns",
      "value": ["LC ###"]
    },
    {
      "name": "relatedAddresses",
      "value": [
        "CL 94A 67A 74 LC 18",
        "CL 94A 67A 74 LC 20",
        "CL 94A 67A 74 LC 22"
      ]
    }
  ]
}
```

### Ejemplo 3: Sin Resultados

**Request:**
```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicAddress/complements?address=DIRECCION+INEXISTENTE&cityId=11001" \
  -H "Accept: application/json"
```

**Response:**
```json
{
  "address": "DIRECCION INEXISTENTE",
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

## Consultas de Cobertura Geográfica

### Ejemplo 1: Consulta por Dirección

**Request:**
```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicCoverage?address=DG+159B+14A+40+IN+21&municipality=11001&departament=11" \
  -H "Accept: application/json"
```

**Response:**
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

### Ejemplo 2: Consulta por Coordenadas

**Request:**
```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicCoverage?latitude=4.653928605&longitude=-74.06588058" \
  -H "Accept: application/json"
```

**Response:**
```json
{
  "coverage": {
    "available": false,
    "reason": "No coverage in this area"
  },
  "location": {
    "coordinates": {
      "latitude": 4.653928605,
      "longitude": -74.06588058
    }
  }
}
```

## Normalización de Direcciones

### Ejemplo 1: Normalización Básica

**Request:**
```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/normalizeAddress?address=Diagonal+159B+14a+40+int+21&municipalityCod=11001&departamentCod=11" \
  -H "Accept: application/json"
```

**Response:**
```json
[
  {
    "normalizedAddress": "DG 159B 14A 40 IN 21",
    "originalAddress": "Diagonal  159B 14a 40 int 21",
    "confidence": 0.95,
    "coordinates": {
      "latitude": 4.653928605,
      "longitude": -74.06588058
    },
    "municipality": "BOGOTA",
    "neighborhood": "CHAPINERO",
    "stratum": "6"
  }
]
```

### Ejemplo 2: Múltiples Variantes

**Request:**
```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/normalizeAddress?address=Calle+26+No+59-41+Torre+1+Piso+15&municipalityCod=11001&departamentCod=11" \
  -H "Accept: application/json"
```

**Response:**
```json
[
  {
    "normalizedAddress": "CL 26 59-41 TORRE 1 PISO 15",
    "originalAddress": "Calle 26 No 59-41 Torre 1 Piso 15",
    "confidence": 0.98,
    "coordinates": {
      "latitude": 4.6097100,
      "longitude": -74.0817500
    },
    "municipality": "BOGOTA",
    "neighborhood": "CENTRO",
    "stratum": "3"
  },
  {
    "normalizedAddress": "CL 26 59-41 TORRE 1",
    "originalAddress": "Calle 26 No 59-41 Torre 1 Piso 15",
    "confidence": 0.85,
    "coordinates": {
      "latitude": 4.6097100,
      "longitude": -74.0817500
    },
    "municipality": "BOGOTA",
    "neighborhood": "CENTRO",
    "stratum": "3"
  }
]
```

## Casos de Error

### Error 400: Parámetros Faltantes

**Request:**
```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicAddress/complements?cityId=11001" \
  -H "Accept: application/json"
```

**Response:**
```json
{
  "status": 400,
  "code": "BAD_REQUEST",
  "message": {
    "message": "Missing required parameter: address"
  }
}
```

### Error 400: Operación Inválida

**Request:**
```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicAddress/invalid?address=AK+45+108A+50&cityId=11001" \
  -H "Accept: application/json"
```

**Response:**
```json
{
  "code": 1,
  "description": "invalid operation"
}
```

### Error 500: Error Interno

**Request:**
```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicAddress/complements?address=AK+45+108A+50&cityId=11001" \
  -H "Accept: application/json"
```

**Response:**
```json
{
  "status": 500,
  "code": "INTERNAL_ERROR",
  "message": {
    "message": "Internal server error"
  }
}
```

## Integración con Postman

### Colección de Postman

```json
{
  "info": {
    "name": "Common PAPI Services",
    "description": "API para gestión de operaciones comunes geográficas",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "item": [
    {
      "name": "Geographic Address Complements",
      "request": {
        "method": "GET",
        "header": [
          {
            "key": "Accept",
            "value": "application/json"
          }
        ],
        "url": {
          "raw": "{{baseUrl}}/geographicAddressManagement/v1/geographicAddress/complements?address={{address}}&cityId={{cityId}}&limit={{limit}}",
          "host": ["{{baseUrl}}"],
          "path": ["geographicAddressManagement", "v1", "geographicAddress", "complements"],
          "query": [
            {
              "key": "address",
              "value": "{{address}}"
            },
            {
              "key": "cityId",
              "value": "{{cityId}}"
            },
            {
              "key": "limit",
              "value": "{{limit}}"
            }
          ]
        }
      }
    }
  ],
  "variable": [
    {
      "key": "baseUrl",
      "value": "http://localhost:8091/common"
    },
    {
      "key": "address",
      "value": "AK 45 108A 50"
    },
    {
      "key": "cityId",
      "value": "11001"
    },
    {
      "key": "limit",
      "value": "10"
    }
  ]
}
```

### Variables de Entorno

```json
{
  "id": "common-papi-env",
  "name": "Common PAPI Environment",
  "values": [
    {
      "key": "baseUrl",
      "value": "http://localhost:8091/common",
      "enabled": true
    },
    {
      "key": "devUrl",
      "value": "https://common-papi-services-dev.us-e2.cloudhub.io",
      "enabled": false
    },
    {
      "key": "qaUrl",
      "value": "https://common-papi-services-qa.us-e2.cloudhub.io",
      "enabled": false
    },
    {
      "key": "prodUrl",
      "value": "https://common-papi-services-prod.us-e2.cloudhub.io",
      "enabled": false
    }
  ]
}
```

## Casos de Prueba

### Casos de Prueba Positivos

1. **Consulta con resultados**: Dirección existente con complementos
2. **Consulta sin resultados**: Dirección inexistente
3. **Consulta con límite**: Dirección con muchos complementos
4. **Normalización exitosa**: Dirección con múltiples variantes
5. **Cobertura disponible**: Área con servicios disponibles

### Casos de Prueba Negativos

1. **Parámetros faltantes**: Request sin parámetros requeridos
2. **Parámetros inválidos**: Valores fuera de rango o formato incorrecto
3. **Operación inválida**: Endpoint con operación no soportada
4. **Servicio no disponible**: Error de conectividad con servicios externos

### Casos de Prueba de Límites

1. **Límite máximo**: Consulta con límite muy alto
2. **Límite cero**: Consulta con límite 0
3. **Sin límite**: Consulta sin especificar límite
4. **Direcciones largas**: Direcciones con muchos caracteres
