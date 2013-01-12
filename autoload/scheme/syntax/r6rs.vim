
let s:save_cpo = &cpo
set cpo&vim

function! scheme#syntax#r6rs#define_r6rs()
  syn keyword schemeSyntax library export import rename for run expand meta only except prefix

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
