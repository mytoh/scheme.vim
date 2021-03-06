

let s:save_cpo = &cpo
set cpo&vim

function! scheme#syntax#r7rs#define_r7rs()
  syntax keyword schemeSyntax library export rename for run expand meta only except prefix include include-ci include-library-declarations 
  syntax keyword schemeSyntax letrec-syntax 
  syntax keyword schemeSyntax with-syntax syntax-case
  syntax keyword schemeSyntax define-enumeration

  syntax keyword schemeSyntax define-class define-method define-generic define-accessor class method
  syntax keyword schemeSyntax lambda* define* let-optional let-optional* let-keywords let-keywords* define*-public defmacro* defmacro*-public define-inlinable
  syntax keyword schemeSyntax define-syntax-rule eval-when define-syntax-parameter syntax-parameterize
  syntax keyword schemeSyntax define-once while shift % receive
  syntax keyword schemeSyntax lalr-parser
  syntax keyword schemeSyntax define-module define-public
  syntax keyword schemeSyntax define-wrapped-pointer-type
  syntax keyword schemeSyntax with-mutex with-fluids letpar
  syntax keyword schemeSyntax debug-set! read-set! print-set!

  syntax keyword schemeSyntax and-let* set-record-type-printer! rec define-condition-type parameterize
  syntax keyword schemeSyntax match readline-set!
  syntax keyword schemeSyntax sxml-match sxml-match-let sxml-match-let*


  call scheme#syntax#r7rs#define_r7rs_lispwords()
  call scheme#syntax#r7rs#comment()
  call scheme#syntax#r7rs#module_scheme_base()
  call scheme#syntax#r7rs#module_scheme_cxr()
  call scheme#syntax#r7rs#module_scheme_complex()
  call scheme#syntax#r7rs#module_scheme_inexact()
  call scheme#syntax#r7rs#module_scheme_load()
  call scheme#syntax#r7rs#module_scheme_division()
  call scheme#syntax#r7rs#module_scheme_lazy()
  call scheme#syntax#r7rs#module_scheme_case_lambda()
  call scheme#syntax#r7rs#module_scheme_eval()
  call scheme#syntax#r7rs#module_scheme_repl()
  call scheme#syntax#r7rs#module_scheme_process_context()
  call scheme#syntax#r7rs#module_scheme_file()
  call scheme#syntax#r7rs#module_scheme_read()
  call scheme#syntax#r7rs#module_scheme_write()
  call scheme#syntax#r7rs#module_scheme_char()
  call scheme#syntax#r7rs#module_scheme_time()
  " call scheme#syntax#r7rs#module_scheme_r5rs()
endfunction

function! scheme#syntax#r7rs#module_scheme_base() "{{{
  syntax keyword schemeSyntax import define define-syntax
  syntax keyword schemeSyntax lambda  set!
  syntax keyword schemeSyntax let  let*   letrec   letrec*   letrec-syntax   let*-values   let-syntax   let-values
  syntax keyword schemeSyntax if   cond  case cond-expand
  syntax keyword schemeSyntax syntax-rules
  syntax keyword schemeSyntax when  unless
  syntax keyword schemeSyntax do   define-record-type  guard

  syntax keyword SchemeFunc \
        \ * + - ... / < <= = => > >= _ abs and append apply assoc assq assv begin
        \ binary-port?  boolean?  boolean=?  bytevector bytevector-append
        \ bytevector-copy bytevector-copy! bytevector-length
        \ bytevector-u8-ref bytevector-u8-set!  bytevector?  caar cadr
        \ call-with-current-continuation call-with-port call-with-values
        \ call/cc car cdr cdar cddr ceiling char->integer
        \ char-ready? char<=?  char<?  char=?  char>=?  char>?  char?
        \ close-input-port close-output-port close-port complex?  
        \ cons current-error-port current-input-port current-output-port 
        \ define-values denominator 
        \ dynamic-wind else eof-object?  eq?  equal?  eqv?  error
        \ error-object-irritants error-object-message error-object?  even?
        \ exact exact-integer-sqrt exact-integer?  exact?  expt features
        \ file-error? floor
        \ flush-output-port for-each gcd get-output-bytevector get-output-string
        \ include include-ci inexact inexact?  input-port?
        \ integer->char
        \ integer?  lcm length 
        \ list list->string list->vector list-copy
        \ list-ref list-set!  list-tail list?  make-bytevector make-list
        \ make-parameter make-string make-vector map max member memq memv min
        \ modulo negative?  newline not null?  number->string number?  numerator
        \ odd?  open-input-bytevector open-input-string open-output-bytevector
        \ open-output-string or output-port?  pair?  parameterize peek-char
        \ peek-u8 input-port-open? output-port-open?  port?  positive?
        \ procedure?  quasiquote quote
        \ quotient raise raise-continuable rational?  rationalize read-bytevector
        \ read-bytevector!  read-char read-error? read-line read-string read-u8
        \ real?  remainder
        \ reverse round  set-car!  set-cdr!  square string string->list
        \ string->number string->symbol string->utf8 string->vector string-append
        \ string-copy string-copy! string-fill!  string-for-each string-length
        \ string-map
        \ string-ref string-set!  string<=?  string<?  string=?  string>=?
        \ string>?  string?  substring symbol->string symbol?  symbol=?  syntax-error
        \ textual-port?  truncate u8-ready?  unquote
        \ unquote-splicing utf8->string values vector vector-append
        \ vector->list vector->string
        \ vector-copy vector-copy! vector-fill!  vector-for-each vector-length
        \ vector-map vector-ref vector-set!  vector?  with-exception-handler
        \ write-bytevector write-char write-string write-u8 zero?
        \ truncate-quotient truncate-remainder truncate/
        \ floor-quotient floor-remainder floor/)

