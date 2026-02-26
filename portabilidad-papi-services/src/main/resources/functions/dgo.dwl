fun getUrns(products, db, record, isRollback) = 
	if(db == "MDM_CD_ORDEN")
	do{
	  var nros = if(!isRollback) record[0].Servicio_Tramite.Servicios_Auxiliares.Bundle.Numero_Agrupacion default []
				 else record[0].Servicio_Anterior.Servicios_Auxiliares.Bundle.Numero_Agrupacion default []
 
	  var cods = if(!isRollback) flatten(record[0].Servicio_Tramite.Servicios_Auxiliares.Opcionales default []).Codigo_Configuracion default []
				 else flatten(record[0].Servicio_Anterior.Servicios_Auxiliares.Opcionales default []).Codigo_Configuracion default []
 
	  var principales = products filter ((item, index) -> item.tipo_producto == "BUNDLE")
	  var opcionales = products filter ((item, index) -> item.tipo_producto == "OPCIONAL")
 
	  var parametros_bundle = flatten((principales filter ((item, index) -> nros contains item.num_agrupacion)).parametros_bundle default [])
	  var parametros_opcionales = flatten((opcionales filter ((item, index) -> cods contains item.cod_configuracion)).parametros_bundle default [])
 
	  var urnsBundle = ((parametros_bundle default []) filter ((item, index) -> item.parametro == "URN")).valor
	  var urnsOpcionales = ((parametros_opcionales default []) filter ((item, index) -> item.parametro == "URN")).valor
 
	  var urnsDirectos = if(!isRollback) (
		((record[0].Servicio_Tramite.Bundle.Parametros_bundle default []) filter ((item, index) -> item.Parametro == "URN")).Valor
	  ) else (
		((record[0].Servicio_Anterior.Bundle.Parametros_bundle default []) filter ((item, index) -> item.Parametro == "URN")).Valor
	  )
	  ---
	  ((urnsBundle default []) ++ (urnsOpcionales default []) ++ (urnsDirectos default [])) distinctBy $
	}
	else if(db == "MDM_ORDEN")
	do{
	  var nros = if(!isRollback) (record[0].Bundle_orden.bundle_auxiliar[0].id_catalogo default []) map ($ default '-1') as Number
				 else (record[0].Bundle_activo.bundle_auxiliar[0].id_catalogo default []) map ($ default '-1') as Number
 
	  var cods = if(!isRollback) (flatten(record[0].Bundle_orden.bundle_auxiliar[0].opcionales default []).id_opcional default []) map ($ default '-1') as Number
				 else (flatten(record[0].Bundle_activo.bundle_auxiliar[0].opcionales default []).id_opcional default []) map ($ default '-1') as Number
 
	  var principales = products filter ((item, index) -> item.tipo_producto == "BUNDLE")
	  var opcionales = products filter ((item, index) -> item.tipo_producto == "OPCIONAL")
 
	  var parametros_bundle = flatten((principales filter ((item, index) -> nros contains item.num_agrupacion)).parametros_bundle default [])
	  var parametros_opcionales = flatten((opcionales filter ((item, index) -> cods contains item.num_agrupacion)).parametros_bundle default [])
 
	  var urnsBundle = ((parametros_bundle default []) filter ((item, index) -> item.parametro == "URN")).valor
	  var urnsOpcionales = ((parametros_opcionales default []) filter ((item, index) -> item.parametro == "URN")).valor
	  ---
	  ((urnsBundle default []) ++ (urnsOpcionales default [])) distinctBy $
	}
	else if(db == "MDM_CD_SERVICIO")
	do{
	  var nros = record[0].Servicios_Auxiliares.Bundle.Numero_Agrupacion default []
	  var cods = flatten(record[0].Servicios_Auxiliares.Opcionales default []).Codigo_Configuracion default []
 
	  var principales = products filter ((item, index) -> item.tipo_producto == "BUNDLE")
	  var opcionales = products filter ((item, index) -> item.tipo_producto == "OPCIONAL")
 
	  var parametros_bundle = flatten((principales filter ((item, index) -> nros contains item.num_agrupacion)).parametros_bundle default [])
	  var parametros_opcionales = flatten((opcionales filter ((item, index) -> cods contains item.cod_configuracion)).parametros_bundle default [])
 
	  var urnsBundle = ((parametros_bundle default []) filter ((item, index) -> item.parametro == "URN")).valor
	  var urnsOpcionales = ((parametros_opcionales default []) filter ((item, index) -> item.parametro == "URN")).valor
 
	  var urnsDirectos = ((record[0].Bundle.Parametros_bundle default []) filter ((item, index) -> item.Parametro == "URN")).Valor
	  ---
	  ((urnsBundle default []) ++ (urnsOpcionales default []) ++ (urnsDirectos default [])) distinctBy $
	}
	else
	do{
	  var nros = (flatten(record[0].Bundles.bundle_auxiliar default []).id_catalogo default []) map ($ default '-1') as Number
	  var cods = (flatten(flatten(record[0].Bundles.bundle_auxiliar default []).opcionales default []).id_opcional default []) map ($ default '-1') as Number
 
	  var principales = products filter ((item, index) -> item.tipo_producto == "BUNDLE")
	  var opcionales = products filter ((item, index) -> item.tipo_producto == "OPCIONAL")
 
	  var parametros_bundle = flatten((principales filter ((item, index) -> nros contains item.num_agrupacion)).parametros_bundle default [])
	  var parametros_opcionales = flatten((opcionales filter ((item, index) -> cods contains item.num_agrupacion)).parametros_bundle default [])
 
	  var urnsBundle = ((parametros_bundle default []) filter ((item, index) -> item.parametro == "URN")).valor
	  var urnsOpcionales = ((parametros_opcionales default []) filter ((item, index) -> item.parametro == "URN")).valor
	  ---
	  ((urnsBundle default []) ++ (urnsOpcionales default [])) distinctBy $
	}