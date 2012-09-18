
let s:save_cpo = &cpo
set cpo&vim

function! gauche#syntax#define_keywords()
    " Gauche extensions
    " multiline comment
    syntax region schemeMultilineComment start=/#|/ end=/|#/ contains=@Spell,schemeMultilineComment,schemeTodo

    " #/xxx/ are the special Gauche identifiers for regexp
    syn region schemeRegexp start=+\%(\\\)\@<!#/+ skip=+\\[\\/]+ end=+/+

    " anything limited by |'s is identifier
    syn match schemeOther oneline    "|[^|]\+|"

    " SharpBang
    syn match	schemeSharpBang	oneline    "#!.*"

    " include (use hoge)
    syn match	schemeInclude	oneline    "(use .*)"
    syn match	schemeInclude	oneline    "(require .*)"
    syn match	schemeInclude	oneline    "(import .*)"

    " misc
    syn match	schemeInterpolation	oneline    "#`"
    syn match	schemeInterpolation	oneline    "#?="

    " char
    "syn match	schemeChar	oneline    "#\\space"
    "syn match	schemeError	oneline    !#\\space[^ \t\[\]()";]\+!
    "syn match	schemeChar	oneline    "#\\newline"
    "syn match	schemeError	oneline    !#\\newline[^ \t\[\]()";]\+!
    syn match	schemeChar	oneline    "#\\nl"
    syn match	schemeError	oneline    !#\\nl[^ \t\[\]()";]\+!
    syn match	schemeChar	oneline    "#\\lf"
    syn match	schemeError	oneline    !#\\lf[^ \t\[\]()";]\+!
    syn match	schemeChar	oneline    "#\\return"
    syn match	schemeError	oneline    !#\\return[^ \t\[\]()";]\+!
    syn match	schemeChar	oneline    "#\\cr"
    syn match	schemeError	oneline    !#\\cr[^ \t\[\]()";]\+!
    syn match	schemeChar	oneline    "#\\tab"
    syn match	schemeError	oneline    !#\\tab[^ \t\[\]()";]\+!
    syn match	schemeChar	oneline    "#\\ht"
    syn match	schemeError	oneline    !#\\ht[^ \t\[\]()";]\+!
    syn match	schemeChar	oneline    "#\\page"
    syn match	schemeError	oneline    !#\\page[^ \t\[\]()";]\+!
    syn match	schemeChar	oneline    "#\\esc"
    syn match	schemeError	oneline    !#\\esc[^ \t\[\]()";]\+!
    syn match	schemeChar	oneline    "#\\escape"
    syn match	schemeError	oneline    !#\\escape[^ \t\[\]()";]\+!
    syn match	schemeChar	oneline    "#\\del"
    syn match	schemeError	oneline    !#\\del[^ \t\[\]()";]\+!
    syn match	schemeChar	oneline    "#\\delete"
    syn match	schemeError	oneline    !#\\delete[^ \t\[\]()";]\+!
    syn match	schemeChar	oneline    "#\\null"
    syn match	schemeError	oneline    !#\\null[^ \t\[\]()";]\+!
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
