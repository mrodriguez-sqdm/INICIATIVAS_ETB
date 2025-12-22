%dw 2.0
import * from dw::core::Strings
fun getRequestData(paymentMethod) = do {
  var properties = paymentMethod ++ '-sapi'
  ---
  {
   host: Mule::p(properties ++ '.host') default Mule::p('sapi.host'),
   port: Mule::p(properties ++ '.port') default Mule::p('sapi.port'),
   basePath: Mule::p(properties ++ '.basePath') default Mule::p('sapi.basePath'),
   paths: {
     getBanks: Mule::p(properties ++ '.paths.getBanks') default Mule::p('sapi.paths.getBanks'),
     postPayment: Mule::p(properties ++ '.paths.postPayment') default Mule::p('sapi.paths.postPayment'),
     getPaymentById: Mule::p(properties ++ '.paths.getPaymentById') default Mule::p('sapi.paths.getPaymentById'),
     patchPaymentById: Mule::p(properties ++ '.paths.patchPaymentById') default Mule::p('sapi.paths.patchPaymentById')
    }
  }
 }
 
