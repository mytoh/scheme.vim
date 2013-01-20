" github.com/ayamada/copy-of-svn.tir.jp/nekoie/goshtags/make_scheme_vim.scm
"
" Vim syntax file
" Language: Scheme (R5RS)
" Last Change:  2007 Jun 16
" Maintainer: Sergey Khorev <sergey.khorev@gmail.com>
" Original author:  Dirk van Deun <dirk@igwe.vub.ac.be>

" Modifier: yamada <yamada-remove-this-part@tir.jp>
"   ( http://e.tir.jp/wiliki?vim:scheme.vim )
" $Id$

" This script incorrectly recognizes some junk input as numerals:
" parsing the complete system of Scheme numerals using the pattern
" language is practically impossible: I did a lax approximation.
 
" MzScheme extensions can be activated with setting is_mzscheme variable
" Gauche extensions can be activated with setting is_gauche variable

" Initializing:

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syntax case ignore


" Fascist highlighting: everything that doesn't fit the rules is an error...

syntax match schemeError oneline    ![^ \t()\[\]";]*!
syntax match schemeError oneline    ")"

" Quoted and backquoted stuff

syntax region schemeQuoted matchgroup=Delimiter start="['`]" end=![ \t()\[\]";]!me=e-1 contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syntax region schemeQuoted matchgroup=Delimiter start="['`](" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syntax region schemeQuoted matchgroup=Delimiter start="['`]#(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syntax region schemeStrucRestricted matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syntax region schemeStrucRestricted matchgroup=Delimiter start="#(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

" Popular Scheme extension:
" using [] as well as ()
syntax region schemeQuoted matchgroup=Delimiter start="['`]\[" matchgroup=Delimiter end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syntax region schemeQuoted matchgroup=Delimiter start="['`]#\[" matchgroup=Delimiter end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syntax region schemeStrucRestricted matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syntax region schemeStrucRestricted matchgroup=Delimiter start="#\[" matchgroup=Delimiter end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syntax region schemeUnquote matchgroup=Delimiter start="," end=![ \t\[\]()";]!me=e-1 contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syntax region schemeUnquote matchgroup=Delimiter start=",@" end=![ \t\[\]()";]!me=e-1 contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syntax region schemeUnquote matchgroup=Delimiter start=",(" end=")" contains=ALL
syntax region schemeUnquote matchgroup=Delimiter start=",@(" end=")" contains=ALL

syntax region schemeUnquote matchgroup=Delimiter start=",#(" end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syntax region schemeUnquote matchgroup=Delimiter start=",@#(" end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syntax region schemeUnquote matchgroup=Delimiter start=",\[" end="\]" contains=ALL
syntax region schemeUnquote matchgroup=Delimiter start=",@\[" end="\]" contains=ALL

syntax region schemeUnquote matchgroup=Delimiter start=",#\[" end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syntax region schemeUnquote matchgroup=Delimiter start=",@#\[" end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

" R5RS Scheme Functions and Syntax:

if version < 600
  set iskeyword=33,35-39,42,43,45-58,60-90,94,95,97-122,126,_
else
  setlocal iskeyword=33,35-39,42,43,45-58,60-90,94,95,97-122,_,126,192-255
endif

if !exists("scheme_is_r7rs") && !exists("b:scheme_is_r7rs")
" set lispwords=
set lispwords+=lambda,and,or,if,cond,case,define,let,let*,letrec
set lispwords+=begin,do,delay,set!,else,=>
set lispwords+=quote,quasiquote,unquote,unquote-splicing
set lispwords+=define-syntax,let-syntax,letrec-syntax,syntax-rules
syntax keyword schemeSyntax lambda and or if cond case define let let* letrec
syntax keyword schemeSyntax begin do delay set! else =>
syntax keyword schemeSyntax quote quasiquote unquote unquote-splicing
syntax keyword schemeSyntax define-syntax let-syntax letrec-syntax syntax-rules
" R6RS
syntax keyword schemeSyntax define-record-type fields protocol

syntax keyword schemeFunc not boolean? eq? eqv? equal? pair? cons car cdr set-car!
syntax keyword schemeFunc set-cdr! caar cadr cdar cddr caaar caadr cadar caddr
syntax keyword schemeFunc cdaar cdadr cddar cdddr caaaar caaadr caadar caaddr
syntax keyword schemeFunc cadaar cadadr caddar cadddr cdaaar cdaadr cdadar cdaddr
syntax keyword schemeFunc cddaar cddadr cdddar cddddr null? list? list length
syntax keyword schemeFunc append reverse list-ref memq memv member assq assv assoc
syntax keyword schemeFunc symbol? symbol->string string->symbol number? complex?
syntax keyword schemeFunc real? rational? integer? exact? inexact? = < > <= >=
syntax keyword schemeFunc zero? positive? negative? odd? even? max min + * - / abs
syntax keyword schemeFunc quotient remainder modulo gcd lcm numerator denominator
syntax keyword schemeFunc floor ceiling truncate round rationalize exp log sin cos
syntax keyword schemeFunc tan asin acos atan sqrt expt make-rectangular make-polar
syntax keyword schemeFunc real-part imag-part magnitude angle exact->inexact
syntax keyword schemeFunc inexact->exact number->string string->number char=?
syntax keyword schemeFunc char-ci=? char<? char-ci<? char>? char-ci>? char<=?
syntax keyword schemeFunc char-ci<=? char>=? char-ci>=? char-alphabetic? char?
syntax keyword schemeFunc char-numeric? char-whitespace? char-upper-case?
syntax keyword schemeFunc char-lower-case?
syntax keyword schemeFunc char->integer integer->char char-upcase char-downcase
syntax keyword schemeFunc string? make-string string string-length string-ref
syntax keyword schemeFunc string-set! string=? string-ci=? string<? string-ci<?
syntax keyword schemeFunc string>? string-ci>? string<=? string-ci<=? string>=?
syntax keyword schemeFunc string-ci>=? substring string-append vector? make-vector
syntax keyword schemeFunc vector vector-length vector-ref vector-set! procedure?
syntax keyword schemeFunc apply map for-each call-with-current-continuation
syntax keyword schemeFunc call-with-input-file call-with-output-file input-port?
syntax keyword schemeFunc output-port? current-input-port current-output-port
syntax keyword schemeFunc open-input-file open-output-file close-input-port
syntax keyword schemeFunc close-output-port eof-object? read read-char peek-char
syntax keyword schemeFunc write display newline write-char call/cc
syntax keyword schemeFunc list-tail string->list list->string string-copy
syntax keyword schemeFunc string-fill! vector->list list->vector vector-fill!
syntax keyword schemeFunc force with-input-from-file with-output-to-file
syntax keyword schemeFunc char-ready? load transcript-on transcript-off eval
syntax keyword schemeFunc dynamic-wind port? values call-with-values
syntax keyword schemeFunc scheme-report-environment null-environment
syntax keyword schemeFunc interaction-environment
" R6RS
syntax keyword schemeFunc make-eq-hashtable make-eqv-hashtable make-hashtable
syntax keyword schemeFunc hashtable? hashtable-size hashtable-ref hashtable-set!
syntax keyword schemeFunc hashtable-delete! hashtable-contains? hashtable-update!
syntax keyword schemeFunc hashtable-copy hashtable-clear! hashtable-keys
syntax keyword schemeFunc hashtable-entries hashtable-equivalence-function hashtable-hash-function
syntax keyword schemeFunc hashtable-mutable? equal-hash string-hash string-ci-hash symbol-hash
syntax keyword schemeFunc find for-all exists filter partition fold-left fold-right
syntax keyword schemeFunc remp remove remv remq memp assp cons*
endif

" ... so that a single + or -, inside a quoted context, would not be
" interpreted as a number (outside such contexts, it's a schemeFunc)

syntax match schemeDelimiter oneline    !\.[ \t\[\]()";]!me=e-1
syntax match schemeDelimiter oneline    !\.$!
" ... and a single dot is not a number but a delimiter

" This keeps all other stuff unhighlighted, except *stuff* and <stuff>:

syntax match schemeOther oneline    ,[a-zäöë!$%&*/:<=>?^_~+@%-][-a-zäöë!$%&*/:<=>?^_~0-9+.@%]*,
syntax match schemeError oneline    ,[a-zäöë!$%&*/:<=>?^_~+@%-][-a-zäöë!$%&*/:<=>?^_~0-9+.@%]*[^-a-zäöë!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

syntax match schemeOther oneline    "\.\.\."
syntax match schemeError oneline    !\.\.\.[^ \t\[\]()";]\+!
" ... a special identifier

syntax match schemeConstant  oneline    ,\*[-a-zäöë!$%&*/:<=>?^_~0-9+.@]*\*[ \t\[\]()";],me=e-1
syntax match schemeConstant  oneline    ,\*[-a-zäöë!$%&*/:<=>?^_~0-9+.@]*\*$,
syntax match schemeError oneline    ,\*[-a-zäöë!$%&*/:<=>?^_~0-9+.@]*\*[^-a-zäöë!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

syntax match schemeConstant  oneline    ,<[-a-zäöë!$%&*/:<=>?^_~0-9+.@]*>[ \t\[\]()";],me=e-1
syntax match schemeConstant  oneline    ,<[-a-zäöë!$%&*/:<=>?^_~0-9+.@]*>$,
syntax match schemeError oneline    ,<[-a-zäöë!$%&*/:<=>?^_~0-9+.@]*>[^-a-zäöë!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

" Non-quoted lists, and strings:

syntax region schemeStruc matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=ALL
syntax region schemeStruc matchgroup=Delimiter start="#(" matchgroup=Delimiter end=")" contains=ALL

syntax region schemeStruc matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=ALL
syntax region schemeStruc matchgroup=Delimiter start="#\[" matchgroup=Delimiter end="\]" contains=ALL

" Simple literals:
syntax region schemeString start=+\%(\\\)\@<!"+ skip=+\\[\\"]+ end=+"+

" Comments:

" this defines first for nested srfi-62 comment
" ( http://www.ac.cyberhome.ne.jp/~yakahaira/vimdoc/syntax.html#:syn-priority )
syntax region schemeSrfi62CommentParen start="(" end=")" contains=schemeSrfi62CommentParen transparent
syntax region schemeSrfi62CommentParen start="\[" end="\]" contains=schemeSrfi62CommentParen transparent

syntax match schemeSrfi62Comment oneline    ,#;[a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*,
syntax match schemeError   oneline    ,#;[a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*[^-a-z!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,
syntax match schemeSrfi62Comment oneline    ,#;['`][a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*,
syntax match schemeError   oneline    ,#;['`][a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*[^-a-z!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,
syntax region schemeSrfi62Comment matchgroup=Comment start="#;(" matchgroup=Comment end=")" contains=schemeSrfi62CommentParen
syntax region schemeSrfi62Comment matchgroup=Comment start="#;\[" matchgroup=Comment end="\]" contains=schemeSrfi62CommentParen
syntax region schemeSrfi62Comment matchgroup=Comment start="#;['`](" matchgroup=Comment end=")" contains=schemeSrfi62CommentParen
syntax region schemeSrfi62Comment matchgroup=Comment start="#;['`]\[" matchgroup=Comment end="\]" contains=schemeSrfi62CommentParen

syntax match schemeComment ";.*$" 
syntax keyword     schemeTodo    FIXME NOTE TODO OPTIMIZE XXX contained

" Writing out the complete description of Scheme numerals without
" using variables is a day's work for a trained secretary...

syntax match schemeOther oneline    ![+-][ \t\[\]()";]!me=e-1
syntax match schemeOther oneline    ![+-]$!
"
" This is a useful lax approximation:
syntax match schemeNumber  oneline    "[-+0-9.][-#+/0-9a-f@i.boxesfdl]*"
syntax match schemeError oneline    ![-+0-9.][-#+/0-9a-f@i.boxesfdl]*[^-#+/0-9a-f@i.boxesfdl \t\[\]()";][^ \t\[\]()";]*!
syntax match schemeNumber  oneline    "#[-#+/0-9a-f@i.boxesfdl]+"
syntax match schemeError oneline    !#[-#+/0-9a-f@i.boxesfdl]+[^-#+/0-9a-f@i.boxesfdl \t\[\]()";][^ \t\[\]()";]*!
syntax match schemeNumber  oneline    "[-+]inf\.0"
syntax match schemeError oneline    "[-+]inf\.0[^-#+/0-9a-f@i.boxesfdl \t\[\]()";][^ \t\[\]()";]*"
syntax match schemeNumber  oneline    "+nan\.0"
syntax match schemeError oneline    "+nan\.0[^-#+/0-9a-f@i.boxesfdl \t\[\]()";][^ \t\[\]()";]*"

syntax match schemeBoolean oneline    "#[tf]"
syntax match schemeError oneline    !#[tf][^ \t\[\]()";]\+!

syntax match schemeCharacter oneline    "#\\"
syntax match schemeCharacter oneline    "#\\."
syntax match schemeError oneline    !#\\.[^ \t\[\]()";]\+!
syntax match schemeCharacter oneline    "#\\space"
syntax match schemeError oneline    !#\\space[^ \t\[\]()";]\+!
syntax match schemeCharacter oneline    "#\\newline"
syntax match schemeError oneline    !#\\newline[^ \t\[\]()";]\+!

if exists("b:is_mzscheme") || exists("is_mzscheme")
  call mzscheme#syntax#define_keywords()
endif


if exists("b:is_chicken") || exists("is_chicken")
  call chicken#syntax#define_keywords()
endif


if exists("b:is_gauche") || exists("is_gauche")
  call gauche#syntax#define_keywords()
endif


" Synchronization and the wrapping up...

syntax sync match matchPlace grouphere NONE "^[^ \t]"
" ... i.e. synchronize on a line that starts at the left margin

call scheme#syntax#srfi#define_srfi()
call scheme#syntax#define_highligts()
call scheme#syntax#irregex#define_keywords()
if exists("b:scheme_is_r7rs") || exists("scheme_is_r7rs")
  call scheme#syntax#r7rs#define_r7rs()
endif

" syntax match schemeFunc oneline "\v\(define\s+\(\zs\w+\ze\s+"


let b:current_syntax = "scheme"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim:filetype=vim
