
function! scheme#syntax#srfi#srfi_14#define_srfi_14()
  " Predicates & comparison
  syntax keyword schemeFunc char-set? char-set= char-set<= char-set-hash
  " Iterating over character sets
  syntax keyword schemeFunc char-set-cursor char-set-ref char-set-cursor-next end-of-char-set? 
  syntax keyword schemeFunc char-set-fold char-set-unfold char-set-unfold!
  syntax keyword schemeFunc char-set-for-each char-set-map
  " Creating character sets
  syntax keyword schemeFunc char-set-copy char-set
  syntax keyword schemeFunc list->char-set  string->char-set
  syntax keyword schemeFunc list->char-set! string->char-set!
  syntax keyword schemeFunc char-set-filter  ucs-range->char-set 
  syntax keyword schemeFunc char-set-filter! ucs-range->char-set!
  syntax keyword schemeFunc ->char-set
  " Querying character sets
  syntax keyword schemeFunc char-set->list char-set->string
  syntax keyword schemeFunc char-set-size char-set-count char-set-contains?
  syntax keyword schemeFunc char-set-every char-set-any
  " Character-set algebra
  syntax keyword schemeFunc char-set-adjoin  char-set-delete
  syntax keyword schemeFunc char-set-adjoin! char-set-delete!
  syntax keyword schemeFunc char-set-complement  char-set-union  char-set-intersection
  syntax keyword schemeFunc char-set-complement! char-set-union! char-set-intersection!
  syntax keyword schemeFunc char-set-difference  char-set-xor  char-set-diff+intersection
  syntax keyword schemeFunc char-set-difference! char-set-xor! char-set-diff+intersection!
  " Standard character sets
  syntax keyword schemeFunc char-set:lower-case  char-set:upper-case  char-set:title-case
  syntax keyword schemeFunc char-set:letter      char-set:digit       char-set:letter+digit
  syntax keyword schemeFunc char-set:graphic     char-set:printing    char-set:whitespace
  syntax keyword schemeFunc char-set:iso-control char-set:punctuation char-set:symbol
  syntax keyword schemeFunc char-set:hex-digit   char-set:blank       char-set:ascii
  syntax keyword schemeFunc char-set:empty       char-set:full
endfunction
