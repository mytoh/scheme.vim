
function! scheme#syntax#srfi#srfi_13#define_srfi_13()
  syntax keyword schemeFunc string-map string-map!
  syntax keyword schemeFunc string-fold       string-unfold
  syntax keyword schemeFunc string-fold-right string-unfold-right
  syntax keyword schemeFunc string-tabulate string-for-each string-for-each-index
  syntax keyword schemeFunc string-every string-any
  syntax keyword schemeFunc string-hash string-hash-ci
  syntax keyword schemeFunc string-compare string-compare-ci
  syntax keyword schemeFunc string=    string<    string>    string<=    string>=    string<>
  syntax keyword schemeFunc string-ci= string-ci< string-ci> string-ci<= string-ci>= string-ci<>
  syntax keyword schemeFunc string-downcase  string-upcase  string-titlecase
  syntax keyword schemeFunc string-downcase! string-upcase! string-titlecase!
  syntax keyword schemeFunc string-take string-take-right
  syntax keyword schemeFunc string-drop string-drop-right
  syntax keyword schemeFunc string-pad string-pad-right
  syntax keyword schemeFunc string-trim string-trim-right string-trim-both
  syntax keyword schemeFunc string-filter string-delete
  syntax keyword schemeFunc string-index string-index-right
  syntax keyword schemeFunc string-skip  string-skip-right
  syntax keyword schemeFunc string-count
  syntax keyword schemeFunc string-prefix-length string-prefix-length-ci
  syntax keyword schemeFunc string-suffix-length string-suffix-length-ci
  syntax keyword schemeFunc string-prefix? string-prefix-ci?
  syntax keyword schemeFunc string-suffix? string-suffix-ci?
  syntax keyword schemeFunc string-contains string-contains-ci
  syntax keyword schemeFunc string-copy! substring/shared
  syntax keyword schemeFunc string-reverse string-reverse! reverse-list->string
  syntax keyword schemeFunc string-concatenate string-concatenate/shared string-concatenate-reverse
  syntax keyword schemeFunc string-concatenate-reverse/shared
  syntax keyword schemeFunc string-append/shared
  syntax keyword schemeFunc xsubstring string-xcopy!
  syntax keyword schemeFunc string-null?
  syntax keyword schemeFunc string-join
  syntax keyword schemeFunc string-tokenize
  syntax keyword schemeFunc string-replace
  " R5RS extended:
  syntax keyword schemeFunc string->list string-copy string-fill!
  " R5RS re-exports:
  syntax keyword schemeFunc string? make-string string-length string-ref string-set!
  syntax keyword schemeFunc string string-append list->string
endfunction
