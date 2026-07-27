%dw 2.0
output application/json
---
{
  "language": p('payu.language'),
  "test": p('payu.test'),
  "command":  p('payu.getPing.command'),
  "merchant": {
    "apiLogin": p('secure::payu.apiLogin'),
    "apiKey": p('secure::payu.apiKey')
  }
}
