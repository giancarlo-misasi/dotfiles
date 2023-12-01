fun overrideSelectBindings() {
    for (i in 33..126) {
        if (i == 92 || i == 124) {
            continue
        }

        val char = i.toChar()
        println("snoremap $char <C-o>\"_c") 
    }

    println("snoremap <bs> <c-o>\"_c")
    println("snoremap <space> <c-o>\"_c<space>")
    println("snoremap \\\\ <c-o>\"_c\\")
    println("snoremap \\| <c-o>\"_c|")
}

fun overrideDeleteAndChangeBindings() {
    val modes = arrayOf("x", "n")
    var lhss = arrayOf("c", "C", "s", "S", "d", "D", "x", "X")
    for (mode in modes) {
        for (lhs in lhss) {
            println("${mode}noremap <silent> $lhs \"_$lhs")
        }
    }
    println("nnoremap <silent> cc \"_S")
    println("nnoremap <silent> dd \"_dd")
}

fun main() {
    overrideSelectBindings()
    overrideDeleteAndChangeBindings()
}
