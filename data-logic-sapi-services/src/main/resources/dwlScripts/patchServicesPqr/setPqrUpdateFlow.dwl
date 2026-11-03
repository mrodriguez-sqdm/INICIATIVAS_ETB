%dw 2.0
output application/java
---
(vars.pqrUpdateType) match {
	case "activity" -> "set-pqr-activity-soap-client-sub-flow"
	case "characteristics" -> "set-pqr-characteristics-soap-client-sub-flow"
	case "status" -> "set-pqr-soap-client-sub-flow"
	case "user" -> "set-pqr-soap-client-sub-flow"
	else -> "invalid-update-flow"
}