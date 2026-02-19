%dw 2.0
import * from dw::core::Strings
fun lcamelize(str) = camelize(lower(str as String))
fun camelizeData(data) =
data match {
    case data is Object -> data mapObject ((value, key) ->
        value match  {
            case value is Object -> (lcamelize(key)): camelizeData(value)
            case value is Array -> (lcamelize(key)): value map camelizeData($)
            else -> (lcamelize(key)): value
        }
    )
    case data is Array -> data map ((item) -> camelizeData(item))
    else -> data
}

fun underscoreData(data) =
data match {
    case data is Object -> data mapObject ((value, key) ->
        value match  {
            case value is Object -> (underscore(key)): underscoreData(value)
            case value is Array -> (underscore(key)): value map underscoreData($)
            else -> (underscore(key)): value
        }
    )
    case data is Array -> data map ((item) -> underscoreData(item))
    else -> data
}