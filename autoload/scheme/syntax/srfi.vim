
function! scheme#syntax#srfi#define_srfi()
call scheme#syntax#srfi#srfi_1#define_srfi_1()
call scheme#syntax#srfi#srfi_11#define_srfi_11()
call scheme#syntax#srfi#srfi_13#define_srfi_13()
call scheme#syntax#srfi#srfi_14#define_srfi_14()
call scheme#syntax#srfi#srfi_16#define_srfi_16()
call scheme#syntax#srfi#srfi_19#define_srfi_19()
call scheme#syntax#srfi#srfi_37#define_srfi_37()
call scheme#syntax#srfi#srfi_39#define_srfi_39()
call scheme#syntax#srfi#srfi_48#define_srfi_48()
call scheme#syntax#srfi#srfi_78#define_srfi_78()
call scheme#syntax#srfi#srfi_98#define_srfi_98()

syntax match schemeSrfi oneline  "\v\s*\zssrfi\ze\s*:\d+"
" syntax match schemeSrfiIdentifier oneline  "\vsrfi\s+:\d+\s+\zs\w+\ze" contains=schemeSrfi

highlight default link schemeSrfi Type
highlight default link schemeSrfiIdentifier Identifier
endfunction
