# Common PAPI Services - Documentación

## 📚 Índice de Documentación

### 🏠 [Documentación Principal](README.md)
- Descripción general de la API
- Características principales
- Endpoints disponibles
- Estructura de respuesta
- Códigos de respuesta
- Configuración y dependencias

### 🔗 Endpoints

#### [Geographic Address Complements](endpoints/geographic-address-complements.md)
- Consulta de complementos de direcciones
- Parámetros y ejemplos
- Lógica de negocio
- Manejo de casos especiales

#### [Geographic Coverage](endpoints/geographic-coverage.md)
- Consulta de cobertura geográfica
- Estándar TMF675 v4
- Consultas por dirección y coordenadas

#### [Normalize Address](endpoints/normalize-address.md)
- Normalización de direcciones
- Estándar TMF673 v4
- Múltiples variantes de normalización

### 📖 Ejemplos y Casos de Uso

#### [Ejemplos de Uso](examples/usage-examples.md)
- Ejemplos de requests y responses
- Casos de error
- Integración con Postman
- Casos de prueba

### 🏗️ Arquitectura

#### [Arquitectura Técnica](architecture/technical-architecture.md)
- Componentes principales
- Flujo de datos
- Patrones de diseño
- Consideraciones de performance
- Seguridad y escalabilidad

## 🚀 Inicio Rápido

### 1. Consulta Básica de Complementos
```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicAddress/complements?address=AK+45+108A+50&cityId=11001" \
  -H "Accept: application/json"
```

### 2. Consulta con Límite
```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/geographicAddress/complements?address=AK+45+108A+50&cityId=11001&limit=5" \
  -H "Accept: application/json"
```

### 3. Normalización de Dirección
```bash
curl -X GET "http://localhost:8091/common/geographicAddressManagement/v1/normalizeAddress?address=Diagonal+159B+14a+40+int+21&municipalityCod=11001&departamentCod=11" \
  -H "Accept: application/json"
```

## 📋 Estructura de Archivos

```
docs/
├── README.md                           # Documentación principal
├── INDEX.md                           # Este archivo
├── endpoints/
│   ├── geographic-address-complements.md
│   ├── geographic-coverage.md
│   └── normalize-address.md
├── examples/
│   └── usage-examples.md
└── architecture/
    └── technical-architecture.md
```

## 🔧 Configuración

### Variables de Entorno Requeridas
- `http.private.port`: Puerto del servidor
- `mongo-db-sapi.client_secret`: Secreto del cliente MongoDB
- `mongo-db-sapi.client_id`: ID del cliente MongoDB
- `mongo-db-sapi.path.geoAddress`: Ruta del endpoint MongoDB

### Dependencias
- MongoDB SAPI Services
- ETB Common Library
- Audits SAPI Client

## 📊 Métricas y Monitoreo

### Logs Estructurados
- Requests y responses
- Errores y excepciones
- Métricas de performance
- Auditorías de acceso

### Health Checks
- Estado de servicios externos
- Disponibilidad de endpoints
- Métricas de conectividad

## 🛡️ Seguridad

### Autenticación
- OAuth2 Client Credentials
- API Keys
- Headers de seguridad

### Validación
- Parámetros de entrada
- Sanitización de respuestas
- Manejo seguro de errores

## 📈 Performance

### Optimizaciones
- Connection pooling
- Caching de respuestas
- Procesamiento asíncrono
- Lazy loading

### Escalabilidad
- Load balancing
- Auto scaling
- Service discovery

## 🆘 Soporte

### Contacto
- Equipo de desarrollo ETB
- Documentación técnica
- Casos de uso y ejemplos

### Recursos Adicionales
- [RAML Specification](../src/main/resources/api/common-papi-services.raml)
- [Paths Configuration](../src/main/resources/paths.json)
- [Properties Files](../src/main/resources/)

---

**Última actualización**: 2025-09-16  
**Versión**: 1.0.0  
**Mantenido por**: Equipo de desarrollo ETB
