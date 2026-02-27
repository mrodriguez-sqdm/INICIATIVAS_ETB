fun replaceWithValues(index,inputText,specialCharactersMap)=

if (index==0)
    inputText replace (specialCharactersMap[(index)].key) with (specialCharactersMap[(index)].value)
else
    replaceWithValues((index - 1),(inputText replace (specialCharactersMap[(index)].key) with (specialCharactersMap[(index)].value)),specialCharactersMap)

/**
 * This function adds the received namespace to all elements of the received data,
 * this can be an array or an object
 */    
fun appendNamespace(data, nsSelector: (k: Key) -> Namespace | Null) =
  data match {
	case is Array -> data map appendNamespace($, nsSelector)
    case is Object -> data mapObject do {
		var ns0 = nsSelector($$)
		---
		ns0#"$($$)": appendNamespace($, nsSelector)
	}
    else -> data
}