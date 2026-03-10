%dw 2.0
output application/xml
ns soap http://schemas.xmlsoap.org/soap/envelope/
---
soap#Envelope: {
	soap#Body: {
		soap#Fault: {
			faultcode: "soap:Router",
			faultstring: "Router Error: " ++ error.description
		}
	}
}