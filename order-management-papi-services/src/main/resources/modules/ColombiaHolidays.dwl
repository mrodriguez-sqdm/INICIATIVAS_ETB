%dw 2.0

// ---------- Utilidades de fecha ----------

fun addDays(d: Date, n: Number): Date =
    if (n >= 0) d + ("P$(n)D" as Period)
    else d - ("P$(abs(n))D" as Period)

fun toDate(y: Number, m: Number, d: Number): Date =
    "$(y)-$(m)-$(d)" as Date {format: "yyyy-M-d"}

// dayOfWeek: 1 = lunes ... 7 = domingo
fun nextMonday(d: Date): Date =
    if (d.dayOfWeek == 1) d else addDays(d, 8 - d.dayOfWeek)

// ---------- Domingo de Pascua (algoritmo de Meeus/Butcher) ----------

fun easterSunday(y: Number): Date = do {
    var a = y mod 19
    var b = floor(y / 100)
    var c = y mod 100
    var d = floor(b / 4)
    var e = b mod 4
    var f = floor((b + 8) / 25)
    var g = floor((b - f + 1) / 3)
    var h = (19 * a + b - d - g + 15) mod 30
    var i = floor(c / 4)
    var k = c mod 4
    var l = (32 + 2 * e + 2 * i - h - k) mod 7
    var m = floor((a + 11 * h + 22 * l) / 451)
    var month = floor((h + l - 7 * m + 114) / 31)
    var day = ((h + l - 7 * m + 114) mod 31) + 1
    ---
    toDate(y, month, day)
}

// ---------- Festivos del año ----------

fun holidaysDetail(y: Number): Array<{date: Date, name: String}> = do {
    var easter = easterSunday(y)
    var fixed = [
        {date: toDate(y, 1, 1),   name: "Año Nuevo"},
        {date: toDate(y, 5, 1),   name: "Día del Trabajo"},
        {date: toDate(y, 7, 20),  name: "Día de la Independencia"},
        {date: toDate(y, 8, 7),   name: "Batalla de Boyacá"},
        {date: toDate(y, 12, 8),  name: "Inmaculada Concepción"},
        {date: toDate(y, 12, 25), name: "Navidad"}
    ]
    var emiliani = [
        {date: nextMonday(toDate(y, 1, 6)),   name: "Reyes Magos"},
        {date: nextMonday(toDate(y, 3, 19)),  name: "San José"},
        {date: nextMonday(toDate(y, 6, 29)),  name: "San Pedro y San Pablo"},
        {date: nextMonday(toDate(y, 8, 15)),  name: "Asunción de la Virgen"},
        {date: nextMonday(toDate(y, 10, 12)), name: "Día de la Raza"},
        {date: nextMonday(toDate(y, 11, 1)),  name: "Todos los Santos"},
        {date: nextMonday(toDate(y, 11, 11)), name: "Independencia de Cartagena"}
    ]
    var easterBased = [
        {date: addDays(easter, -3), name: "Jueves Santo"},
        {date: addDays(easter, -2), name: "Viernes Santo"},
        {date: addDays(easter, 43), name: "Ascensión del Señor"},
        {date: addDays(easter, 64), name: "Corpus Christi"},
        {date: addDays(easter, 71), name: "Sagrado Corazón de Jesús"}
    ]
    ---
    (fixed ++ emiliani ++ easterBased) orderBy $.date
}

fun holidays(y: Number): Array<Date> = holidaysDetail(y).date

// ---------- Validaciones ----------

fun isHoliday(d: Date, adicionales: Array<Date> = []): Boolean =
    (holidays(d.year) contains d) or (adicionales contains d)

fun isWeekend(d: Date): Boolean =
    d.dayOfWeek >= 6

fun isBusinessDay(d: Date, adicionales: Array<Date> = []): Boolean =
    not isWeekend(d) and not isHoliday(d, adicionales)

/**
 * Cuenta los días NO hábiles (sábado, domingo o festivo) en el rango (desde, hasta]:
 * excluye "desde" e incluye "hasta". Si desde >= hasta devuelve 0.
 */
fun countNonBusinessDays(desde: Date, hasta: Date, adicionales: Array<Date> = []): Number =
    if (desde >= hasta) 0
    else do {
        var total = daysBetween(desde, hasta)
        ---
        sizeOf((1 to total) filter (not isBusinessDay(addDays(desde, $), adicionales)))
    }

fun nextBusinessDay(d: Date, adicionales: Array<Date> = []): Date = do {
    var next = addDays(d, 1)
    ---
    if (isBusinessDay(next, adicionales)) next else nextBusinessDay(next, adicionales)
}

fun addBusinessDays(d: Date, n: Number, adicionales: Array<Date> = []): Date =
    if (n <= 0) d else addBusinessDays(nextBusinessDay(d, adicionales), n - 1, adicionales)

/**
 * Convierte "2027-03-15,2027-07-04" en un arreglo de fechas.
 * Ignora valores vacíos o mal formados.
 */
fun parseAdicionales(cadena: String | Null): Array<Date> =
    ((cadena default "") splitBy ",")
        map trim($)
        filter ($ matches /^\d{4}-\d{2}-\d{2}$/)
        map ($ as Date)
