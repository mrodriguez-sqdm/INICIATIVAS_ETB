%dw 2.0
import dw::Crypto
import modules::common
import update from dw::util::Values
import * from dw::core::Binaries
output application/json
var key = (payload.reference default "")
			++ (payload.amount_in_cents default "")
			++ (payload.currency default "")
			++ Mule::p('secure::wompi.auth.signature')
var integritySignature = lower(toHex(Crypto::hashWith(key as Binary, "SHA-256")))
---
payload update "signature" with integritySignature