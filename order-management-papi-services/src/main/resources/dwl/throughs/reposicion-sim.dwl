%dw 2.0
output application/json

import modules::GlobalFunctions as global

fun resultado(id: String, condicionValida: Boolean, mensajeValido: String, mensajeInvalido: String) = {
	evaluateId: id,
	isValid: condicionValida,
	detail: if (condicionValida) mensajeValido else mensajeInvalido
}

fun esTrue(valor: Any) =
	(valor default "") as String {caseSensitive: false} == "true"


---
[	
	// 1. Nombre_Cliente poblado
	resultado("Campo_Nombre_Cliente",
		global::poblado(record.Nombre_Cliente),
		"Nombre_Cliente poblado",
		"Nombre_Cliente no poblado"),

	// 2. ATDP existe y HABEAS_DATA == true
	resultado("Campo_ATDP_HabeasData",
		(record.ATDP != null) and esTrue(record.ATDP.HABEAS_DATA),
		"ATDP presente con HABEAS_DATA en true",
		"ATDP ausente o HABEAS_DATA distinto de true"),
		
    // 3. EnvioComunicaciones: Medio y Dato poblados
	resultado("Campo_EnvioComunicaciones",
		(record.EnvioComunicaciones != null)
			and global::poblado(record.EnvioComunicaciones.MedioComunicacion)
			or global::poblado(record.EnvioComunicaciones.DatoComunicacion1),
		"EnvioComunicaciones con Medio y Dato poblados",
		"EnvioComunicaciones ausente o incompleto"),

	// 4. Correo_Electronico O Telefono_Movil poblado
	resultado("Campo_ContactoDirecto",
		global::poblado(record.Correo_Electronico) or global::poblado(record.Telefono_Movil),
		"Correo o Telefono_Movil poblado",
		"Correo y Telefono_Movil vacios"),

	// 5. Datos demograficos: Pais, Ciudad, Departamento poblados
	resultado("Campo_DatosDemograficos",
		global::poblado(record.Pais) and global::poblado(record.Ciudad) and global::poblado(record.Departamento),
		"Pais, Ciudad y Departamento poblados",
		"Falta al menos un dato demografico (Pais/Ciudad/Departamento)")
]