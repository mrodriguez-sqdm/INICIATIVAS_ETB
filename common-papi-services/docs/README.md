# Common PAPI Services

## Descripción

Common PAPI Services es una capa de proceso para la gestión de operaciones comunes, proporcionando servicios unificados para consultas geográficas y normalización de direcciones.

## Características Principales

- **Gestión de Direcciones Geográficas**: Consulta de complementos y direcciones relacionadas
- **Normalización de Direcciones**: Estandarización de direcciones según estándares TMF
- **Cobertura Geográfica**: Consulta de cobertura de direcciones normalizadas
- **Integración con MongoDB**: Acceso a datos de direcciones geográficas

## Endpoints Disponibles

### 1. Geographic Address Management

#### GET `/geographicAddressManagement/v1/geographicAddress/{operation}`

Obtiene información de complementos asociados a una dirección actual.

**Parámetros:**
- `operation` (path): Operación a realizar (`complements`)
- `address` (query): Dirección actual a consultar
- `cityId` (query): Código de municipio o ciudad
- `limit` (query, opcional): Límite de complementos consultados

**Ejemplo de Request:**
```
GET /geographicAddressManagement/v1/geographicAddress/complements?address=AK+45+108A+50&cityId=11001&limit=10
```

**Ejemplo de Response:**
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
        "AK 45 108A 50 OF 201"
      ]
    }
  ]
}
```

#### GET `/geographicAddressManagement/v1/geographicCoverage`

Permite consultar la cobertura de la dirección normalizada o coordenadas enviadas según estándar TMF675 v4.

**Parámetros:**
- `address` (query, opcional): Dirección a consultar
- `municipality` (query, opcional): Código de municipio
- `departament` (query, opcional): Código de departamento
- `latitude` (query, opcional): Latitud asociada
- `longitude` (query, opcional): Longitud asociada

#### GET `/geographicAddressManagement/v1/normalizeAddress`

Permite consultar direcciones vecinas luego de normalizar y georreferenciar, aplicando manejo de mensajes según estándar TMF673 v4.

**Parámetros:**
- `address` (query): Dirección a estandarizar
- `municipalityCod` (query): Código de municipio
- `departamentCod` (query): Código de departamento

## Estructura de Respuesta

### Geographic Address Response

```json
{
  "address": "string",           // Dirección actual
  "city": "string",              // Ciudad o municipio
  "geographicSubAddress": [],    // Sub-direcciones geográficas
  "characteristic": [            // Características de la dirección
    {
      "name": "string",          // Nombre de la característica
      "value": ["string"]        // Valores de la característica
    }
  ]
}
```

### Tipos de Características

- **complementPatterns**: Patrones de complemento (ej: "LC ###", "OF ###")
- **relatedAddresses**: Direcciones relacionadas con la dirección base

## Códigos de Respuesta

- **200**: Operación exitosa
- **400**: Solicitud incorrecta (Bad Request)
- **404**: Recurso no encontrado
- **500**: Error interno del servidor

## Configuración

### Variables de Entorno

- `http.private.port`: Puerto del servidor HTTP
- `mongo-db-sapi.client_secret`: Secreto del cliente para MongoDB
- `mongo-db-sapi.client_id`: ID del cliente para MongoDB
- `mongo-db-sapi.path.geoAddress`: Ruta del endpoint de direcciones geográficas

### Dependencias

- **MongoDB SAPI Services**: Servicio de datos de direcciones geográficas
- **ETB Common Library**: Librería común de ETB
- **Audits SAPI Client**: Cliente de auditorías

## Ejemplos de Uso

### Consulta de Complementos de Dirección

```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicAddress/complements?address=AK+45+108A+50&cityId=11001&limit=5" \
  -H "Accept: application/json"
```

### Respuesta sin Resultados

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

## Arquitectura

### Flujo de Procesamiento

1. **Handler**: Procesa parámetros de entrada y valida operación
2. **Orchestrator**: Coordina la lógica de negocio
3. **Client**: Realiza llamadas a servicios externos (MongoDB SAPI)
4. **Transform**: Convierte datos al formato de respuesta requerido

### Componentes

- **common-papi-services.xml**: Flujo principal de la aplicación
- **geographic-address-operation-handler.xml**: Manejo de parámetros de entrada
- **geographic-address-operation-orchestrator.xml**: Lógica de orquestación
- **mongo-db-sapi-client.xml**: Cliente para servicios de MongoDB

## Estándares

- **TMF673 v4**: Estándar para normalización de direcciones
- **TMF675 v4**: Estándar para cobertura geográfica
- **RAML 1.0**: Especificación de la API

## Soporte

Para soporte técnico o reportar problemas, contactar al equipo de desarrollo de ETB.
