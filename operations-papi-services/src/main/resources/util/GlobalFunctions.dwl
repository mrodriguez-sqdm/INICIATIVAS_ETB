import * from dw::util::Values
import * from dw::core::Strings


fun deconstruct(data, parent) = data map ((item, index) -> 
	if (!isEmpty(item.subProductos)) 
	   	([ subProducto : { idItem : item.idItem} ] ++ deconstruct(item.subProductos, item.idItem))
    else { subProducto : { idItem : item.idItem } } )
    

fun updateItemsFinal(obj: Object, itemsToUpdateByIdItem: Array, fieldToUpdate: String, newValue: Any) =
    obj.items map ( (item, index) ->
    if( itemsToUpdateByIdItem contains (item.idItem) )
    	updateObj(item, fieldToUpdate, newValue)
	else item )
    
fun updateObj(obj: Object, fieldToUpdate: String, newValue: Any) =
 		if (obj."$fieldToUpdate" != null ) (obj update "$fieldToUpdate" with newValue)
		else (obj ++ "$fieldToUpdate": newValue)

fun updateItems(obj: Object, itemsToUpdate: Array) =
    obj.items map ( (item, index) ->
    if( itemsToUpdate contains (item.idItem) )
    (
    	if (item.RESPUESTA_RECIBIDA != null ) (item update "RESPUESTA_RECIBIDA" with 1)
		else (item ++ "RESPUESTA_RECIBIDA": 1)
	 ) else item )

fun updateItemsState(obj: Object, itemsToUpdate: Array,codigoEstado: String,nombreEstado: String) =
    obj.items map ( (item, index) ->
    if( itemsToUpdate contains (item.idItem) )
    (
    	if (item.estadoItem != null ) (item update "estadoItem" with   {
                                                                        "fecha": now(),
                                                                        "codigoEstado": codigoEstado,
                                                                        "nombreEstado": nombreEstado,
                                                                        "observaciones": nombreEstado
                                                                        }
                                                                    )
		else item ++  "estadoItem": {
                        "fecha": now(),
                        "codigoEstado": codigoEstado,
                        "nombreEstado": nombreEstado,
                        "observaciones": nombreEstado
                        }
    )else item )
    
fun updateOrderState(obj: Object,codigoEstado: String,nombreEstado: String) =
 		if (obj.estadoOrden != null ) (obj update "estadoOrden" with  {
                                                                        "fecha": now(),
                                                                        "codigoEstado": codigoEstado,
                                                                        "nombreEstado": nombreEstado,
                                                                        "observaciones": nombreEstado
                                                                     })	
		else obj ++  "estadoOrden": {
                        "fecha": now(),
                        "codigoEstado": codigoEstado,
                        "nombreEstado": nombreEstado,
                        "observaciones": nombreEstado
                        }
	 
fun updateItemsProvisioning(obj: Object, itemsToUpdate: Array) =
    obj.items map ( (item, index) ->
    if( itemsToUpdate contains (item.idItem) )
    (
    	if (item.RESPUESTA_APROVISIONAMIENTO_RECIBIDA != null ) (item update "RESPUESTA_APROVISIONAMIENTO_RECIBIDA" with 1)
		else (item ++ "RESPUESTA_APROVISIONAMIENTO_RECIBIDA": 1)
	 ) else item )
	 
	 
fun getpParam(data: Array,  charcName: String) = (data filter ($.codigo == charcName))[0].valor  default null

// Date formats allowed for this function are '25/10/2022 4:04:50 p. m.' and '18/10/2022'
fun formatDate (fecha) = if ( sizeOf(fecha) == 10 ) (fecha as Date {format: 'dd/MM/yyyy'} as String {format: 'yyyy-MM-dd'}) ++ "T00:00:00.000+0000"
    else do {
        var fechaFormateada = (fecha replace ("p. m.") with ("PM")) replace ("a. m.") with ("AM")
        var fecha = splitBy(fechaFormateada," ")[0] as Date {format: 'dd/MM/yyyy'} as String {format: 'yyyy-MM-dd'}
        var hora = splitBy(fechaFormateada," ")[1] 
        var ampm = splitBy(fechaFormateada," ")[2]
        ---
            if(ampm == "AM")
                fecha ++ "T" ++ (splitBy(hora,":")[0] as Number as String {format:'00'}) ++ ":" ++ splitBy(hora,":")[1] ++ ":" ++  splitBy(hora,":")[2] ++ ".000+0000"
        else fecha ++ "T" ++ (splitBy(hora,":")[0] + 12) ++ ":" ++ splitBy(hora,":")[1] ++ ":" ++  splitBy(hora,":")[2] ++ ".000+0000"
    }
    
// Example of Input string "ATT_SF_AnchoBanda", Output "Ancho Banda"
fun unCamelize (textInput: String) = do{
										var textToSplit = textInput splitBy ("_")
										var text = textToSplit[sizeOf(textToSplit)-1]
										---
										trim(text mapString if( isUpperCase($) )
										                        if ( isLowerCase(text[$$ - 1])  or isBlank(text[$$-1]) )
										                            " " ++ $
										                            else 
										                                if( isUpperCase(text[$$ + 1]) or isBlank(text[$$ + 1])) $
										                                else " " ++ $
										                    else $)
										}
    
fun replaceItemState(item: Object, codigo: String, nombre: String, obs: String) = if(item.estadoItem == null)
            item ++ {
                "estadoItem": {
                    "fecha": now(),
                    "codigoEstado": codigo,
                    "nombreEstado": nombre,
                    "observaciones": obs,
                }
            }
        else
            item update "estadoItem" with {
                "fecha": now(),
                "codigoEstado": codigo,
                "nombreEstado": nombre,
                "observaciones": obs,
            }
            
// This function obtain direct sons, and recursive sons according to an idItem.
fun getParents(arrayItems: Array,idItem: String) = 
    do{
        var out = []
        var sons = (arrayItems filter ($.idRaiz != null and $.idRaiz != $.idItem ))
                    map {
                        idItem: $.idItem,
                        idRaiz: $.idRaiz
                    }
        fun searchParent (Father: Array) = 
                    flatten (Father map ((item, index) -> 
                        do{
                            var son =  sons filter ($.idRaiz == item.idItem)
                            ---
                            if ((son) != []) 
                                out ++ searchParent(son)  ++ [Father[index]]
                            else out ++ [item]   
                        }
                    ))
                    ---
                    searchParent([{"idItem": idItem}])
        }