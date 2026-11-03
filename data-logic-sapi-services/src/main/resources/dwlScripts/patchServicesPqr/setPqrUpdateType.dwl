%dw 2.0
import * from dw::Runtime
output application/java
---
if(payload.activity?) "activity" 
else if(payload.characteristics?) "characteristics" 
else if(payload.pqrStatus?) "status" 
else if(payload.assignedUser?) "user" 
else fail("The pqr update cannot be performed")