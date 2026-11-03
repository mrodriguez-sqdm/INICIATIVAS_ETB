%dw 2.0
import * from dw::Runtime
output application/java
---
(vars.pqrUpdateType) match {
	case "activity" -> readUrl('classpath://dwlScripts/patchServicesPqr/setPqrActivityMapping.dwl', 'text/plain')
	case "characteristics" -> readUrl('classpath://dwlScripts/patchServicesPqr/setPqrCharacteristicsMapping.dwl', 'text/plain')
	case "status" -> readUrl('classpath://dwlScripts/patchServicesPqr/setPqrStatusMapping.dwl', 'text/plain')
	case "user" -> readUrl('classpath://dwlScripts/patchServicesPqr/setPqrUserMapping.dwl', 'text/plain')
	else -> fail("Invalid Process Path")
}