# Arquitectura Técnica - Common PAPI Services

## Descripción General

Common PAPI Services es una capa de proceso que actúa como intermediario entre los clientes y los servicios de datos, proporcionando una API unificada para operaciones geográficas comunes.

## Arquitectura de Alto Nivel

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Cliente       │    │  Common PAPI     │    │  MongoDB SAPI   │
│   (Frontend)    │◄──►│  Services        │◄──►│  Services       │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                              │
                              ▼
                       ┌──────────────────┐
                       │  ETB Common Lib  │
                       │  Audits SAPI     │
                       └──────────────────┘
```

## Componentes Principales

### 1. Flujo Principal (`common-papi-services.xml`)

**Responsabilidades:**
- Manejo de requests HTTP
- Enrutamiento de APIKit
- Manejo de errores globales
- Logging de auditorías

**Estructura:**
```xml
<flow name="common-papi-services-main">
    <http:listener config-ref="common-papi-services-httpListenerConfig" path="/common/*">
    <apikit:router config-ref="common-papi-services-config" />
    <error-handler>
        <!-- Manejo de errores APIKit -->
    </error-handler>
</flow>
```

### 2. Handler (`geographic-address-operation-handler.xml`)

**Responsabilidades:**
- Validación de parámetros de entrada
- Transformación de datos de entrada
- Preservación de parámetros originales

**Flujo:**
```
Request → Validación → Transformación → Orchestrator
```

### 3. Orchestrator (`geographic-address-operation-orchestrator.xml`)

**Responsabilidades:**
- Lógica de negocio principal
- Coordinación entre componentes
- Transformación de respuestas
- Manejo de casos especiales

**Flujo:**
```
Handler → Client → Transform → Response
```

### 4. Client (`mongo-db-sapi-client.xml`)

**Responsabilidades:**
- Comunicación con servicios externos
- Manejo de headers condicionales
- Manejo de parámetros opcionales

**Características:**
- Headers condicionales (evita envío de valores vacíos)
- Parámetros opcionales (limit)
- Manejo de errores de conectividad

## Flujo de Datos

### 1. Request de Complementos de Dirección

```
1. Cliente → HTTP Request
2. APIKit Router → Valida endpoint
3. Handler → Procesa parámetros
4. Orchestrator → Coordina lógica
5. Client → Consulta MongoDB SAPI
6. Transform → Procesa respuesta
7. Response → Cliente
```

### 2. Procesamiento de Datos

```dataweave
// 1. Extracción de complementos
var complements = relatedAddresses map (address) -> 
  if (address contains baseAddress)
    address replace baseAddress with ""
  else
    address

// 2. Filtrado y distinct
var uniqueComplements = complements 
  filter ($ != "" and $ != null)
  distinctBy $

// 3. Generación de patrones
var complementPatterns = (uniqueComplements 
  map (complement) -> complement replace /[0-9]+/ with "###") distinctBy $
```

## Manejo de Errores

### Tipos de Error

1. **APIKIT:BAD_REQUEST**: Parámetros inválidos
2. **APIKIT:NOT_FOUND**: Endpoint no encontrado
3. **HTTP:CONNECTIVITY**: Error de conectividad
4. **MULE:EXPRESSION**: Error en DataWeave

### Estrategia de Manejo

```xml
<error-handler>
    <on-error-propagate type="APIKIT:BAD_REQUEST">
        <!-- Transform a error response 400 -->
    </on-error-propagate>
    <on-error-propagate type="APIKIT:NOT_FOUND">
        <!-- Transform a error response 404 -->
    </on-error-propagate>
    <on-error-propagate type="HTTP:CONNECTIVITY">
        <!-- Log error y retry o fallback -->
    </on-error-propagate>
</error-handler>
```

## Configuración

### Variables de Entorno

```yaml
# HTTP Configuration
http.private.port: "8091"

# MongoDB SAPI Configuration
mongo-db-sapi.client_secret: "7417c6490e8943FDBCDB907d30e9f2f7"
mongo-db-sapi.client_id: "b8665f3c588a4a709576760a1cc5a582"
mongo-db-sapi.path.geoAddress: "/mongo/v1/address/geoAddress"

# Audits Configuration
audits-sapi.client_secret: "audit_secret"
audits-sapi.client_id: "audit_client_id"
```

### Configuraciones por Ambiente

- **Development**: `development-properties.yaml`
- **QA**: `qa-properties.yaml`
- **Production**: `prod-properties.yaml`

## Patrones de Diseño

### 1. API Gateway Pattern

- **Propósito**: Punto de entrada único para servicios
- **Implementación**: APIKit Router
- **Beneficios**: Centralización, validación, logging

### 2. Orchestrator Pattern

- **Propósito**: Coordinación de servicios
- **Implementación**: Sub-flows especializados
- **Beneficios**: Separación de responsabilidades, reutilización

### 3. Client Pattern

- **Propósito**: Abstracción de servicios externos
- **Implementación**: HTTP Request components
- **Beneficios**: Desacoplamiento, manejo de errores

### 4. Transform Pattern

- **Propósito**: Conversión de formatos de datos
- **Implementación**: DataWeave transformations
- **Beneficios**: Flexibilidad, mantenibilidad

## Consideraciones de Performance

### 1. Caching

- **Headers**: Cache de headers de respuesta
- **Parámetros**: Cache de parámetros validados
- **Transformaciones**: Cache de transformaciones frecuentes

### 2. Optimizaciones

- **Lazy Loading**: Carga bajo demanda de servicios
- **Connection Pooling**: Pool de conexiones HTTP
- **Async Processing**: Procesamiento asíncrono donde sea posible

### 3. Monitoreo

- **Logging**: Logs estructurados para auditoría
- **Metrics**: Métricas de performance y uso
- **Health Checks**: Verificación de salud de servicios

## Seguridad

### 1. Autenticación

- **Client Credentials**: OAuth2 client credentials
- **API Keys**: Validación de API keys
- **Headers**: Validación de headers de seguridad

### 2. Autorización

- **Role-based**: Control de acceso basado en roles
- **Resource-based**: Control de acceso a recursos específicos
- **Rate Limiting**: Limitación de requests por cliente

### 3. Validación

- **Input Validation**: Validación de parámetros de entrada
- **Output Sanitization**: Sanitización de respuestas
- **Error Handling**: Manejo seguro de errores

## Escalabilidad

### 1. Horizontal Scaling

- **Load Balancing**: Distribución de carga
- **Auto Scaling**: Escalamiento automático
- **Service Discovery**: Descubrimiento de servicios

### 2. Vertical Scaling

- **Resource Allocation**: Asignación de recursos
- **Memory Management**: Gestión de memoria
- **CPU Optimization**: Optimización de CPU

### 3. Database Scaling

- **Read Replicas**: Réplicas de lectura
- **Sharding**: Particionamiento de datos
- **Caching**: Cache de consultas frecuentes

## Mantenibilidad

### 1. Código

- **Modularity**: Código modular y reutilizable
- **Documentation**: Documentación completa
- **Testing**: Cobertura de pruebas

### 2. Deployment

- **CI/CD**: Integración y despliegue continuo
- **Versioning**: Control de versiones
- **Rollback**: Capacidad de rollback

### 3. Monitoring

- **Logging**: Logs centralizados
- **Alerting**: Sistema de alertas
- **Dashboards**: Dashboards de monitoreo