endfunction "}}}

function! scheme#syntax#r7rs#module_scheme_complex() "{{{
  syntax keyword schemeFunc angle make-polar real-part imag-part make-rectangular magnitude
endfunction "}}}

function! scheme#syntax#r7rs#module_scheme_cxr() "{{{
  syntax keyword SchemeFunc caaaar
        \  caaadr
        \  caaar
        \  caadar
        \  caaddr
        \  caadr
        \  caar
        \  caar
        \  cadaar
        \  cadadr
        \  cadar
        \  caddar
        \  cadddr
        \  caddr
        \  cadr
        \  cadr
        \  cdaaar
        \  cdaadr
        \  cdaar
        \  cdadar
        \  cdaddr
        \  cdadr
        \  cddaar
        \  cddadr
        \  cddar
        \  cdddar
        \  cddddr
        \  cdddr
        \  cddr
endfunction  "}}}

function! scheme#syntax#r7rs#module_scheme_inexact() "{{{
  syntax keyword schemeFunc acos cos log sqrt asin exp nan?  tan atan finite?  sin
endfunction "}}}

function! scheme#syntax#r7rs#module_scheme_load() "{{{
  syntax keyword schemeFunc load
endfunction "}}}

function! scheme#syntax#r7rs#module_scheme_division() "{{{
  syntax keyword schemeFunc ceiling-quotient ceiling-remainder centered-quotient centered-remainder
  syntax keyword schemeFunc euclidean-quotient euclidean-remainder floor-quotient floor-remainder round-quotient
  syntax keyword schemeFunc round-remainder truncate-quotient truncate-remainder

  syntax keyword schemeFunc ceiling/ centered/ euclidean/ floor/ round/ truncate/
endfunction "}}}

function! scheme#syntax#r7rs#module_scheme_lazy() "{{{
  syntax keyword schemeFunc delay delay-force force make-promise promise?
endfunction "}}}

function! scheme#syntax#r7rs#module_scheme_case_lambda() "{{{
  syntax keyword schemeSyntax case-lambda
endfunction "}}}

function! scheme#syntax#r7rs#module_scheme_eval() "{{{
  syntax keyword schemeSyntax eval environment
endfunction "}}}

function! scheme#syntax#r7rs#module_scheme_repl() "{{{
  syntax keyword schemeSyntax interaction-environment
endfunction "}}}

function! scheme#syntax#r7rs#module_scheme_process_context() "{{{
  syntax keyword schemeFunc command-line exit emergency-exit
  syntax keyword schemeFunc get-environment-variable get-environment-variables
endfunction "}}}

function! scheme#syntax#r7rs#module_scheme_file() "{{{
  syntax keyword schemeFunc with-output-to-file with-input-from-file open-output-file
  syntax keyword schemeFunc open-input-file open-binary-output-file open-binary-input-file
  syntax keyword schemeFunc file-exists?  delete-file call-with-output-file call-with-input-file
endfunction "}}}

function! scheme#syntax#r7rs#module_scheme_read() "{{{
  syntax keyword schemeFunc read
endfunction "}}}

function! scheme#syntax#r7rs#module_scheme_write() "{{{
  syntax keyword schemeFunc display write write-shared write-simple
endfunction "}}}

