# Normalize Address

## Descripción

Endpoint para consultar direcciones vecinas luego de normalizar y georreferenciar una dirección, aplicando manejo de mensajes según el estándar TMF673 v4.

## Endpoint

```
GET /geographicAddressManagement/v1/normalizeAddress
```

## Parámetros

### Query Parameters

| Parámetro | Tipo | Requerido | Descripción | Ejemplo |
|-----------|------|-----------|-------------|---------|
| `address` | string | Sí | Dirección a estandarizar | `Diagonal  159B 14a 40 int 21` |
| `municipalityCod` | string | Sí | Código de municipio asociado a la dirección | `11001` |
| `departamentCod` | string | Sí | Código de departamento asociado a la dirección | `11` |

## Ejemplos de Request

### Request Básico

```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/normalizeAddress?address=Diagonal+159B+14a+40+int+21&municipalityCod=11001&departamentCod=11" \
  -H "Accept: application/json"
```

### Request con Dirección Compleja

```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/normalizeAddress?address=Calle+26+No+59-41+Torre+1+Piso+15&municipalityCod=11001&departamentCod=11" \
  -H "Accept: application/json"
```

## Respuestas

### Respuesta Exitosa (200)

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
  },
  {
    "normalizedAddress": "DG 159B 14A 40",
    "originalAddress": "Diagonal  159B 14a 40 int 21",
    "confidence": 0.87,
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

### Respuesta sin Resultados (200)

```json
[]
```

### Respuesta de Error (400)

```json
{
  "status": 400,
  "code": "BAD_REQUEST",
  "message": {
    "message": "Invalid address format"
  }
}
```

## Estructura de Respuesta

### Campos de Respuesta

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `normalizedAddress` | string | Dirección normalizada según estándares |
| `originalAddress` | string | Dirección original proporcionada |
| `confidence` | number | Nivel de confianza de la normalización (0-1) |
| `coordinates` | object | Coordenadas geográficas |
| `coordinates.latitude` | number | Latitud en formato decimal |
| `coordinates.longitude` | number | Longitud en formato decimal |
| `municipality` | string | Municipio de la dirección |
| `neighborhood` | string | Barrio o localidad |
| `stratum` | string | Estrato socioeconómico |

## Lógica de Negocio

### Proceso de Normalización

1. **Validación**: Se valida el formato de la dirección de entrada
2. **Limpieza**: Se eliminan espacios extra y caracteres especiales
3. **Estandarización**: Se aplican reglas de normalización según estándares locales
4. **Geocodificación**: Se obtienen coordenadas geográficas
5. **Enriquecimiento**: Se agrega información adicional (barrio, estrato, etc.)
6. **Ranking**: Se ordenan por nivel de confianza

### Reglas de Normalización

- **Abreviaciones**: Se expanden abreviaciones comunes (CLL → CALLE, DG → DIAGONAL)
- **Numeración**: Se estandariza formato de números y letras
- **Espaciado**: Se normaliza espaciado entre palabras
- **Caracteres Especiales**: Se manejan caracteres especiales y acentos

## Códigos de Error

| Código | Descripción | Causa |
|--------|-------------|-------|
| 400 | Bad Request | Parámetros inválidos o faltantes |
| 404 | Not Found | Dirección no encontrada |
| 500 | Internal Server Error | Error interno del servidor |

## Estándar TMF673 v4

Este endpoint implementa el estándar TMF673 v4 para normalización de direcciones, proporcionando:

- **Normalización Estándar**: Aplicación de reglas de normalización consistentes
- **Geocodificación**: Conversión de direcciones a coordenadas
- **Enriquecimiento de Datos**: Información adicional sobre la ubicación
- **Múltiples Variantes**: Retorna diferentes versiones normalizadas
- **Nivel de Confianza**: Indica la precisión de cada normalización

## Ejemplos de Normalización

### Entrada
```
"Diagonal  159B 14a 40 int 21"
```

### Salida
```
"DG 159B 14A 40 IN 21"
```

### Cambios Aplicados
- `Diagonal` → `DG` (abreviación estándar)
- `14a` → `14A` (mayúscula para letra)
- `int` → `IN` (abreviación estándar)
- Espaciado normalizado

## Notas de Implementación

- Se retorna un array de direcciones normalizadas ordenadas por confianza
- El nivel de confianza indica qué tan precisa es la normalización
- Se incluye información geográfica y socioeconómica cuando está disponible
- Se mantiene compatibilidad con el estándar TMF673 v4
