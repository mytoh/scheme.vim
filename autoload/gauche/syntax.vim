
let s:save_cpo = &cpo
set cpo&vim

function! gauche#syntax#define_keywords()
    " Gauche extensions
    " multiline comment
    syntax region schemeMultilineComment start=/#|/ end=/|#/ contains=@Spell,schemeMultilineComment,schemeTodo

    " #/xxx/ are the special Gauche identifiers for regexp
    syntax region schemeRegexp start=+\%(\\\)\@<!#/+ skip=+\\[\\/]+ end=+/+

    " anything limited by |'s is identifier
    syntax match schemeOther oneline    "|[^|]\+|"

    " SharpBang
    syntax match	schemeSharpBang	oneline    "#!.*"

    " include (use hoge)
    syntax match	schemeInclude	oneline    "(use .*)"
    syntax match	schemeInclude	oneline    "(require .*)"
    syntax match	schemeInclude	oneline    "(import .*)"

    " misc
    " syntax match	schemeInterpolation	oneline    "#`"
    syntax match	schemeInterpolation	oneline    "#?="

    " char
    "syntax match	schemeChar	oneline    "#\\space"
    "syntax match	schemeError	oneline    !#\\space[^ \t\[\]()";]\+!
    "syntax match	schemeChar	oneline    "#\\newline"
    "syntax match	schemeError	oneline    !#\\newline[^ \t\[\]()";]\+!
    syntax match	schemeChar	oneline    "#\\nl"
    syntax match	schemeError	oneline    !#\\nl[^ \t\[\]()";]\+!
    syntax match	schemeChar	oneline    "#\\lf"
    syntax match	schemeError	oneline    !#\\lf[^ \t\[\]()";]\+!
    syntax match	schemeChar	oneline    "#\\return"
    syntax match	schemeError	oneline    !#\\return[^ \t\[\]()";]\+!
    syntax match	schemeChar	oneline    "#\\cr"
    syntax match	schemeError	oneline    !#\\cr[^ \t\[\]()";]\+!
    syntax match	schemeChar	oneline    "#\\tab"
    syntax match	schemeError	oneline    !#\\tab[^ \t\[\]()";]\+!
    syntax match	schemeChar	oneline    "#\\ht"
    syntax match	schemeError	oneline    !#\\ht[^ \t\[\]()";]\+!
    syntax match	schemeChar	oneline    "#\\page"
    syntax match	schemeError	oneline    !#\\page[^ \t\[\]()";]\+!
    syntax match	schemeChar	oneline    "#\\esc"
    syntax match	schemeError	oneline    !#\\esc[^ \t\[\]()";]\+!
    syntax match	schemeChar	oneline    "#\\escape"
    syntax match	schemeError	oneline    !#\\escape[^ \t\[\]()";]\+!
    syntax match	schemeChar	oneline    "#\\del"
    syntax match	schemeError	oneline    !#\\del[^ \t\[\]()";]\+!
    syntax match	schemeChar	oneline    "#\\delete"
    syntax match	schemeError	oneline    !#\\delete[^ \t\[\]()";]\+!
    syntax match	schemeChar	oneline    "#\\null"
    syntax match	schemeError	oneline    !#\\null[^ \t\[\]()";]\+!

    " scheme keyword argument
    syntax match schemeKey display ":\{1,2}[[:alnum:]?!\-_+*.=<>#$/]\+"


    " #`"gauche special string literal"
    " syntax match	schemeInterpolation	oneline    "#`"
    " syntax region schemeString start='#`"'me=e-2 end='"' contains=schemeUnquote,schemeStringUnquote
    " syntax region schemeStringUnquote matchgroup=schemeFunc start=',|'  end='|'

endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