function! scheme#syntax#r7rs#module_scheme_char() "{{{
  syntax keyword schemeFunc string-upcase string-foldcase string-downcase
  syntax keyword schemeFunc string-ci>?  string-ci>=?  string-ci=?  string-ci<?
  syntax keyword schemeFunc string-ci<=?  digit-value char-whitespace?  char-upper-case?
  syntax keyword schemeFunc char-upcase char-numeric?  char-lower-case?  char-foldcase
  syntax keyword schemeFunc char-downcase char-ci>?  char-ci>=?  char-ci=?
  syntax keyword schemeFunc char-ci<?  char-ci<=?  char-alphabetic?
endfunction "}}}


function! scheme#syntax#r7rs#module_scheme_time() "{{{
  syntax keyword schemeFunc current-jiffy current-second jiffies-per-second
endfunction "}}}

function! scheme#syntax#r7rs#module_scheme_r5rs() "{{{
  syntax keyword schemeFunc \
        \ - * / + < <= = > >= abs acos and angle append apply asin assoc assq
        \ assv atan begin boolean?
        \ caaaar caaadr caadar caaddr
        \ cadaar cadadr caddar cadddr
        \ cdaaar cdaadr cdadar cdaddr
        \ cddaar cddadr cdddar cddddr
        \ caaar caadr cadar caddr
        \ cdaar cdadr cddar cdddr
        \ caar cadr cdar cddr
        \ call-with-current-continuation call-with-input-file call-with-output-file
        \ call-with-values car case cdr ceiling char->integer char-alphabetic?
        \ char-ci<? char-ci<=? char-ci=? char-ci>? char-ci>=? char-downcase
        \ char-lower-case? char-numeric? char-ready? char-upcase
        \ char-upper-case? char-whitespace? char? char<? char<=? char=? char>?
        \ char>=? close-input-port close-output-port complex? cond cons cos
        \ current-input-port current-output-port define define-syntax delay
        \ denominator display do dynamic-wind eof-object? eq? equal? eqv? eval
        \ even? exact->inexact exact? exp expt floor for-each force gcd if
        \ imag-part inexact->exact inexact? input-port? integer->char integer?
        \ interaction-environment lambda lcm length let let-syntax let* letrec
        \ letrec-syntax list list->string list->vector list-ref list-tail list?
        \ load log magnitude make-polar make-rectangular make-string make-vector
        \ map max member memq memv min modulo negative? newline not
        \ null-environment null? number->string number? numerator odd?
        \ open-input-file open-output-file or output-port? pair? peek-char
        \ positive? procedure? quasiquote quote quotient rational? rationalize
        \ read read-char real-part real? remainder reverse round
        \ scheme-report-environment set-car! set-cdr! set! sin sqrt string
        \ string->list string->number string->symbol string-append string-ci<?
        \ string-ci<=? string-ci=? string-ci>? string-ci>=? string-copy
        \ string-fill! string-length string-ref string-set! string? string<?
        \ string<=? string=? string>? string>=? substring symbol->string symbol?
        \ tan truncate values vector vector->list vector-fill! vector-length
        \ vector-ref vector-set! vector? with-input-from-file
        \ with-output-to-file write write-char zero?
endfunction "}}}

function! scheme#syntax#r7rs#comment() "{{{
  " syntax region schemeMultilineComment start="#|" end="|#" contains=@Spell,schemeMultilineComment,schemeTodo
  syntax region schemeMultilineComment start="#|" end="|#" contains=@Spell
endfunction "}}}


function! scheme#syntax#r7rs#define_r7rs_lispwords()
  " set lw=
  set lispwords+=library,define,define-syntax,lambda,set!
  set lispwords+=let,let*,letrec,letrec*,let-values,let*-value
  set lispwords+=if,cond,case
  set lispwords+=let-syntax,letrec-syntax,syntax-rules,when,unless,case-lambda,do
  set lispwords+=define-record-type,guard
  set lispwords+=with-syntax,syntax-case
  set lispwords+=define-enumeration

  set lispwords+=define-class,define-method,define-generic,define-accessor,class,method
  set lispwords+=lambda*,define*,let-optional,let-optional*,let-keywords,let-keywords*,define*-public,defmacro*,defmacro*-public,define-inlinable
  set lispwords+=define-syntax-rule,eval-when,define-syntax-parameter,syntax-parameterize
  set lispwords+=define-once,while,shift,%,receive
  set lispwords+=lalr-parser
  set lispwords+=define-module,define-public
  set lispwords+=define-wrapped-pointer-type
  set lispwords+=with-mutex,with-fluids,letpar
  set lispwords+=debug-set!,read-set!,print-set!

  set lispwords+=cond-expand,and-let*,set-record-type-printer!,rec,define-condition-type,parameterize
  set lispwords+=match,readline-set!
  set lispwords+=sxml-match,sxml-match-let,sxml-match-let*
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
