# Definición estándar para el uso y almacenamiento en caché

[![Mulesoft](https://img.shields.io/badge/API_Fragment-blue.svg?logo=mulesoft&logoColor=white&label=Mulesoft&style=flat-square)](https://anypoint.mulesoft.com/)

La **Empresa de Telecomunicaciones de Bogotá (ETB)** definió el estándar a nivel general para **usar** y **almacenar** la **respuesta** de una **petición API**
en **caché** a través del atributo **If-None-Match** en la cabecera de la **petición**. El encabezado de solicitud **If-None-Match** hace 
que la solicitud sea **condicional** para los métodos **GET** y **HEAD** dado que el **servidor** devolverá el **recurso solicitado** con un estado **200** 
sólo si no tiene un **ETag** que coincida con los indicados.
