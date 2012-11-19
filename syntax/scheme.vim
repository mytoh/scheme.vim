" github.com/ayamada/copy-of-svn.tir.jp/nekoie/goshtags/make_scheme_vim.scm
"
" Vim syntax file
" Language:	Scheme (R5RS)
" Last Change:	2007 Jun 16
" Maintainer:	Sergey Khorev <sergey.khorev@gmail.com>
" Original author:	Dirk van Deun <dirk@igwe.vub.ac.be>

" Modifier:	yamada <yamada-remove-this-part@tir.jp>
"		( http://e.tir.jp/wiliki?vim:scheme.vim )
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

syn case ignore

" this defines first for nested srfi-62 comment
" ( http://www.ac.cyberhome.ne.jp/~yakahaira/vimdoc/syntax.html#:syn-priority )
syn region schemeSrfi62CommentParen start="(" end=")" contains=schemeSrfi62CommentParen transparent
syn region schemeSrfi62CommentParen start="\[" end="\]" contains=schemeSrfi62CommentParen transparent

" Fascist highlighting: everything that doesn't fit the rules is an error...

syn match	schemeError	oneline    ![^ \t()\[\]";]*!
syn match	schemeError	oneline    ")"

" Quoted and backquoted stuff

syn region schemeQuoted matchgroup=Delimiter start="['`]" end=![ \t()\[\]";]!me=e-1 contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syn region schemeQuoted matchgroup=Delimiter start="['`](" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeQuoted matchgroup=Delimiter start="['`]#(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syn region schemeStrucRestricted matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeStrucRestricted matchgroup=Delimiter start="#(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

" Popular Scheme extension:
" using [] as well as ()
syn region schemeQuoted matchgroup=Delimiter start="['`]\[" matchgroup=Delimiter end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeQuoted matchgroup=Delimiter start="['`]#\[" matchgroup=Delimiter end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeStrucRestricted matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeStrucRestricted matchgroup=Delimiter start="#\[" matchgroup=Delimiter end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syn region schemeUnquote matchgroup=Delimiter start="," end=![ \t\[\]()";]!me=e-1 contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeUnquote matchgroup=Delimiter start=",@" end=![ \t\[\]()";]!me=e-1 contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syn region schemeUnquote matchgroup=Delimiter start=",(" end=")" contains=ALL
syn region schemeUnquote matchgroup=Delimiter start=",@(" end=")" contains=ALL

syn region schemeUnquote matchgroup=Delimiter start=",#(" end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeUnquote matchgroup=Delimiter start=",@#(" end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syn region schemeUnquote matchgroup=Delimiter start=",\[" end="\]" contains=ALL
syn region schemeUnquote matchgroup=Delimiter start=",@\[" end="\]" contains=ALL

syn region schemeUnquote matchgroup=Delimiter start=",#\[" end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeUnquote matchgroup=Delimiter start=",@#\[" end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

" R5RS Scheme Functions and Syntax:

if version < 600
  set iskeyword=33,35-39,42,43,45-58,60-90,94,95,97-122,126,_
else
  setlocal iskeyword=33,35-39,42,43,45-58,60-90,94,95,97-122,_,126,192-255
endif

set lispwords=
set lispwords+=lambda,and,or,if,cond,case,define,let,let*,letrec
set lispwords+=begin,do,delay,set!,else,=>
set lispwords+=quote,quasiquote,unquote,unquote-splicing
set lispwords+=define-syntax,let-syntax,letrec-syntax,syntax-rules
syn keyword schemeSyntax lambda and or if cond case define let let* letrec
syn keyword schemeSyntax begin do delay set! else =>
syn keyword schemeSyntax quote quasiquote unquote unquote-splicing
syn keyword schemeSyntax define-syntax let-syntax letrec-syntax syntax-rules
" R6RS
syn keyword schemeSyntax define-record-type fields protocol

syn keyword schemeFunc not boolean? eq? eqv? equal? pair? cons car cdr set-car!
syn keyword schemeFunc set-cdr! caar cadr cdar cddr caaar caadr cadar caddr
syn keyword schemeFunc cdaar cdadr cddar cdddr caaaar caaadr caadar caaddr
syn keyword schemeFunc cadaar cadadr caddar cadddr cdaaar cdaadr cdadar cdaddr
syn keyword schemeFunc cddaar cddadr cdddar cddddr null? list? list length
syn keyword schemeFunc append reverse list-ref memq memv member assq assv assoc
syn keyword schemeFunc symbol? symbol->string string->symbol number? complex?
syn keyword schemeFunc real? rational? integer? exact? inexact? = < > <= >=
syn keyword schemeFunc zero? positive? negative? odd? even? max min + * - / abs
syn keyword schemeFunc quotient remainder modulo gcd lcm numerator denominator
syn keyword schemeFunc floor ceiling truncate round rationalize exp log sin cos
syn keyword schemeFunc tan asin acos atan sqrt expt make-rectangular make-polar
syn keyword schemeFunc real-part imag-part magnitude angle exact->inexact
syn keyword schemeFunc inexact->exact number->string string->number char=?
syn keyword schemeFunc char-ci=? char<? char-ci<? char>? char-ci>? char<=?
syn keyword schemeFunc char-ci<=? char>=? char-ci>=? char-alphabetic? char?
syn keyword schemeFunc char-numeric? char-whitespace? char-upper-case?
syn keyword schemeFunc char-lower-case?
syn keyword schemeFunc char->integer integer->char char-upcase char-downcase
syn keyword schemeFunc string? make-string string string-length string-ref
syn keyword schemeFunc string-set! string=? string-ci=? string<? string-ci<?
syn keyword schemeFunc string>? string-ci>? string<=? string-ci<=? string>=?
syn keyword schemeFunc string-ci>=? substring string-append vector? make-vector
syn keyword schemeFunc vector vector-length vector-ref vector-set! procedure?
syn keyword schemeFunc apply map for-each call-with-current-continuation
syn keyword schemeFunc call-with-input-file call-with-output-file input-port?
syn keyword schemeFunc output-port? current-input-port current-output-port
syn keyword schemeFunc open-input-file open-output-file close-input-port
syn keyword schemeFunc close-output-port eof-object? read read-char peek-char
syn keyword schemeFunc write display newline write-char call/cc
syn keyword schemeFunc list-tail string->list list->string string-copy
syn keyword schemeFunc string-fill! vector->list list->vector vector-fill!
syn keyword schemeFunc force with-input-from-file with-output-to-file
syn keyword schemeFunc char-ready? load transcript-on transcript-off eval
syn keyword schemeFunc dynamic-wind port? values call-with-values
syn keyword schemeFunc scheme-report-environment null-environment
syn keyword schemeFunc interaction-environment
" R6RS
syn keyword schemeFunc make-eq-hashtable make-eqv-hashtable make-hashtable
syn keyword schemeFunc hashtable? hashtable-size hashtable-ref hashtable-set!
syn keyword schemeFunc hashtable-delete! hashtable-contains? hashtable-update!
syn keyword schemeFunc hashtable-copy hashtable-clear! hashtable-keys
syn keyword schemeFunc hashtable-entries hashtable-equivalence-function hashtable-hash-function
syn keyword schemeFunc hashtable-mutable? equal-hash string-hash string-ci-hash symbol-hash
syn keyword schemeFunc find for-all exists filter partition fold-left fold-right
syn keyword schemeFunc remp remove remv remq memp assp cons*

" ... so that a single + or -, inside a quoted context, would not be
" interpreted as a number (outside such contexts, it's a schemeFunc)

syn match	schemeDelimiter	oneline    !\.[ \t\[\]()";]!me=e-1
syn match	schemeDelimiter	oneline    !\.$!
" ... and a single dot is not a number but a delimiter

" This keeps all other stuff unhighlighted, except *stuff* and <stuff>:

syn match	schemeOther	oneline    ,[a-zäöë!$%&*/:<=>?^_~+@%-][-a-zäöë!$%&*/:<=>?^_~0-9+.@%]*,
syn match	schemeError	oneline    ,[a-zäöë!$%&*/:<=>?^_~+@%-][-a-zäöë!$%&*/:<=>?^_~0-9+.@%]*[^-a-zäöë!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

syn match	schemeOther	oneline    "\.\.\."
syn match	schemeError	oneline    !\.\.\.[^ \t\[\]()";]\+!
" ... a special identifier

syn match	schemeConstant	oneline    ,\*[-a-zäöë!$%&*/:<=>?^_~0-9+.@]*\*[ \t\[\]()";],me=e-1
syn match	schemeConstant	oneline    ,\*[-a-zäöë!$%&*/:<=>?^_~0-9+.@]*\*$,
syn match	schemeError	oneline    ,\*[-a-zäöë!$%&*/:<=>?^_~0-9+.@]*\*[^-a-zäöë!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

syn match	schemeConstant	oneline    ,<[-a-zäöë!$%&*/:<=>?^_~0-9+.@]*>[ \t\[\]()";],me=e-1
syn match	schemeConstant	oneline    ,<[-a-zäöë!$%&*/:<=>?^_~0-9+.@]*>$,
syn match	schemeError	oneline    ,<[-a-zäöë!$%&*/:<=>?^_~0-9+.@]*>[^-a-zäöë!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

" Non-quoted lists, and strings:

syn region schemeStruc matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=ALL
syn region schemeStruc matchgroup=Delimiter start="#(" matchgroup=Delimiter end=")" contains=ALL

syn region schemeStruc matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=ALL
syn region schemeStruc matchgroup=Delimiter start="#\[" matchgroup=Delimiter end="\]" contains=ALL

" Simple literals:
syn region schemeString start=+\%(\\\)\@<!"+ skip=+\\[\\"]+ end=+"+

" Comments:

syn match	schemeComment	";.*$" contains=@Spell
syn match	schemeSrfi62Comment	oneline    ,#;[a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*,
syn match	schemeError		oneline    ,#;[a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*[^-a-z!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,
syn match	schemeSrfi62Comment	oneline    ,#;['`][a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*,
syn match	schemeError		oneline    ,#;['`][a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*[^-a-z!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,
syn region schemeSrfi62Comment matchgroup=Comment start="#;(" matchgroup=Comment end=")" contains=schemeSrfi62CommentParen,schemeTodo
syn region schemeSrfi62Comment matchgroup=Comment start="#;\[" matchgroup=Comment end="\]" contains=schemeSrfi62CommentParen,schemeTodo
syn region schemeSrfi62Comment matchgroup=Comment start="#;['`](" matchgroup=Comment end=")" contains=schemeSrfi62CommentParen,schemeTodo
syn region schemeSrfi62Comment matchgroup=Comment start="#;['`]\[" matchgroup=Comment end="\]" contains=schemeSrfi62CommentParen,schemeTodo
syn match	schemeComment	";.*$" contains=schemeTodo
syn keyword     schemeTodo	  FIXME NOTE TODO OPTIMIZE XXX contained

" Writing out the complete description of Scheme numerals without
" using variables is a day's work for a trained secretary...

syn match	schemeOther	oneline    ![+-][ \t\[\]()";]!me=e-1
syn match	schemeOther	oneline    ![+-]$!
"
" This is a useful lax approximation:
syn match	schemeNumber	oneline    "[-+0-9.][-#+/0-9a-f@i.boxesfdl]*"
syn match	schemeError	oneline    ![-+0-9.][-#+/0-9a-f@i.boxesfdl]*[^-#+/0-9a-f@i.boxesfdl \t\[\]()";][^ \t\[\]()";]*!
syn match	schemeNumber	oneline    "#[-#+/0-9a-f@i.boxesfdl]+"
syn match	schemeError	oneline    !#[-#+/0-9a-f@i.boxesfdl]+[^-#+/0-9a-f@i.boxesfdl \t\[\]()";][^ \t\[\]()";]*!
syn match	schemeNumber	oneline    "[-+]inf\.0"
syn match	schemeError	oneline    "[-+]inf\.0[^-#+/0-9a-f@i.boxesfdl \t\[\]()";][^ \t\[\]()";]*"
syn match	schemeNumber	oneline    "+nan\.0"
syn match	schemeError	oneline    "+nan\.0[^-#+/0-9a-f@i.boxesfdl \t\[\]()";][^ \t\[\]()";]*"

syn match	schemeBoolean	oneline    "#[tf]"
syn match	schemeError	oneline    !#[tf][^ \t\[\]()";]\+!

syn match	schemeCharacter	oneline    "#\\"
syn match	schemeCharacter	oneline    "#\\."
syn match	schemeError	oneline    !#\\.[^ \t\[\]()";]\+!
syn match	schemeCharacter	oneline    "#\\space"
syn match	schemeError	oneline    !#\\space[^ \t\[\]()";]\+!
syn match	schemeCharacter	oneline    "#\\newline"
syn match	schemeError	oneline    !#\\newline[^ \t\[\]()";]\+!

if exists("b:is_mzscheme") || exists("is_mzscheme")
    " MzScheme extensions
    " multiline comment
    syn region	schemeComment start="#|" end="|#" contains=@Spell

    " #%xxx are the special MzScheme identifiers
    syn match schemeOther oneline    "#%[-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"
    " anything limited by |'s is identifier
    syn match schemeOther oneline    "|[^|]\+|"

    syn match	schemeCharacter	oneline    "#\\\%(return\|tab\)"

    " Modules require stmt
    syn keyword schemeExtSyntax module require dynamic-require lib prefix all-except prefix-all-except rename
    " modules provide stmt
    syn keyword schemeExtSyntax provide struct all-from all-from-except all-defined all-defined-except
    " Other from MzScheme
    syn keyword schemeExtSyntax with-handlers when unless instantiate define-struct case-lambda syntax-case
    syn keyword schemeExtSyntax free-identifier=? bound-identifier=? module-identifier=? syntax-object->datum
    syn keyword schemeExtSyntax datum->syntax-object
    syn keyword schemeExtSyntax let-values let*-values letrec-values set!-values fluid-let parameterize begin0
    syn keyword schemeExtSyntax error raise opt-lambda define-values unit unit/sig define-signature 
    syn keyword schemeExtSyntax invoke-unit/sig define-values/invoke-unit/sig compound-unit/sig import export
    syn keyword schemeExtSyntax link syntax quasisyntax unsyntax with-syntax

    syn keyword schemeExtFunc format system-type current-extension-compiler current-extension-linker
    syn keyword schemeExtFunc use-standard-linker use-standard-compiler
    syn keyword schemeExtFunc find-executable-path append-object-suffix append-extension-suffix
    syn keyword schemeExtFunc current-library-collection-paths current-extension-compiler-flags make-parameter
    syn keyword schemeExtFunc current-directory build-path normalize-path current-extension-linker-flags
    syn keyword schemeExtFunc file-exists? directory-exists? delete-directory/files delete-directory delete-file
    syn keyword schemeExtFunc system compile-file system-library-subpath getenv putenv current-standard-link-libraries
    syn keyword schemeExtFunc remove* file-size find-files fold-files directory-list shell-execute split-path
    syn keyword schemeExtFunc current-error-port process/ports process printf fprintf open-input-string open-output-string
    syn keyword schemeExtFunc get-output-string
    " exceptions
    syn keyword schemeExtFunc exn exn:application:arity exn:application:continuation exn:application:fprintf:mismatch
    syn keyword schemeExtFunc exn:application:mismatch exn:application:type exn:application:mismatch exn:break exn:i/o:filesystem exn:i/o:port
    syn keyword schemeExtFunc exn:i/o:port:closed exn:i/o:tcp exn:i/o:udp exn:misc exn:misc:application exn:misc:unsupported exn:module exn:read
    syn keyword schemeExtFunc exn:read:non-char exn:special-comment exn:syntax exn:thread exn:user exn:variable exn:application:mismatch
    syn keyword schemeExtFunc exn? exn:application:arity? exn:application:continuation? exn:application:fprintf:mismatch? exn:application:mismatch?
    syn keyword schemeExtFunc exn:application:type? exn:application:mismatch? exn:break? exn:i/o:filesystem? exn:i/o:port? exn:i/o:port:closed?
    syn keyword schemeExtFunc exn:i/o:tcp? exn:i/o:udp? exn:misc? exn:misc:application? exn:misc:unsupported? exn:module? exn:read? exn:read:non-char?
    syn keyword schemeExtFunc exn:special-comment? exn:syntax? exn:thread? exn:user? exn:variable? exn:application:mismatch?
    " Command-line parsing
    syn keyword schemeExtFunc command-line current-command-line-arguments once-any help-labels multi once-each 

    " syntax quoting, unquoting and quasiquotation
    syn region schemeUnquote matchgroup=Delimiter start="#," end=![ \t\[\]()";]!me=e-1 contains=ALL
    syn region schemeUnquote matchgroup=Delimiter start="#,@" end=![ \t\[\]()";]!me=e-1 contains=ALL
    syn region schemeUnquote matchgroup=Delimiter start="#,(" end=")" contains=ALL
    syn region schemeUnquote matchgroup=Delimiter start="#,@(" end=")" contains=ALL
    syn region schemeUnquote matchgroup=Delimiter start="#,\[" end="\]" contains=ALL
    syn region schemeUnquote matchgroup=Delimiter start="#,@\[" end="\]" contains=ALL
    syn region schemeQuoted matchgroup=Delimiter start="#['`]" end=![ \t()\[\]";]!me=e-1 contains=ALL
    syn region schemeQuoted matchgroup=Delimiter start="#['`](" matchgroup=Delimiter end=")" contains=ALL
endif


if exists("b:is_chicken") || exists("is_chicken")
    " multiline comment
    syntax region schemeMultilineComment start=/#|/ end=/|#/ contains=@Spell,schemeMultilineComment,schemeTodo

    syn match schemeOther "##[-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"
    syn match schemeExtSyntax "#:[-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"

    syn keyword schemeExtSyntax unit uses declare hide foreign-declare foreign-parse foreign-parse/spec
    syn keyword schemeExtSyntax foreign-lambda foreign-lambda* define-external define-macro load-library
    syn keyword schemeExtSyntax let-values let*-values letrec-values ->string require-extension
    syn keyword schemeExtSyntax let-optionals let-optionals* define-foreign-variable define-record
    syn keyword schemeExtSyntax pointer tag-pointer tagged-pointer? define-foreign-type
    syn keyword schemeExtSyntax require require-for-syntax cond-expand and-let* receive argc+argv
    syn keyword schemeExtSyntax fixnum? fx= fx> fx< fx>= fx<= fxmin fxmax
    syn keyword schemeExtFunc ##core#inline ##sys#error ##sys#update-errno

    " here-string
    syn region schemeString start=+#<<\s*\z(.*\)+ end=+^\z1$+ contains=@Spell

    if filereadable(expand("<sfile>:p:h")."/cpp.vim")
	unlet! b:current_syntax
	syn include @ChickenC <sfile>:p:h/cpp.vim
	syn region ChickenC matchgroup=schemeOther start=+(\@<=foreign-declare "+ end=+")\@=+ contains=@ChickenC
	syn region ChickenC matchgroup=schemeComment start=+foreign-declare\s*#<<\z(.*\)$+hs=s+15 end=+^\z1$+ contains=@ChickenC
	syn region ChickenC matchgroup=schemeOther start=+(\@<=foreign-parse "+ end=+")\@=+ contains=@ChickenC
	syn region ChickenC matchgroup=schemeComment start=+foreign-parse\s*#<<\z(.*\)$+hs=s+13 end=+^\z1$+ contains=@ChickenC
	syn region ChickenC matchgroup=schemeOther start=+(\@<=foreign-parse/spec "+ end=+")\@=+ contains=@ChickenC
	syn region ChickenC matchgroup=schemeComment start=+foreign-parse/spec\s*#<<\z(.*\)$+hs=s+18 end=+^\z1$+ contains=@ChickenC
	syn region ChickenC matchgroup=schemeComment start=+#>+ end=+<#+ contains=@ChickenC
	syn region ChickenC matchgroup=schemeComment start=+#>?+ end=+<#+ contains=@ChickenC
	syn region ChickenC matchgroup=schemeComment start=+#>!+ end=+<#+ contains=@ChickenC
	syn region ChickenC matchgroup=schemeComment start=+#>\$+ end=+<#+ contains=@ChickenC
	syn region ChickenC matchgroup=schemeComment start=+#>%+ end=+<#+ contains=@ChickenC
    endif

    " suggested by Alex Queiroz
    syn match schemeExtSyntax "#![-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"
    syn region schemeString start=+#<#\s*\z(.*\)+ end=+^\z1$+ contains=@Spell
endif


if exists("b:is_gauche") || exists("is_gauche")
call gauche#syntax#define_keywords()

" this part was auto-generated.
    " module
    syn keyword schemeGaucheExtFunc %slib-load
    syn keyword schemeGaucheExtFunc *argc*
    syn keyword schemeGaucheExtFunc *base-table-implementations*
    syn keyword schemeGaucheExtFunc *catalog*
    syn keyword schemeGaucheExtFunc *features*
    syn keyword schemeGaucheExtFunc *load-pathname*
    syn keyword schemeGaucheExtFunc *slib-version*
    syn keyword schemeGaucheExtFunc -1+
    syn keyword schemeGaucheExtFunc 1+
    syn keyword schemeGaucheExtFunc 1-
    syn keyword schemeGaucheExtFunc <instance-table-meta>
    syn keyword schemeGaucheExtFunc <instance-table-mixin>
    syn keyword schemeGaucheExtFunc G184
    syn keyword schemeGaucheExtFunc G185
    syn keyword schemeGaucheExtFunc G2355
    syn keyword schemeGaucheExtFunc G2356
    syn keyword schemeGaucheExtFunc G3007
    syn keyword schemeGaucheExtFunc G3008
    syn keyword schemeGaucheExtFunc G3009
    syn keyword schemeGaucheExtFunc G3010
    syn keyword schemeGaucheExtFunc G3011
    syn keyword schemeGaucheExtFunc G3012
    syn keyword schemeGaucheExtFunc G3013
    syn keyword schemeGaucheExtFunc G3301
    syn keyword schemeGaucheExtFunc G5
    syn keyword schemeGaucheExtFunc G6
    syn keyword schemeGaucheExtFunc G921
    syn keyword schemeGaucheExtFunc G922
    syn keyword schemeGaucheExtFunc G923
    syn keyword schemeGaucheExtFunc access-log
    syn keyword schemeGaucheExtFunc access-log-drain
    syn keyword schemeGaucheExtFunc add-http-handler!
    syn keyword schemeGaucheExtFunc add-signal-handler!
    syn keyword schemeGaucheExtFunc address-of
    syn keyword schemeGaucheExtFunc address?
    syn keyword schemeGaucheExtFunc autoload?
    syn keyword schemeGaucheExtFunc base:eval
    syn keyword schemeGaucheExtFunc blockc
    syn keyword schemeGaucheExtFunc browse-url
    syn keyword schemeGaucheExtFunc byte-ref
    syn keyword schemeGaucheExtFunc byte-set!
    syn keyword schemeGaucheExtFunc bytes
    syn keyword schemeGaucheExtFunc bytes->list
    syn keyword schemeGaucheExtFunc bytes-length
    syn keyword schemeGaucheExtFunc call-with-open-ports
    syn keyword schemeGaucheExtFunc catalog/require-version-match?
    syn keyword schemeGaucheExtFunc catalog:get
    syn keyword schemeGaucheExtFunc catalog:read
    syn keyword schemeGaucheExtFunc catalog:resolve
    syn keyword schemeGaucheExtFunc catalog:try-read
    syn keyword schemeGaucheExtFunc catch
    syn keyword schemeGaucheExtFunc cd
    syn keyword schemeGaucheExtFunc cgi-handler
    syn keyword schemeGaucheExtFunc cgi-script
    syn keyword schemeGaucheExtFunc char-code-limit
    syn keyword schemeGaucheExtFunc close-port
    syn keyword schemeGaucheExtFunc colour-command
    syn keyword schemeGaucheExtFunc colour-info
    syn keyword schemeGaucheExtFunc colour-info-homepage
    syn keyword schemeGaucheExtFunc colour-info-package
    syn keyword schemeGaucheExtFunc colour-info-repository
    syn keyword schemeGaucheExtFunc colour-message
    syn keyword schemeGaucheExtFunc colour-package
    syn keyword schemeGaucheExtFunc colour-path
    syn keyword schemeGaucheExtFunc colour-string
    syn keyword schemeGaucheExtFunc colour-symbol1
    syn keyword schemeGaucheExtFunc colour-symbol2
    syn keyword schemeGaucheExtFunc commands
    syn keyword schemeGaucheExtFunc concat
    syn keyword schemeGaucheExtFunc continuation?
    syn keyword schemeGaucheExtFunc copy-tree
    syn keyword schemeGaucheExtFunc daemonize
    syn keyword schemeGaucheExtFunc dbd-null-test-result-set!
    syn keyword schemeGaucheExtFunc define-http-handler
    syn keyword schemeGaucheExtFunc define-page-handler
    syn keyword schemeGaucheExtFunc defmacro
    syn keyword schemeGaucheExtFunc defmacro:load
    syn keyword schemeGaucheExtFunc delete-file
    syn keyword schemeGaucheExtFunc dump
    syn keyword schemeGaucheExtFunc environment->list
    syn keyword schemeGaucheExtFunc environment?
    syn keyword schemeGaucheExtFunc error-log
    syn keyword schemeGaucheExtFunc error-log-drain
    syn keyword schemeGaucheExtFunc eval-hook
    syn keyword schemeGaucheExtFunc expand-heap
    syn keyword schemeGaucheExtFunc export-all-symbols
    syn keyword schemeGaucheExtFunc export-symbol
    syn keyword schemeGaucheExtFunc feature-eval
    syn keyword schemeGaucheExtFunc file-handler
    syn keyword schemeGaucheExtFunc file-is-archive?
    syn keyword schemeGaucheExtFunc find-all-tags
    syn keyword schemeGaucheExtFunc force-output
    syn keyword schemeGaucheExtFunc gc-stats
    syn keyword schemeGaucheExtFunc gentemp
    syn keyword schemeGaucheExtFunc get-internal-info
    syn keyword schemeGaucheExtFunc get-os-type
    syn keyword schemeGaucheExtFunc global-environment
    syn keyword schemeGaucheExtFunc home-vicinity
    syn keyword schemeGaucheExtFunc html5
    syn keyword schemeGaucheExtFunc http-server-software
    syn keyword schemeGaucheExtFunc implementation-vicinity
    syn keyword schemeGaucheExtFunc in-vicinity
    syn keyword schemeGaucheExtFunc input-file-port?
    syn keyword schemeGaucheExtFunc input-string-port?
    syn keyword schemeGaucheExtFunc input-virtual-port?
    syn keyword schemeGaucheExtFunc kaava-kansio
    syn keyword schemeGaucheExtFunc kellari-kansio
    syn keyword schemeGaucheExtFunc library-vicinity
    syn keyword schemeGaucheExtFunc list->bytes
    syn keyword schemeGaucheExtFunc load-build-file
    syn keyword schemeGaucheExtFunc loop-forever
    syn keyword schemeGaucheExtFunc loopc
    syn keyword schemeGaucheExtFunc machine-type
    syn keyword schemeGaucheExtFunc macro
    syn keyword schemeGaucheExtFunc macro-body
    syn keyword schemeGaucheExtFunc macro-expand
    syn keyword schemeGaucheExtFunc macro-expand-1
    syn keyword schemeGaucheExtFunc macro:eval
    syn keyword schemeGaucheExtFunc macro:load
    syn keyword schemeGaucheExtFunc macro?
    syn keyword schemeGaucheExtFunc make-bytes
    syn keyword schemeGaucheExtFunc make-exchanger
    syn keyword schemeGaucheExtFunc make-vicinity
    syn keyword schemeGaucheExtFunc mik:mik->sxml
    syn keyword schemeGaucheExtFunc mik:nico-playlist->mik
    syn keyword schemeGaucheExtFunc mkdir
    syn keyword schemeGaucheExtFunc module-environment
    syn keyword schemeGaucheExtFunc module-symbols
    syn keyword schemeGaucheExtFunc most-positive-fixnum
    syn keyword schemeGaucheExtFunc nil
    syn keyword schemeGaucheExtFunc nothing
    syn keyword schemeGaucheExtFunc open
    syn keyword schemeGaucheExtFunc open-file
    syn keyword schemeGaucheExtFunc open-input-virtual
    syn keyword schemeGaucheExtFunc open-output-virtual
    syn keyword schemeGaucheExtFunc output-file-port?
    syn keyword schemeGaucheExtFunc output-port-height
    syn keyword schemeGaucheExtFunc output-port-width
    syn keyword schemeGaucheExtFunc output-string-port?
    syn keyword schemeGaucheExtFunc output-virtual-port?
    syn keyword schemeGaucheExtFunc p
    syn keyword schemeGaucheExtFunc panna-kansio
    syn keyword schemeGaucheExtFunc parent-environment
    syn keyword schemeGaucheExtFunc pathname->vicinity
    syn keyword schemeGaucheExtFunc port->incomplete-string
    syn keyword schemeGaucheExtFunc posix-mkdir
    syn keyword schemeGaucheExtFunc posix-perror
    syn keyword schemeGaucheExtFunc print-strings
    syn keyword schemeGaucheExtFunc procedure-body
    syn keyword schemeGaucheExtFunc procedure-environment
    syn keyword schemeGaucheExtFunc program-arguments
    syn keyword schemeGaucheExtFunc program-vicinity
    syn keyword schemeGaucheExtFunc report:print
    syn keyword schemeGaucheExtFunc request-cookie-ref
    syn keyword schemeGaucheExtFunc request-cookies
    syn keyword schemeGaucheExtFunc request-header-ref
    syn keyword schemeGaucheExtFunc request-headers
    syn keyword schemeGaucheExtFunc request-iport
    syn keyword schemeGaucheExtFunc request-method
    syn keyword schemeGaucheExtFunc request-oport
    syn keyword schemeGaucheExtFunc request-params
    syn keyword schemeGaucheExtFunc request-path
    syn keyword schemeGaucheExtFunc request-path-rxmatch
    syn keyword schemeGaucheExtFunc request-response-error
    syn keyword schemeGaucheExtFunc request-server-host
    syn keyword schemeGaucheExtFunc request-server-port
    syn keyword schemeGaucheExtFunc request-socket
    syn keyword schemeGaucheExtFunc request?
    syn keyword schemeGaucheExtFunc require-if
    syn keyword schemeGaucheExtFunc respond/ng
    syn keyword schemeGaucheExtFunc respond/ok
    syn keyword schemeGaucheExtFunc respond/redirect
    syn keyword schemeGaucheExtFunc response-cookie-add!
    syn keyword schemeGaucheExtFunc response-cookie-delete!
    syn keyword schemeGaucheExtFunc response-header-delete!
    syn keyword schemeGaucheExtFunc response-header-push!
    syn keyword schemeGaucheExtFunc response-header-replace!
    syn keyword schemeGaucheExtFunc riisi-kansio
    syn keyword schemeGaucheExtFunc run-command
    syn keyword schemeGaucheExtFunc run-command-sudo
    syn keyword schemeGaucheExtFunc scheme-file-suffix
    syn keyword schemeGaucheExtFunc scheme-implementation-home-page
    syn keyword schemeGaucheExtFunc scheme-implementation-type
    syn keyword schemeGaucheExtFunc scheme-implementation-version
    syn keyword schemeGaucheExtFunc send-signal
    syn keyword schemeGaucheExtFunc slib:error
    syn keyword schemeGaucheExtFunc slib:eval
    syn keyword schemeGaucheExtFunc slib:eval-load
    syn keyword schemeGaucheExtFunc slib:exit
    syn keyword schemeGaucheExtFunc slib:features
    syn keyword schemeGaucheExtFunc slib:form-feed
    syn keyword schemeGaucheExtFunc slib:in-catalog?
    syn keyword schemeGaucheExtFunc slib:load
    syn keyword schemeGaucheExtFunc slib:load-compiled
    syn keyword schemeGaucheExtFunc slib:load-source
    syn keyword schemeGaucheExtFunc slib:pathnameize-load
    syn keyword schemeGaucheExtFunc slib:provide
    syn keyword schemeGaucheExtFunc slib:provided?
    syn keyword schemeGaucheExtFunc slib:report
    syn keyword schemeGaucheExtFunc slib:report-locations
    syn keyword schemeGaucheExtFunc slib:report-version
    syn keyword schemeGaucheExtFunc slib:require
    syn keyword schemeGaucheExtFunc slib:require-if
    syn keyword schemeGaucheExtFunc slib:tab
    syn keyword schemeGaucheExtFunc slib:version
    syn keyword schemeGaucheExtFunc slib:warn
    syn keyword schemeGaucheExtFunc software-type
    syn keyword schemeGaucheExtFunc start-http-server
    syn keyword schemeGaucheExtFunc sub-vicinity
    syn keyword schemeGaucheExtFunc swget
    syn keyword schemeGaucheExtFunc t
    syn keyword schemeGaucheExtFunc tap
    syn keyword schemeGaucheExtFunc the-environment
    syn keyword schemeGaucheExtFunc tmpnam
    syn keyword schemeGaucheExtFunc try-load
    syn keyword schemeGaucheExtFunc uncode
    syn keyword schemeGaucheExtFunc url-is-bzr?
    syn keyword schemeGaucheExtFunc url-is-cvs?
    syn keyword schemeGaucheExtFunc url-is-fossil?
    syn keyword schemeGaucheExtFunc url-is-git?
    syn keyword schemeGaucheExtFunc url-is-hg?
    syn keyword schemeGaucheExtFunc url-is-svn?
    syn keyword schemeGaucheExtFunc user-vicinity
    syn keyword schemeGaucheExtFunc vector-resize
    syn keyword schemeGaucheExtFunc vicinity:suffix?
    syn keyword schemeGaucheExtFunc when-port-readable
    syn keyword schemeGaucheExtFunc when-port-writable
    syn keyword schemeGaucheExtFunc whitespace->dash
    syn keyword schemeGaucheExtFunc whitespace->underbar
    syn keyword schemeGaucheExtFunc with-load-pathname


    " syntax
    syn keyword schemeGaucheExtSyntax %macroexpand
    set lispwords+=%macroexpand
    syn keyword schemeGaucheExtSyntax %macroexpand-1
    set lispwords+=%macroexpand-1
    syn keyword schemeGaucheExtSyntax and-let*
    set lispwords+=and-let*
    syn keyword schemeGaucheExtSyntax case-lambda
    set lispwords+=case-lambda
    syn keyword schemeGaucheExtSyntax current-module
    set lispwords+=current-module
    syn keyword schemeGaucheExtSyntax define-class
    set lispwords+=define-class
    syn keyword schemeGaucheExtSyntax define-constant
    set lispwords+=define-constant
    syn keyword schemeGaucheExtSyntax define-generic
    set lispwords+=define-generic
    syn keyword schemeGaucheExtSyntax define-in-module
    set lispwords+=define-in-module
    syn keyword schemeGaucheExtSyntax define-inline
    set lispwords+=define-inline
    syn keyword schemeGaucheExtSyntax define-macro
    set lispwords+=define-macro
    syn keyword schemeGaucheExtSyntax define-method
    set lispwords+=define-method
    syn keyword schemeGaucheExtSyntax define-module
    set lispwords+=define-module
    syn keyword schemeGaucheExtSyntax eval-when
    set lispwords+=eval-when
    syn keyword schemeGaucheExtSyntax export
    set lispwords+=export
    syn keyword schemeGaucheExtSyntax export-all
    set lispwords+=export-all
    syn keyword schemeGaucheExtSyntax extend
    set lispwords+=extend
    syn keyword schemeGaucheExtSyntax import
    set lispwords+=import
    syn keyword schemeGaucheExtSyntax include
    set lispwords+=include
    syn keyword schemeGaucheExtSyntax lazy
    set lispwords+=lazy
    syn keyword schemeGaucheExtSyntax receive
    set lispwords+=receive
    syn keyword schemeGaucheExtSyntax require
    set lispwords+=require
    syn keyword schemeGaucheExtSyntax select-module
    set lispwords+=select-module
    syn keyword schemeGaucheExtSyntax unless
    set lispwords+=unless
    syn keyword schemeGaucheExtSyntax when
    set lispwords+=when
    syn keyword schemeGaucheExtSyntax with-module
    set lispwords+=with-module


    " macro
    syn keyword schemeGaucheExtSyntax $
    set lispwords+=$
    syn keyword schemeGaucheExtSyntax $*
    set lispwords+=$*
    syn keyword schemeGaucheExtSyntax $<<
    set lispwords+=$<<
    syn keyword schemeGaucheExtSyntax $do
    set lispwords+=$do
    syn keyword schemeGaucheExtSyntax $do*
    set lispwords+=$do*
    syn keyword schemeGaucheExtSyntax $lazy
    set lispwords+=$lazy
    syn keyword schemeGaucheExtSyntax $many-chars
    set lispwords+=$many-chars
    syn keyword schemeGaucheExtSyntax $or
    set lispwords+=$or
    syn keyword schemeGaucheExtSyntax $satisfy
    set lispwords+=$satisfy
    syn keyword schemeGaucheExtSyntax %do-ec
    set lispwords+=%do-ec
    syn keyword schemeGaucheExtSyntax %ec-guarded-do-ec
    set lispwords+=%ec-guarded-do-ec
    syn keyword schemeGaucheExtSyntax %first-ec
    set lispwords+=%first-ec
    syn keyword schemeGaucheExtSyntax %guard-rec
    set lispwords+=%guard-rec
    syn keyword schemeGaucheExtSyntax %replace-keywords
    set lispwords+=%replace-keywords
    syn keyword schemeGaucheExtSyntax --
    set lispwords+=--
    syn keyword schemeGaucheExtSyntax ^
    set lispwords+=^
    syn keyword schemeGaucheExtSyntax ^*
    set lispwords+=^*
    syn keyword schemeGaucheExtSyntax ^-generator
    set lispwords+=^-generator
    syn keyword schemeGaucheExtSyntax ^.
    set lispwords+=^.
    syn keyword schemeGaucheExtSyntax ^_
    set lispwords+=^_
    syn keyword schemeGaucheExtSyntax ^a
    set lispwords+=^a
    syn keyword schemeGaucheExtSyntax ^b
    set lispwords+=^b
    syn keyword schemeGaucheExtSyntax ^c
    set lispwords+=^c
    syn keyword schemeGaucheExtSyntax ^d
    set lispwords+=^d
    syn keyword schemeGaucheExtSyntax ^e
    set lispwords+=^e
    syn keyword schemeGaucheExtSyntax ^f
    set lispwords+=^f
    syn keyword schemeGaucheExtSyntax ^g
    set lispwords+=^g
    syn keyword schemeGaucheExtSyntax ^h
    set lispwords+=^h
    syn keyword schemeGaucheExtSyntax ^i
    set lispwords+=^i
    syn keyword schemeGaucheExtSyntax ^j
    set lispwords+=^j
    syn keyword schemeGaucheExtSyntax ^k
    set lispwords+=^k
    syn keyword schemeGaucheExtSyntax ^l
    set lispwords+=^l
    syn keyword schemeGaucheExtSyntax ^m
    set lispwords+=^m
    syn keyword schemeGaucheExtSyntax ^n
    set lispwords+=^n
    syn keyword schemeGaucheExtSyntax ^o
    set lispwords+=^o
    syn keyword schemeGaucheExtSyntax ^p
    set lispwords+=^p
    syn keyword schemeGaucheExtSyntax ^q
    set lispwords+=^q
    syn keyword schemeGaucheExtSyntax ^r
    set lispwords+=^r
    syn keyword schemeGaucheExtSyntax ^s
    set lispwords+=^s
    syn keyword schemeGaucheExtSyntax ^t
    set lispwords+=^t
    syn keyword schemeGaucheExtSyntax ^u
    set lispwords+=^u
    syn keyword schemeGaucheExtSyntax ^v
    set lispwords+=^v
    syn keyword schemeGaucheExtSyntax ^w
    set lispwords+=^w
    syn keyword schemeGaucheExtSyntax ^x
    set lispwords+=^x
    syn keyword schemeGaucheExtSyntax ^y
    set lispwords+=^y
    syn keyword schemeGaucheExtSyntax ^z
    set lispwords+=^z
    syn keyword schemeGaucheExtSyntax add-load-path
    set lispwords+=add-load-path
    syn keyword schemeGaucheExtSyntax any?-ec
    set lispwords+=any?-ec
    syn keyword schemeGaucheExtSyntax append-ec
    set lispwords+=append-ec
    syn keyword schemeGaucheExtSyntax assert
    set lispwords+=assert
    syn keyword schemeGaucheExtSyntax autoload
    set lispwords+=autoload
    syn keyword schemeGaucheExtSyntax begin0
    set lispwords+=begin0
    syn keyword schemeGaucheExtSyntax cgen-with-cpp-condition
    set lispwords+=cgen-with-cpp-condition
    syn keyword schemeGaucheExtSyntax check-arg
    set lispwords+=check-arg
    syn keyword schemeGaucheExtSyntax cond-expand
    set lispwords+=cond-expand
    syn keyword schemeGaucheExtSyntax cond-list
    set lispwords+=cond-list
    syn keyword schemeGaucheExtSyntax condition
    set lispwords+=condition
    syn keyword schemeGaucheExtSyntax cut
    set lispwords+=cut
    syn keyword schemeGaucheExtSyntax cute
    set lispwords+=cute
    syn keyword schemeGaucheExtSyntax debug-print
    set lispwords+=debug-print
    syn keyword schemeGaucheExtSyntax dec!
    set lispwords+=dec!
    syn keyword schemeGaucheExtSyntax declare
    set lispwords+=declare
    syn keyword schemeGaucheExtSyntax define-^x
    set lispwords+=define-^x
    syn keyword schemeGaucheExtSyntax define-cgen-literal
    set lispwords+=define-cgen-literal
    syn keyword schemeGaucheExtSyntax define-cise-expr
    set lispwords+=define-cise-expr
    syn keyword schemeGaucheExtSyntax define-cise-macro
    set lispwords+=define-cise-macro
    syn keyword schemeGaucheExtSyntax define-cise-stmt
    set lispwords+=define-cise-stmt
    syn keyword schemeGaucheExtSyntax define-cise-toplevel
    set lispwords+=define-cise-toplevel
    syn keyword schemeGaucheExtSyntax define-compiler-macro
    set lispwords+=define-compiler-macro
    syn keyword schemeGaucheExtSyntax define-condition-type
    set lispwords+=define-condition-type
    syn keyword schemeGaucheExtSyntax define-fstruct-type
    set lispwords+=define-fstruct-type
    syn keyword schemeGaucheExtSyntax define-record-type
    set lispwords+=define-record-type
    syn keyword schemeGaucheExtSyntax define-values
    set lispwords+=define-values
    syn keyword schemeGaucheExtSyntax do-ec
    set lispwords+=do-ec
    syn keyword schemeGaucheExtSyntax do-ec:do
    set lispwords+=do-ec:do
    syn keyword schemeGaucheExtSyntax dolist
    set lispwords+=dolist
    syn keyword schemeGaucheExtSyntax dotimes
    set lispwords+=dotimes
    syn keyword schemeGaucheExtSyntax ec-guarded-do-ec
    set lispwords+=ec-guarded-do-ec
    syn keyword schemeGaucheExtSyntax ec-simplify
    set lispwords+=ec-simplify
    syn keyword schemeGaucheExtSyntax ecase
    set lispwords+=ecase
    syn keyword schemeGaucheExtSyntax ecase-helper
    set lispwords+=ecase-helper
    syn keyword schemeGaucheExtSyntax every?-ec
    set lispwords+=every?-ec
    syn keyword schemeGaucheExtSyntax export-if-defined
    set lispwords+=export-if-defined
    syn keyword schemeGaucheExtSyntax first-ec
    set lispwords+=first-ec
    syn keyword schemeGaucheExtSyntax fluid-let
    set lispwords+=fluid-let
    syn keyword schemeGaucheExtSyntax fold-ec
    set lispwords+=fold-ec
    syn keyword schemeGaucheExtSyntax fold3-ec
    set lispwords+=fold3-ec
    syn keyword schemeGaucheExtSyntax get-keyword*
    set lispwords+=get-keyword*
    syn keyword schemeGaucheExtSyntax get-optional
    set lispwords+=get-optional
    syn keyword schemeGaucheExtSyntax guard
    set lispwords+=guard
    syn keyword schemeGaucheExtSyntax http-cond-receiver
    set lispwords+=http-cond-receiver
    syn keyword schemeGaucheExtSyntax if-let1
    set lispwords+=if-let1
    syn keyword schemeGaucheExtSyntax inc!
    set lispwords+=inc!
    syn keyword schemeGaucheExtSyntax inline-stub
    set lispwords+=inline-stub
    syn keyword schemeGaucheExtSyntax last-ec
    set lispwords+=last-ec
    syn keyword schemeGaucheExtSyntax let*-values
    set lispwords+=let*-values
    syn keyword schemeGaucheExtSyntax let-args
    set lispwords+=let-args
    syn keyword schemeGaucheExtSyntax let-keywords
    set lispwords+=let-keywords
    syn keyword schemeGaucheExtSyntax let-keywords*
    set lispwords+=let-keywords*
    syn keyword schemeGaucheExtSyntax let-optionals*
    set lispwords+=let-optionals*
    syn keyword schemeGaucheExtSyntax let-string-start+end
    set lispwords+=let-string-start+end
    syn keyword schemeGaucheExtSyntax let-values
    set lispwords+=let-values
    syn keyword schemeGaucheExtSyntax let/cc
    set lispwords+=let/cc
    syn keyword schemeGaucheExtSyntax let1
    set lispwords+=let1
    syn keyword schemeGaucheExtSyntax list-ec
    set lispwords+=list-ec
    syn keyword schemeGaucheExtSyntax make-option-parser
    set lispwords+=make-option-parser
    syn keyword schemeGaucheExtSyntax match
    set lispwords+=match
    syn keyword schemeGaucheExtSyntax match-define
    set lispwords+=match-define
    syn keyword schemeGaucheExtSyntax match-lambda
    set lispwords+=match-lambda
    syn keyword schemeGaucheExtSyntax match-lambda*
    set lispwords+=match-lambda*
    syn keyword schemeGaucheExtSyntax match-let
    set lispwords+=match-let
    syn keyword schemeGaucheExtSyntax match-let*
    set lispwords+=match-let*
    syn keyword schemeGaucheExtSyntax match-let1
    set lispwords+=match-let1
    syn keyword schemeGaucheExtSyntax match-letrec
    set lispwords+=match-letrec
    syn keyword schemeGaucheExtSyntax max-ec
    set lispwords+=max-ec
    syn keyword schemeGaucheExtSyntax min-ec
    set lispwords+=min-ec
    syn keyword schemeGaucheExtSyntax parameterize
    set lispwords+=parameterize
    syn keyword schemeGaucheExtSyntax parse-options
    set lispwords+=parse-options
    syn keyword schemeGaucheExtSyntax pop!
    set lispwords+=pop!
    syn keyword schemeGaucheExtSyntax product-ec
    set lispwords+=product-ec
    syn keyword schemeGaucheExtSyntax program
    set lispwords+=program
    syn keyword schemeGaucheExtSyntax push!
    set lispwords+=push!
    syn keyword schemeGaucheExtSyntax rec
    set lispwords+=rec
    syn keyword schemeGaucheExtSyntax require-extension
    set lispwords+=require-extension
    syn keyword schemeGaucheExtSyntax reset
    set lispwords+=reset
    syn keyword schemeGaucheExtSyntax rlet1
    set lispwords+=rlet1
    syn keyword schemeGaucheExtSyntax rxmatch-case
    set lispwords+=rxmatch-case
    syn keyword schemeGaucheExtSyntax rxmatch-cond
    set lispwords+=rxmatch-cond
    syn keyword schemeGaucheExtSyntax rxmatch-if
    set lispwords+=rxmatch-if
    syn keyword schemeGaucheExtSyntax rxmatch-let
    set lispwords+=rxmatch-let
    syn keyword schemeGaucheExtSyntax set!-values
    set lispwords+=set!-values
    syn keyword schemeGaucheExtSyntax shift
    set lispwords+=shift
    syn keyword schemeGaucheExtSyntax srfi-42-
    set lispwords+=srfi-42-
    syn keyword schemeGaucheExtSyntax srfi-42-char-range
    set lispwords+=srfi-42-char-range
    syn keyword schemeGaucheExtSyntax srfi-42-dispatched
    set lispwords+=srfi-42-dispatched
    syn keyword schemeGaucheExtSyntax srfi-42-do
    set lispwords+=srfi-42-do
    syn keyword schemeGaucheExtSyntax srfi-42-generator-proc
    set lispwords+=srfi-42-generator-proc
    syn keyword schemeGaucheExtSyntax srfi-42-integers
    set lispwords+=srfi-42-integers
    syn keyword schemeGaucheExtSyntax srfi-42-let
    set lispwords+=srfi-42-let
    syn keyword schemeGaucheExtSyntax srfi-42-list
    set lispwords+=srfi-42-list
    syn keyword schemeGaucheExtSyntax srfi-42-parallel
    set lispwords+=srfi-42-parallel
    syn keyword schemeGaucheExtSyntax srfi-42-parallel-1
    set lispwords+=srfi-42-parallel-1
    syn keyword schemeGaucheExtSyntax srfi-42-port
    set lispwords+=srfi-42-port
    syn keyword schemeGaucheExtSyntax srfi-42-range
    set lispwords+=srfi-42-range
    syn keyword schemeGaucheExtSyntax srfi-42-real-range
    set lispwords+=srfi-42-real-range
    syn keyword schemeGaucheExtSyntax srfi-42-string
    set lispwords+=srfi-42-string
    syn keyword schemeGaucheExtSyntax srfi-42-until
    set lispwords+=srfi-42-until
    syn keyword schemeGaucheExtSyntax srfi-42-until-1
    set lispwords+=srfi-42-until-1
    syn keyword schemeGaucheExtSyntax srfi-42-vector
    set lispwords+=srfi-42-vector
    syn keyword schemeGaucheExtSyntax srfi-42-while
    set lispwords+=srfi-42-while
    syn keyword schemeGaucheExtSyntax srfi-42-while-1
    set lispwords+=srfi-42-while-1
    syn keyword schemeGaucheExtSyntax srfi-42-while-2
    set lispwords+=srfi-42-while-2
    syn keyword schemeGaucheExtSyntax ssax:make-elem-parser
    set lispwords+=ssax:make-elem-parser
    syn keyword schemeGaucheExtSyntax ssax:make-parser
    set lispwords+=ssax:make-parser
    syn keyword schemeGaucheExtSyntax ssax:make-pi-parser
    set lispwords+=ssax:make-pi-parser
    syn keyword schemeGaucheExtSyntax stream-cons
    set lispwords+=stream-cons
    syn keyword schemeGaucheExtSyntax stream-delay
    set lispwords+=stream-delay
    syn keyword schemeGaucheExtSyntax string-append-ec
    set lispwords+=string-append-ec
    syn keyword schemeGaucheExtSyntax string-ec
    set lispwords+=string-ec
    syn keyword schemeGaucheExtSyntax sum-ec
    set lispwords+=sum-ec
    syn keyword schemeGaucheExtSyntax sxml:find-name-separator
    set lispwords+=sxml:find-name-separator
    syn keyword schemeGaucheExtSyntax syntax-error
    set lispwords+=syntax-error
    syn keyword schemeGaucheExtSyntax syntax-errorf
    set lispwords+=syntax-errorf
    syn keyword schemeGaucheExtSyntax test*
    set lispwords+=test*
    syn keyword schemeGaucheExtSyntax time
    set lispwords+=time
    syn keyword schemeGaucheExtSyntax until
    set lispwords+=until
    syn keyword schemeGaucheExtSyntax unwind-protect
    set lispwords+=unwind-protect
    syn keyword schemeGaucheExtSyntax update!
    set lispwords+=update!
    syn keyword schemeGaucheExtSyntax use
    set lispwords+=use
    syn keyword schemeGaucheExtSyntax use-version
    set lispwords+=use-version
    syn keyword schemeGaucheExtSyntax values-ref
    set lispwords+=values-ref
    syn keyword schemeGaucheExtSyntax vector-ec
    set lispwords+=vector-ec
    syn keyword schemeGaucheExtSyntax vector-of-length-ec
    set lispwords+=vector-of-length-ec
    syn keyword schemeGaucheExtSyntax while
    set lispwords+=while
    syn keyword schemeGaucheExtSyntax with-builder
    set lispwords+=with-builder
    syn keyword schemeGaucheExtSyntax with-iterator
    set lispwords+=with-iterator
    syn keyword schemeGaucheExtSyntax with-signal-handlers
    set lispwords+=with-signal-handlers
    syn keyword schemeGaucheExtSyntax with-time-counter
    set lispwords+=with-time-counter
    syn keyword schemeGaucheExtSyntax with-tmodule
    set lispwords+=with-tmodule
    syn keyword schemeGaucheExtSyntax xmac
    set lispwords+=xmac
    syn keyword schemeGaucheExtSyntax xmac1
    set lispwords+=xmac1


    " procedure
    syn keyword schemeGaucheExtFunc $->rope
    syn keyword schemeGaucheExtFunc $alternate
    syn keyword schemeGaucheExtFunc $between
    syn keyword schemeGaucheExtFunc $c
    syn keyword schemeGaucheExtFunc $chain-left
    syn keyword schemeGaucheExtFunc $chain-right
    syn keyword schemeGaucheExtFunc $char
    syn keyword schemeGaucheExtFunc $count
    syn keyword schemeGaucheExtFunc $end-by
    syn keyword schemeGaucheExtFunc $expect
    syn keyword schemeGaucheExtFunc $fail
    syn keyword schemeGaucheExtFunc $fold-parsers
    syn keyword schemeGaucheExtFunc $fold-parsers-right
    syn keyword schemeGaucheExtFunc $many
    syn keyword schemeGaucheExtFunc $many-till
    syn keyword schemeGaucheExtFunc $many1
    syn keyword schemeGaucheExtFunc $none-of
    syn keyword schemeGaucheExtFunc $not
    syn keyword schemeGaucheExtFunc $one-of
    syn keyword schemeGaucheExtFunc $optional
    syn keyword schemeGaucheExtFunc $repeat
    syn keyword schemeGaucheExtFunc $return
    syn keyword schemeGaucheExtFunc $s
    syn keyword schemeGaucheExtFunc $sep-by
    syn keyword schemeGaucheExtFunc $sep-end-by
    syn keyword schemeGaucheExtFunc $seq
    syn keyword schemeGaucheExtFunc $skip-many
    syn keyword schemeGaucheExtFunc $string
    syn keyword schemeGaucheExtFunc $string-ci
    syn keyword schemeGaucheExtFunc $try
    syn keyword schemeGaucheExtFunc $y
    syn keyword schemeGaucheExtFunc %add-load-path
    syn keyword schemeGaucheExtFunc %alist-delete
    syn keyword schemeGaucheExtFunc %alist-delete!
    syn keyword schemeGaucheExtFunc %autoload
    syn keyword schemeGaucheExtFunc %bignum-dump
    syn keyword schemeGaucheExtFunc %char-set-add!
    syn keyword schemeGaucheExtFunc %char-set-add-chars!
    syn keyword schemeGaucheExtFunc %char-set-add-range!
    syn keyword schemeGaucheExtFunc %char-set-complement!
    syn keyword schemeGaucheExtFunc %char-set-dump
    syn keyword schemeGaucheExtFunc %char-set-equal?
    syn keyword schemeGaucheExtFunc %char-set-predefined
    syn keyword schemeGaucheExtFunc %char-set-ranges
    syn keyword schemeGaucheExtFunc %char-set<=?
    syn keyword schemeGaucheExtFunc %check-class-binding
    syn keyword schemeGaucheExtFunc %default-signal-handler
    syn keyword schemeGaucheExtFunc %delete
    syn keyword schemeGaucheExtFunc %delete!
    syn keyword schemeGaucheExtFunc %delete-duplicates
    syn keyword schemeGaucheExtFunc %delete-duplicates!
    syn keyword schemeGaucheExtFunc %div&mod
    syn keyword schemeGaucheExtFunc %ensure-generic-function
    syn keyword schemeGaucheExtFunc %exact-integer-sqrt
    syn keyword schemeGaucheExtFunc %exit
    syn keyword schemeGaucheExtFunc %export-all
    syn keyword schemeGaucheExtFunc %extend-module
    syn keyword schemeGaucheExtFunc %format
    syn keyword schemeGaucheExtFunc %gauche-runtime-directory
    syn keyword schemeGaucheExtFunc %get-reader-ctor
    syn keyword schemeGaucheExtFunc %hash-string
    syn keyword schemeGaucheExtFunc %hash-table-iter
    syn keyword schemeGaucheExtFunc %let-keywords-rec
    syn keyword schemeGaucheExtFunc %make-sigset
    syn keyword schemeGaucheExtFunc %make-tree-map
    syn keyword schemeGaucheExtFunc %maybe-substring
    syn keyword schemeGaucheExtFunc %open-input-file
    syn keyword schemeGaucheExtFunc %open-input-file/conv
    syn keyword schemeGaucheExtFunc %open-output-file
    syn keyword schemeGaucheExtFunc %open-output-file/conv
    syn keyword schemeGaucheExtFunc %regexp-dump
    syn keyword schemeGaucheExtFunc %regexp-pattern
    syn keyword schemeGaucheExtFunc %regmatch-dump
    syn keyword schemeGaucheExtFunc %require
    syn keyword schemeGaucheExtFunc %sort
    syn keyword schemeGaucheExtFunc %sort!
    syn keyword schemeGaucheExtFunc %sparse-table-check
    syn keyword schemeGaucheExtFunc %sparse-table-dump
    syn keyword schemeGaucheExtFunc %sparse-vector-dump
    syn keyword schemeGaucheExtFunc %string-pointer-dump
    syn keyword schemeGaucheExtFunc %string-replace-body!
    syn keyword schemeGaucheExtFunc %string-split-by-char
    syn keyword schemeGaucheExtFunc %sys-escape-windows-command-line
    syn keyword schemeGaucheExtFunc %tree-map-bound
    syn keyword schemeGaucheExtFunc %tree-map-check-consistency
    syn keyword schemeGaucheExtFunc %tree-map-dump
    syn keyword schemeGaucheExtFunc %tree-map-iter
    syn keyword schemeGaucheExtFunc %uvector-ref
    syn keyword schemeGaucheExtFunc %vm-make-parameter-slot
    syn keyword schemeGaucheExtFunc %vm-parameter-ref
    syn keyword schemeGaucheExtFunc %vm-parameter-set!
    syn keyword schemeGaucheExtFunc %vm-show-stack-trace
    syn keyword schemeGaucheExtFunc %with-signal-handlers
    syn keyword schemeGaucheExtFunc *.
    syn keyword schemeGaucheExtFunc +.
    syn keyword schemeGaucheExtFunc -.
    syn keyword schemeGaucheExtFunc ->char-set
    syn keyword schemeGaucheExtFunc ->stream-char
    syn keyword schemeGaucheExtFunc .$
    syn keyword schemeGaucheExtFunc /.
    syn keyword schemeGaucheExtFunc G1144
    syn keyword schemeGaucheExtFunc G1145
    syn keyword schemeGaucheExtFunc G1150
    syn keyword schemeGaucheExtFunc G1153
    syn keyword schemeGaucheExtFunc G1157
    syn keyword schemeGaucheExtFunc G1158
    syn keyword schemeGaucheExtFunc G1212
    syn keyword schemeGaucheExtFunc G1213
    syn keyword schemeGaucheExtFunc G1214
    syn keyword schemeGaucheExtFunc G1215
    syn keyword schemeGaucheExtFunc G1217
    syn keyword schemeGaucheExtFunc G1219
    syn keyword schemeGaucheExtFunc G1220
    syn keyword schemeGaucheExtFunc G1221
    syn keyword schemeGaucheExtFunc G1222
    syn keyword schemeGaucheExtFunc G1223
    syn keyword schemeGaucheExtFunc G1224
    syn keyword schemeGaucheExtFunc G1596
    syn keyword schemeGaucheExtFunc G1597
    syn keyword schemeGaucheExtFunc G1598
    syn keyword schemeGaucheExtFunc G1599
    syn keyword schemeGaucheExtFunc G1600
    syn keyword schemeGaucheExtFunc G1601
    syn keyword schemeGaucheExtFunc G1602
    syn keyword schemeGaucheExtFunc G1603
    syn keyword schemeGaucheExtFunc G1604
    syn keyword schemeGaucheExtFunc G1605
    syn keyword schemeGaucheExtFunc G1606
    syn keyword schemeGaucheExtFunc G1624
    syn keyword schemeGaucheExtFunc G1625
    syn keyword schemeGaucheExtFunc G1626
    syn keyword schemeGaucheExtFunc G1627
    syn keyword schemeGaucheExtFunc G1628
    syn keyword schemeGaucheExtFunc G1629
    syn keyword schemeGaucheExtFunc G1630
    syn keyword schemeGaucheExtFunc G1631
    syn keyword schemeGaucheExtFunc G1632
    syn keyword schemeGaucheExtFunc G1633
    syn keyword schemeGaucheExtFunc G1634
    syn keyword schemeGaucheExtFunc G1652
    syn keyword schemeGaucheExtFunc G1653
    syn keyword schemeGaucheExtFunc G1654
    syn keyword schemeGaucheExtFunc G1655
    syn keyword schemeGaucheExtFunc G1656
    syn keyword schemeGaucheExtFunc G1657
    syn keyword schemeGaucheExtFunc G1658
    syn keyword schemeGaucheExtFunc G1659
    syn keyword schemeGaucheExtFunc G1660
    syn keyword schemeGaucheExtFunc G1661
    syn keyword schemeGaucheExtFunc G1662
    syn keyword schemeGaucheExtFunc G1680
    syn keyword schemeGaucheExtFunc G1681
    syn keyword schemeGaucheExtFunc G1682
    syn keyword schemeGaucheExtFunc G1683
    syn keyword schemeGaucheExtFunc G1684
    syn keyword schemeGaucheExtFunc G1685
    syn keyword schemeGaucheExtFunc G1686
    syn keyword schemeGaucheExtFunc G1687
    syn keyword schemeGaucheExtFunc G1688
    syn keyword schemeGaucheExtFunc G1689
    syn keyword schemeGaucheExtFunc G1690
    syn keyword schemeGaucheExtFunc G1708
    syn keyword schemeGaucheExtFunc G1709
    syn keyword schemeGaucheExtFunc G1710
    syn keyword schemeGaucheExtFunc G1711
    syn keyword schemeGaucheExtFunc G1712
    syn keyword schemeGaucheExtFunc G1713
    syn keyword schemeGaucheExtFunc G1714
    syn keyword schemeGaucheExtFunc G1715
    syn keyword schemeGaucheExtFunc G1716
    syn keyword schemeGaucheExtFunc G1717
    syn keyword schemeGaucheExtFunc G1718
    syn keyword schemeGaucheExtFunc G1736
    syn keyword schemeGaucheExtFunc G1737
    syn keyword schemeGaucheExtFunc G1738
    syn keyword schemeGaucheExtFunc G1739
    syn keyword schemeGaucheExtFunc G1740
    syn keyword schemeGaucheExtFunc G1741
    syn keyword schemeGaucheExtFunc G1742
    syn keyword schemeGaucheExtFunc G1743
    syn keyword schemeGaucheExtFunc G1744
    syn keyword schemeGaucheExtFunc G1745
    syn keyword schemeGaucheExtFunc G1746
    syn keyword schemeGaucheExtFunc G1764
    syn keyword schemeGaucheExtFunc G1765
    syn keyword schemeGaucheExtFunc G1766
    syn keyword schemeGaucheExtFunc G1767
    syn keyword schemeGaucheExtFunc G1768
    syn keyword schemeGaucheExtFunc G1769
    syn keyword schemeGaucheExtFunc G1770
    syn keyword schemeGaucheExtFunc G1771
    syn keyword schemeGaucheExtFunc G1772
    syn keyword schemeGaucheExtFunc G1773
    syn keyword schemeGaucheExtFunc G1774
    syn keyword schemeGaucheExtFunc G1792
    syn keyword schemeGaucheExtFunc G1793
    syn keyword schemeGaucheExtFunc G1794
    syn keyword schemeGaucheExtFunc G1795
    syn keyword schemeGaucheExtFunc G1796
    syn keyword schemeGaucheExtFunc G1797
    syn keyword schemeGaucheExtFunc G1798
    syn keyword schemeGaucheExtFunc G1799
    syn keyword schemeGaucheExtFunc G1800
    syn keyword schemeGaucheExtFunc G1801
    syn keyword schemeGaucheExtFunc G1802
    syn keyword schemeGaucheExtFunc G1820
    syn keyword schemeGaucheExtFunc G1821
    syn keyword schemeGaucheExtFunc G1822
    syn keyword schemeGaucheExtFunc G1823
    syn keyword schemeGaucheExtFunc G1824
    syn keyword schemeGaucheExtFunc G1825
    syn keyword schemeGaucheExtFunc G1826
    syn keyword schemeGaucheExtFunc G1827
    syn keyword schemeGaucheExtFunc G1828
    syn keyword schemeGaucheExtFunc G1829
    syn keyword schemeGaucheExtFunc G1830
    syn keyword schemeGaucheExtFunc G1848
    syn keyword schemeGaucheExtFunc G1849
    syn keyword schemeGaucheExtFunc G1850
    syn keyword schemeGaucheExtFunc G1851
    syn keyword schemeGaucheExtFunc G1852
    syn keyword schemeGaucheExtFunc G1853
    syn keyword schemeGaucheExtFunc G1854
    syn keyword schemeGaucheExtFunc G1855
    syn keyword schemeGaucheExtFunc G1856
    syn keyword schemeGaucheExtFunc G1857
    syn keyword schemeGaucheExtFunc G1858
    syn keyword schemeGaucheExtFunc G1876
    syn keyword schemeGaucheExtFunc G1877
    syn keyword schemeGaucheExtFunc G1878
    syn keyword schemeGaucheExtFunc G1879
    syn keyword schemeGaucheExtFunc G1880
    syn keyword schemeGaucheExtFunc G1881
    syn keyword schemeGaucheExtFunc G1882
    syn keyword schemeGaucheExtFunc G1883
    syn keyword schemeGaucheExtFunc G1884
    syn keyword schemeGaucheExtFunc G1885
    syn keyword schemeGaucheExtFunc G1886
    syn keyword schemeGaucheExtFunc G1888
    syn keyword schemeGaucheExtFunc G1890
    syn keyword schemeGaucheExtFunc G1892
    syn keyword schemeGaucheExtFunc G1894
    syn keyword schemeGaucheExtFunc G1896
    syn keyword schemeGaucheExtFunc G1898
    syn keyword schemeGaucheExtFunc G1900
    syn keyword schemeGaucheExtFunc G1902
    syn keyword schemeGaucheExtFunc SRV:send-reply
    syn keyword schemeGaucheExtFunc SSAX:XML->SXML
    syn keyword schemeGaucheExtFunc SXML->HTML
    syn keyword schemeGaucheExtFunc abandoned-mutex-exception?
    syn keyword schemeGaucheExtFunc absolute-path?
    syn keyword schemeGaucheExtFunc acons
    syn keyword schemeGaucheExtFunc acosh
    syn keyword schemeGaucheExtFunc add-duration
    syn keyword schemeGaucheExtFunc add-duration!
    syn keyword schemeGaucheExtFunc add-job!
    syn keyword schemeGaucheExtFunc alist->hash-table
    syn keyword schemeGaucheExtFunc alist->rbtree
    syn keyword schemeGaucheExtFunc alist->tree-map
    syn keyword schemeGaucheExtFunc alist-cons
    syn keyword schemeGaucheExtFunc alist-copy
    syn keyword schemeGaucheExtFunc alist-delete
    syn keyword schemeGaucheExtFunc alist-delete!
    syn keyword schemeGaucheExtFunc all-modules
    syn keyword schemeGaucheExtFunc all-tmodules
    syn keyword schemeGaucheExtFunc alphanum
    syn keyword schemeGaucheExtFunc any
    syn keyword schemeGaucheExtFunc any$
    syn keyword schemeGaucheExtFunc any-bits-set?
    syn keyword schemeGaucheExtFunc any-in-queue
    syn keyword schemeGaucheExtFunc any-pred
    syn keyword schemeGaucheExtFunc anychar
    syn keyword schemeGaucheExtFunc append!
    syn keyword schemeGaucheExtFunc append-map
    syn keyword schemeGaucheExtFunc append-map!
    syn keyword schemeGaucheExtFunc append-reverse
    syn keyword schemeGaucheExtFunc append-reverse!
    syn keyword schemeGaucheExtFunc apply$
    syn keyword schemeGaucheExtFunc args-fold
    syn keyword schemeGaucheExtFunc arithmetic-shift
    syn keyword schemeGaucheExtFunc arity
    syn keyword schemeGaucheExtFunc arity-at-least-value
    syn keyword schemeGaucheExtFunc arity-at-least?
    syn keyword schemeGaucheExtFunc array
    syn keyword schemeGaucheExtFunc array->list
    syn keyword schemeGaucheExtFunc array->vector
    syn keyword schemeGaucheExtFunc array-add-elements
    syn keyword schemeGaucheExtFunc array-any
    syn keyword schemeGaucheExtFunc array-concatenate
    syn keyword schemeGaucheExtFunc array-div-elements
    syn keyword schemeGaucheExtFunc array-div-left
    syn keyword schemeGaucheExtFunc array-div-right
    syn keyword schemeGaucheExtFunc array-end
    syn keyword schemeGaucheExtFunc array-equal?
    syn keyword schemeGaucheExtFunc array-every
    syn keyword schemeGaucheExtFunc array-expt
    syn keyword schemeGaucheExtFunc array-flip
    syn keyword schemeGaucheExtFunc array-flip!
    syn keyword schemeGaucheExtFunc array-for-each
    syn keyword schemeGaucheExtFunc array-for-each-index
    syn keyword schemeGaucheExtFunc array-for-each-index-by-dimension
    syn keyword schemeGaucheExtFunc array-inverse
    syn keyword schemeGaucheExtFunc array-length
    syn keyword schemeGaucheExtFunc array-mul
    syn keyword schemeGaucheExtFunc array-mul-elements
    syn keyword schemeGaucheExtFunc array-rank
    syn keyword schemeGaucheExtFunc array-rotate-90
    syn keyword schemeGaucheExtFunc array-shape
    syn keyword schemeGaucheExtFunc array-size
    syn keyword schemeGaucheExtFunc array-start
    syn keyword schemeGaucheExtFunc array-sub-elements
    syn keyword schemeGaucheExtFunc array-transpose
    syn keyword schemeGaucheExtFunc array-valid-index?
    syn keyword schemeGaucheExtFunc array?
    syn keyword schemeGaucheExtFunc as-nodeset
    syn keyword schemeGaucheExtFunc ascii->char
    syn keyword schemeGaucheExtFunc ash
    syn keyword schemeGaucheExtFunc asinh
    syn keyword schemeGaucheExtFunc assert-curr-char
    syn keyword schemeGaucheExtFunc assoc$
    syn keyword schemeGaucheExtFunc assoc-ref
    syn keyword schemeGaucheExtFunc assoc-set!
    syn keyword schemeGaucheExtFunc assq-ref
    syn keyword schemeGaucheExtFunc assq-set!
    syn keyword schemeGaucheExtFunc assq-values
    syn keyword schemeGaucheExtFunc assv-ref
    syn keyword schemeGaucheExtFunc assv-set!
    syn keyword schemeGaucheExtFunc atanh
    syn keyword schemeGaucheExtFunc atom
    syn keyword schemeGaucheExtFunc atom-ref
    syn keyword schemeGaucheExtFunc atom?
    syn keyword schemeGaucheExtFunc atomic
    syn keyword schemeGaucheExtFunc atomic-update!
    syn keyword schemeGaucheExtFunc attlist->alist
    syn keyword schemeGaucheExtFunc attlist-add
    syn keyword schemeGaucheExtFunc attlist-fold
    syn keyword schemeGaucheExtFunc attlist-null?
    syn keyword schemeGaucheExtFunc attlist-remove-top
    syn keyword schemeGaucheExtFunc base64-decode
    syn keyword schemeGaucheExtFunc base64-decode-string
    syn keyword schemeGaucheExtFunc base64-encode
    syn keyword schemeGaucheExtFunc base64-encode-string
    syn keyword schemeGaucheExtFunc bcrypt-gensalt
    syn keyword schemeGaucheExtFunc bcrypt-hashpw
    syn keyword schemeGaucheExtFunc bignum?
    syn keyword schemeGaucheExtFunc bimap-left
    syn keyword schemeGaucheExtFunc bimap-left-delete!
    syn keyword schemeGaucheExtFunc bimap-left-exists?
    syn keyword schemeGaucheExtFunc bimap-left-get
    syn keyword schemeGaucheExtFunc bimap-put!
    syn keyword schemeGaucheExtFunc bimap-right
    syn keyword schemeGaucheExtFunc bimap-right-delete!
    syn keyword schemeGaucheExtFunc bimap-right-exists?
    syn keyword schemeGaucheExtFunc bimap-right-get
    syn keyword schemeGaucheExtFunc bindtextdomain
    syn keyword schemeGaucheExtFunc bit-count
    syn keyword schemeGaucheExtFunc bit-field
    syn keyword schemeGaucheExtFunc bit-set?
    syn keyword schemeGaucheExtFunc bits->generator
    syn keyword schemeGaucheExtFunc bitwise-and
    syn keyword schemeGaucheExtFunc bitwise-if
    syn keyword schemeGaucheExtFunc bitwise-ior
    syn keyword schemeGaucheExtFunc bitwise-merge
    syn keyword schemeGaucheExtFunc bitwise-not
    syn keyword schemeGaucheExtFunc bitwise-xor
    syn keyword schemeGaucheExtFunc boolean
    syn keyword schemeGaucheExtFunc booleans->integer
    syn keyword schemeGaucheExtFunc break
    syn keyword schemeGaucheExtFunc break!
    syn keyword schemeGaucheExtFunc build-path
    syn keyword schemeGaucheExtFunc build-transliterator
    syn keyword schemeGaucheExtFunc byte-ready?
    syn keyword schemeGaucheExtFunc byte-substring
    syn keyword schemeGaucheExtFunc call-with-cgi-script
    syn keyword schemeGaucheExtFunc call-with-client-socket
    syn keyword schemeGaucheExtFunc call-with-ftp-connection
    syn keyword schemeGaucheExtFunc call-with-input-conversion
    syn keyword schemeGaucheExtFunc call-with-input-process
    syn keyword schemeGaucheExtFunc call-with-input-string
    syn keyword schemeGaucheExtFunc call-with-iterators
    syn keyword schemeGaucheExtFunc call-with-output-conversion
    syn keyword schemeGaucheExtFunc call-with-output-process
    syn keyword schemeGaucheExtFunc call-with-output-string
    syn keyword schemeGaucheExtFunc call-with-process-io
    syn keyword schemeGaucheExtFunc call-with-string-io
    syn keyword schemeGaucheExtFunc call/pc
    syn keyword schemeGaucheExtFunc canonical-path
    syn keyword schemeGaucheExtFunc car+cdr
    syn keyword schemeGaucheExtFunc car-sxpath
    syn keyword schemeGaucheExtFunc cartesian-product
    syn keyword schemeGaucheExtFunc cartesian-product-for-each
    syn keyword schemeGaucheExtFunc cartesian-product-right
    syn keyword schemeGaucheExtFunc cartesian-product-right-for-each
    syn keyword schemeGaucheExtFunc ceiling->exact
    syn keyword schemeGaucheExtFunc cerr
    syn keyword schemeGaucheExtFunc ces-conversion-supported?
    syn keyword schemeGaucheExtFunc ces-convert
    syn keyword schemeGaucheExtFunc ces-equivalent?
    syn keyword schemeGaucheExtFunc ces-guess-from-string
    syn keyword schemeGaucheExtFunc ces-upper-compatible?
    syn keyword schemeGaucheExtFunc cgen-add!
    syn keyword schemeGaucheExtFunc cgen-allocate-static-datum
    syn keyword schemeGaucheExtFunc cgen-body
    syn keyword schemeGaucheExtFunc cgen-box-expr
    syn keyword schemeGaucheExtFunc cgen-cpp-conditions
    syn keyword schemeGaucheExtFunc cgen-decl
    syn keyword schemeGaucheExtFunc cgen-define
    syn keyword schemeGaucheExtFunc cgen-extern
    syn keyword schemeGaucheExtFunc cgen-genstub
    syn keyword schemeGaucheExtFunc cgen-include
    syn keyword schemeGaucheExtFunc cgen-init
    syn keyword schemeGaucheExtFunc cgen-literal
    syn keyword schemeGaucheExtFunc cgen-precompile
    syn keyword schemeGaucheExtFunc cgen-precompile-multi
    syn keyword schemeGaucheExtFunc cgen-pred-expr
    syn keyword schemeGaucheExtFunc cgen-return-stmt
    syn keyword schemeGaucheExtFunc cgen-safe-comment
    syn keyword schemeGaucheExtFunc cgen-safe-name
    syn keyword schemeGaucheExtFunc cgen-safe-name-friendly
    syn keyword schemeGaucheExtFunc cgen-stub-parse-form
    syn keyword schemeGaucheExtFunc cgen-stub-parser
    syn keyword schemeGaucheExtFunc cgen-type-from-name
    syn keyword schemeGaucheExtFunc cgen-unbox-expr
    syn keyword schemeGaucheExtFunc cgi-add-temporary-file
    syn keyword schemeGaucheExtFunc cgi-get-metavariable
    syn keyword schemeGaucheExtFunc cgi-get-parameter
    syn keyword schemeGaucheExtFunc cgi-header
    syn keyword schemeGaucheExtFunc cgi-main
    syn keyword schemeGaucheExtFunc cgi-parse-parameters
    syn keyword schemeGaucheExtFunc cgi-test-environment-ref
    syn keyword schemeGaucheExtFunc change-object-class
    syn keyword schemeGaucheExtFunc char->ucs
    syn keyword schemeGaucheExtFunc char-foldcase
    syn keyword schemeGaucheExtFunc char-general-category
    syn keyword schemeGaucheExtFunc char-set
    syn keyword schemeGaucheExtFunc char-set->list
    syn keyword schemeGaucheExtFunc char-set->string
    syn keyword schemeGaucheExtFunc char-set-adjoin
    syn keyword schemeGaucheExtFunc char-set-adjoin!
    syn keyword schemeGaucheExtFunc char-set-any
    syn keyword schemeGaucheExtFunc char-set-complement
    syn keyword schemeGaucheExtFunc char-set-complement!
    syn keyword schemeGaucheExtFunc char-set-contains?
    syn keyword schemeGaucheExtFunc char-set-copy
    syn keyword schemeGaucheExtFunc char-set-count
    syn keyword schemeGaucheExtFunc char-set-cursor
    syn keyword schemeGaucheExtFunc char-set-cursor-next
    syn keyword schemeGaucheExtFunc char-set-delete
    syn keyword schemeGaucheExtFunc char-set-delete!
    syn keyword schemeGaucheExtFunc char-set-diff+intersection
    syn keyword schemeGaucheExtFunc char-set-diff+intersection!
    syn keyword schemeGaucheExtFunc char-set-difference
    syn keyword schemeGaucheExtFunc char-set-difference!
    syn keyword schemeGaucheExtFunc char-set-every
    syn keyword schemeGaucheExtFunc char-set-filter
    syn keyword schemeGaucheExtFunc char-set-filter!
    syn keyword schemeGaucheExtFunc char-set-fold
    syn keyword schemeGaucheExtFunc char-set-for-each
    syn keyword schemeGaucheExtFunc char-set-hash
    syn keyword schemeGaucheExtFunc char-set-intersection
    syn keyword schemeGaucheExtFunc char-set-intersection!
    syn keyword schemeGaucheExtFunc char-set-map
    syn keyword schemeGaucheExtFunc char-set-ref
    syn keyword schemeGaucheExtFunc char-set-size
    syn keyword schemeGaucheExtFunc char-set-unfold
    syn keyword schemeGaucheExtFunc char-set-unfold!
    syn keyword schemeGaucheExtFunc char-set-union
    syn keyword schemeGaucheExtFunc char-set-union!
    syn keyword schemeGaucheExtFunc char-set-xor
    syn keyword schemeGaucheExtFunc char-set-xor!
    syn keyword schemeGaucheExtFunc char-set<=
    syn keyword schemeGaucheExtFunc char-set=
    syn keyword schemeGaucheExtFunc char-set?
    syn keyword schemeGaucheExtFunc char-title-case?
    syn keyword schemeGaucheExtFunc char-titlecase
    syn keyword schemeGaucheExtFunc chdir
    syn keyword schemeGaucheExtFunc check-directory-tree
    syn keyword schemeGaucheExtFunc check-substring-spec
    syn keyword schemeGaucheExtFunc circular-generator
    syn keyword schemeGaucheExtFunc circular-list
    syn keyword schemeGaucheExtFunc circular-list?
    syn keyword schemeGaucheExtFunc cise-context-copy
    syn keyword schemeGaucheExtFunc cise-lookup-macro
    syn keyword schemeGaucheExtFunc cise-register-macro!
    syn keyword schemeGaucheExtFunc cise-render
    syn keyword schemeGaucheExtFunc cise-render-rec
    syn keyword schemeGaucheExtFunc cise-render-to-string
    syn keyword schemeGaucheExtFunc cise-translate
    syn keyword schemeGaucheExtFunc clamp
    syn keyword schemeGaucheExtFunc class-direct-methods
    syn keyword schemeGaucheExtFunc class-direct-slots
    syn keyword schemeGaucheExtFunc class-direct-subclasses
    syn keyword schemeGaucheExtFunc class-direct-supers
    syn keyword schemeGaucheExtFunc class-name
    syn keyword schemeGaucheExtFunc class-of
    syn keyword schemeGaucheExtFunc class-precedence-list
    syn keyword schemeGaucheExtFunc class-slot-accessor
    syn keyword schemeGaucheExtFunc class-slot-bound?
    syn keyword schemeGaucheExtFunc class-slot-definition
    syn keyword schemeGaucheExtFunc class-slot-ref
    syn keyword schemeGaucheExtFunc class-slot-set!
    syn keyword schemeGaucheExtFunc class-slots
    syn keyword schemeGaucheExtFunc closure-code
    syn keyword schemeGaucheExtFunc closure?
    syn keyword schemeGaucheExtFunc codepoints->grapheme-clusters
    syn keyword schemeGaucheExtFunc codepoints->words
    syn keyword schemeGaucheExtFunc codepoints-downcase
    syn keyword schemeGaucheExtFunc codepoints-foldcase
    syn keyword schemeGaucheExtFunc codepoints-titlecase
    syn keyword schemeGaucheExtFunc codepoints-upcase
    syn keyword schemeGaucheExtFunc combinations
    syn keyword schemeGaucheExtFunc combinations*
    syn keyword schemeGaucheExtFunc combinations*-for-each
    syn keyword schemeGaucheExtFunc combinations-for-each
    syn keyword schemeGaucheExtFunc compare
    syn keyword schemeGaucheExtFunc complement
    syn keyword schemeGaucheExtFunc complete-sexp?
    syn keyword schemeGaucheExtFunc compose
    syn keyword schemeGaucheExtFunc concatenate
    syn keyword schemeGaucheExtFunc concatenate!
    syn keyword schemeGaucheExtFunc condition-has-type?
    syn keyword schemeGaucheExtFunc condition-ref
    syn keyword schemeGaucheExtFunc condition-type?
    syn keyword schemeGaucheExtFunc condition-variable-broadcast!
    syn keyword schemeGaucheExtFunc condition-variable-name
    syn keyword schemeGaucheExtFunc condition-variable-signal!
    syn keyword schemeGaucheExtFunc condition-variable-specific
    syn keyword schemeGaucheExtFunc condition-variable-specific-set!
    syn keyword schemeGaucheExtFunc condition-variable?
    syn keyword schemeGaucheExtFunc condition?
    syn keyword schemeGaucheExtFunc cons*
    syn keyword schemeGaucheExtFunc console-device
    syn keyword schemeGaucheExtFunc construct-cookie-string
    syn keyword schemeGaucheExtFunc construct-json
    syn keyword schemeGaucheExtFunc construct-json-string
    syn keyword schemeGaucheExtFunc copy-bit
    syn keyword schemeGaucheExtFunc copy-bit-field
    syn keyword schemeGaucheExtFunc copy-directory*
    syn keyword schemeGaucheExtFunc copy-file
    syn keyword schemeGaucheExtFunc copy-port
    syn keyword schemeGaucheExtFunc copy-time
    syn keyword schemeGaucheExtFunc cosh
    syn keyword schemeGaucheExtFunc count
    syn keyword schemeGaucheExtFunc count$
    syn keyword schemeGaucheExtFunc cout
    syn keyword schemeGaucheExtFunc create-directory*
    syn keyword schemeGaucheExtFunc create-directory-tree
    syn keyword schemeGaucheExtFunc current-class-of
    syn keyword schemeGaucheExtFunc current-date
    syn keyword schemeGaucheExtFunc current-directory
    syn keyword schemeGaucheExtFunc current-error-port
    syn keyword schemeGaucheExtFunc current-exception-handler
    syn keyword schemeGaucheExtFunc current-julian-day
    syn keyword schemeGaucheExtFunc current-load-history
    syn keyword schemeGaucheExtFunc current-load-next
    syn keyword schemeGaucheExtFunc current-load-path
    syn keyword schemeGaucheExtFunc current-load-port
    syn keyword schemeGaucheExtFunc current-microseconds
    syn keyword schemeGaucheExtFunc current-modified-julian-day
    syn keyword schemeGaucheExtFunc current-thread
    syn keyword schemeGaucheExtFunc current-time
    syn keyword schemeGaucheExtFunc current-tmodule
    syn keyword schemeGaucheExtFunc current-tmodule-cname
    syn keyword schemeGaucheExtFunc cv-file
    syn keyword schemeGaucheExtFunc cv-string
    syn keyword schemeGaucheExtFunc date->julian-day
    syn keyword schemeGaucheExtFunc date->modified-julian-day
    syn keyword schemeGaucheExtFunc date->rfc822-date
    syn keyword schemeGaucheExtFunc date->string
    syn keyword schemeGaucheExtFunc date->time-monotonic
    syn keyword schemeGaucheExtFunc date->time-tai
    syn keyword schemeGaucheExtFunc date->time-utc
    syn keyword schemeGaucheExtFunc date-week-day
    syn keyword schemeGaucheExtFunc date-week-number
    syn keyword schemeGaucheExtFunc date-year-day
    syn keyword schemeGaucheExtFunc date?
    syn keyword schemeGaucheExtFunc dbi-connect
    syn keyword schemeGaucheExtFunc dbi-list-drivers
    syn keyword schemeGaucheExtFunc dbi-make-driver
    syn keyword schemeGaucheExtFunc dbi-parse-dsn
    syn keyword schemeGaucheExtFunc dbi-prepare-sql
    syn keyword schemeGaucheExtFunc dbm-type->class
    syn keyword schemeGaucheExtFunc dcgettext
    syn keyword schemeGaucheExtFunc debug-source-info
    syn keyword schemeGaucheExtFunc declare-bundle!
    syn keyword schemeGaucheExtFunc decode-float
    syn keyword schemeGaucheExtFunc decompose-path
    syn keyword schemeGaucheExtFunc default-endian
    syn keyword schemeGaucheExtFunc define-reader-ctor
    syn keyword schemeGaucheExtFunc define-reader-directive
    syn keyword schemeGaucheExtFunc delete
    syn keyword schemeGaucheExtFunc delete!
    syn keyword schemeGaucheExtFunc delete$
    syn keyword schemeGaucheExtFunc delete-directory*
    syn keyword schemeGaucheExtFunc delete-duplicates
    syn keyword schemeGaucheExtFunc delete-duplicates!
    syn keyword schemeGaucheExtFunc delete-files
    syn keyword schemeGaucheExtFunc delete-keyword
    syn keyword schemeGaucheExtFunc delete-keyword!
    syn keyword schemeGaucheExtFunc delete-keywords
    syn keyword schemeGaucheExtFunc delete-keywords!
    syn keyword schemeGaucheExtFunc dequeue!
    syn keyword schemeGaucheExtFunc dequeue-all!
    syn keyword schemeGaucheExtFunc dequeue/wait!
    syn keyword schemeGaucheExtFunc describe-fstruct-type
    syn keyword schemeGaucheExtFunc determinant
    syn keyword schemeGaucheExtFunc determinant!
    syn keyword schemeGaucheExtFunc dgettext
    syn keyword schemeGaucheExtFunc diff
    syn keyword schemeGaucheExtFunc diff-report
    syn keyword schemeGaucheExtFunc digest-hexify
    syn keyword schemeGaucheExtFunc digit
    syn keyword schemeGaucheExtFunc digit->integer
    syn keyword schemeGaucheExtFunc directory-fold
    syn keyword schemeGaucheExtFunc directory-list
    syn keyword schemeGaucheExtFunc directory-list2
    syn keyword schemeGaucheExtFunc disasm
    syn keyword schemeGaucheExtFunc dispatch-union
    syn keyword schemeGaucheExtFunc dotted-list?
    syn keyword schemeGaucheExtFunc drop
    syn keyword schemeGaucheExtFunc drop*
    syn keyword schemeGaucheExtFunc drop-right
    syn keyword schemeGaucheExtFunc drop-right!
    syn keyword schemeGaucheExtFunc drop-right*
    syn keyword schemeGaucheExtFunc drop-while
    syn keyword schemeGaucheExtFunc dynamic-load
    syn keyword schemeGaucheExtFunc eager
    syn keyword schemeGaucheExtFunc ec-:vector-filter
    syn keyword schemeGaucheExtFunc eighth
    syn keyword schemeGaucheExtFunc end-of-char-set?
    syn keyword schemeGaucheExtFunc enqueue!
    syn keyword schemeGaucheExtFunc enqueue-unique!
    syn keyword schemeGaucheExtFunc enqueue/wait!
    syn keyword schemeGaucheExtFunc eof
    syn keyword schemeGaucheExtFunc eof-object
    syn keyword schemeGaucheExtFunc eq-hash
    syn keyword schemeGaucheExtFunc eqv-hash
    syn keyword schemeGaucheExtFunc error
    syn keyword schemeGaucheExtFunc errorf
    syn keyword schemeGaucheExtFunc every
    syn keyword schemeGaucheExtFunc every$
    syn keyword schemeGaucheExtFunc every-in-queue
    syn keyword schemeGaucheExtFunc every-pred
    syn keyword schemeGaucheExtFunc exit
    syn keyword schemeGaucheExtFunc exit-handler
    syn keyword schemeGaucheExtFunc expand-file-name
    syn keyword schemeGaucheExtFunc expand-path
    syn keyword schemeGaucheExtFunc extract-condition
    syn keyword schemeGaucheExtFunc f16vector
    syn keyword schemeGaucheExtFunc f16vector->list
    syn keyword schemeGaucheExtFunc f16vector->vector
    syn keyword schemeGaucheExtFunc f16vector-add
    syn keyword schemeGaucheExtFunc f16vector-add!
    syn keyword schemeGaucheExtFunc f16vector-clamp
    syn keyword schemeGaucheExtFunc f16vector-clamp!
    syn keyword schemeGaucheExtFunc f16vector-copy
    syn keyword schemeGaucheExtFunc f16vector-copy!
    syn keyword schemeGaucheExtFunc f16vector-div
    syn keyword schemeGaucheExtFunc f16vector-div!
    syn keyword schemeGaucheExtFunc f16vector-dot
    syn keyword schemeGaucheExtFunc f16vector-fill!
    syn keyword schemeGaucheExtFunc f16vector-length
    syn keyword schemeGaucheExtFunc f16vector-mul
    syn keyword schemeGaucheExtFunc f16vector-mul!
    syn keyword schemeGaucheExtFunc f16vector-range-check
    syn keyword schemeGaucheExtFunc f16vector-ref
    syn keyword schemeGaucheExtFunc f16vector-set!
    syn keyword schemeGaucheExtFunc f16vector-sub
    syn keyword schemeGaucheExtFunc f16vector-sub!
    syn keyword schemeGaucheExtFunc f16vector-swap-bytes
    syn keyword schemeGaucheExtFunc f16vector-swap-bytes!
    syn keyword schemeGaucheExtFunc f16vector?
    syn keyword schemeGaucheExtFunc f32vector
    syn keyword schemeGaucheExtFunc f32vector->list
    syn keyword schemeGaucheExtFunc f32vector->vector
    syn keyword schemeGaucheExtFunc f32vector-add
    syn keyword schemeGaucheExtFunc f32vector-add!
    syn keyword schemeGaucheExtFunc f32vector-clamp
    syn keyword schemeGaucheExtFunc f32vector-clamp!
    syn keyword schemeGaucheExtFunc f32vector-copy
    syn keyword schemeGaucheExtFunc f32vector-copy!
    syn keyword schemeGaucheExtFunc f32vector-div
    syn keyword schemeGaucheExtFunc f32vector-div!
    syn keyword schemeGaucheExtFunc f32vector-dot
    syn keyword schemeGaucheExtFunc f32vector-fill!
    syn keyword schemeGaucheExtFunc f32vector-length
    syn keyword schemeGaucheExtFunc f32vector-mul
    syn keyword schemeGaucheExtFunc f32vector-mul!
    syn keyword schemeGaucheExtFunc f32vector-range-check
    syn keyword schemeGaucheExtFunc f32vector-ref
    syn keyword schemeGaucheExtFunc f32vector-set!
    syn keyword schemeGaucheExtFunc f32vector-sub
    syn keyword schemeGaucheExtFunc f32vector-sub!
    syn keyword schemeGaucheExtFunc f32vector-swap-bytes
    syn keyword schemeGaucheExtFunc f32vector-swap-bytes!
    syn keyword schemeGaucheExtFunc f32vector?
    syn keyword schemeGaucheExtFunc f64vector
    syn keyword schemeGaucheExtFunc f64vector->list
    syn keyword schemeGaucheExtFunc f64vector->vector
    syn keyword schemeGaucheExtFunc f64vector-add
    syn keyword schemeGaucheExtFunc f64vector-add!
    syn keyword schemeGaucheExtFunc f64vector-clamp
    syn keyword schemeGaucheExtFunc f64vector-clamp!
    syn keyword schemeGaucheExtFunc f64vector-copy
    syn keyword schemeGaucheExtFunc f64vector-copy!
    syn keyword schemeGaucheExtFunc f64vector-div
    syn keyword schemeGaucheExtFunc f64vector-div!
    syn keyword schemeGaucheExtFunc f64vector-dot
    syn keyword schemeGaucheExtFunc f64vector-fill!
    syn keyword schemeGaucheExtFunc f64vector-length
    syn keyword schemeGaucheExtFunc f64vector-mul
    syn keyword schemeGaucheExtFunc f64vector-mul!
    syn keyword schemeGaucheExtFunc f64vector-range-check
    syn keyword schemeGaucheExtFunc f64vector-ref
    syn keyword schemeGaucheExtFunc f64vector-set!
    syn keyword schemeGaucheExtFunc f64vector-sub
    syn keyword schemeGaucheExtFunc f64vector-sub!
    syn keyword schemeGaucheExtFunc f64vector-swap-bytes
    syn keyword schemeGaucheExtFunc f64vector-swap-bytes!
    syn keyword schemeGaucheExtFunc f64vector?
    syn keyword schemeGaucheExtFunc fifth
    syn keyword schemeGaucheExtFunc file->byte-generator
    syn keyword schemeGaucheExtFunc file->char-generator
    syn keyword schemeGaucheExtFunc file->generator
    syn keyword schemeGaucheExtFunc file->line-generator
    syn keyword schemeGaucheExtFunc file->list
    syn keyword schemeGaucheExtFunc file->sexp-generator
    syn keyword schemeGaucheExtFunc file->sexp-list
    syn keyword schemeGaucheExtFunc file->string
    syn keyword schemeGaucheExtFunc file->string-list
    syn keyword schemeGaucheExtFunc file-atime
    syn keyword schemeGaucheExtFunc file-ctime
    syn keyword schemeGaucheExtFunc file-dev
    syn keyword schemeGaucheExtFunc file-device=?
    syn keyword schemeGaucheExtFunc file-eq?
    syn keyword schemeGaucheExtFunc file-equal?
    syn keyword schemeGaucheExtFunc file-eqv?
    syn keyword schemeGaucheExtFunc file-exists?
    syn keyword schemeGaucheExtFunc file-filter
    syn keyword schemeGaucheExtFunc file-gid
    syn keyword schemeGaucheExtFunc file-ino
    syn keyword schemeGaucheExtFunc file-is-directory?
    syn keyword schemeGaucheExtFunc file-is-executable?
    syn keyword schemeGaucheExtFunc file-is-readable?
    syn keyword schemeGaucheExtFunc file-is-regular?
    syn keyword schemeGaucheExtFunc file-is-symlink?
    syn keyword schemeGaucheExtFunc file-is-writable?
    syn keyword schemeGaucheExtFunc file-mode
    syn keyword schemeGaucheExtFunc file-mtime
    syn keyword schemeGaucheExtFunc file-nlink
    syn keyword schemeGaucheExtFunc file-perm
    syn keyword schemeGaucheExtFunc file-rdev
    syn keyword schemeGaucheExtFunc file-size
    syn keyword schemeGaucheExtFunc file-type
    syn keyword schemeGaucheExtFunc file-uid
    syn keyword schemeGaucheExtFunc filter
    syn keyword schemeGaucheExtFunc filter!
    syn keyword schemeGaucheExtFunc filter$
    syn keyword schemeGaucheExtFunc filter-map
    syn keyword schemeGaucheExtFunc find
    syn keyword schemeGaucheExtFunc find$
    syn keyword schemeGaucheExtFunc find-file-in-paths
    syn keyword schemeGaucheExtFunc find-gauche-package-description
    syn keyword schemeGaucheExtFunc find-in-queue
    syn keyword schemeGaucheExtFunc find-module
    syn keyword schemeGaucheExtFunc find-string-from-port?
    syn keyword schemeGaucheExtFunc find-tail
    syn keyword schemeGaucheExtFunc find-tail$
    syn keyword schemeGaucheExtFunc find-tmodule
    syn keyword schemeGaucheExtFunc finite?
    syn keyword schemeGaucheExtFunc first
    syn keyword schemeGaucheExtFunc first-set-bit
    syn keyword schemeGaucheExtFunc fixnum-width
    syn keyword schemeGaucheExtFunc fixnum?
    syn keyword schemeGaucheExtFunc flonum?
    syn keyword schemeGaucheExtFunc floor->exact
    syn keyword schemeGaucheExtFunc flush
    syn keyword schemeGaucheExtFunc flush-all-ports
    syn keyword schemeGaucheExtFunc fmod
    syn keyword schemeGaucheExtFunc fobject-copy
    syn keyword schemeGaucheExtFunc fobject-copy!
    syn keyword schemeGaucheExtFunc fobject-copy!/uv
    syn keyword schemeGaucheExtFunc fobject-offset
    syn keyword schemeGaucheExtFunc fobject-ref
    syn keyword schemeGaucheExtFunc fobject-ref/uv
    syn keyword schemeGaucheExtFunc fobject-set!
    syn keyword schemeGaucheExtFunc fobject-set!/uv
    syn keyword schemeGaucheExtFunc fobject-storage
    syn keyword schemeGaucheExtFunc fobject-type
    syn keyword schemeGaucheExtFunc fobject?
    syn keyword schemeGaucheExtFunc fold
    syn keyword schemeGaucheExtFunc fold-right
    syn keyword schemeGaucheExtFunc fold-right$
    syn keyword schemeGaucheExtFunc foldts
    syn keyword schemeGaucheExtFunc for-each$
    syn keyword schemeGaucheExtFunc foreign-pointer-attribute-get
    syn keyword schemeGaucheExtFunc foreign-pointer-attribute-set
    syn keyword schemeGaucheExtFunc foreign-pointer-attributes
    syn keyword schemeGaucheExtFunc format
    syn keyword schemeGaucheExtFunc format/ss
    syn keyword schemeGaucheExtFunc fourth
    syn keyword schemeGaucheExtFunc frexp
    syn keyword schemeGaucheExtFunc ftp-chdir
    syn keyword schemeGaucheExtFunc ftp-current-directory
    syn keyword schemeGaucheExtFunc ftp-get
    syn keyword schemeGaucheExtFunc ftp-help
    syn keyword schemeGaucheExtFunc ftp-list
    syn keyword schemeGaucheExtFunc ftp-login
    syn keyword schemeGaucheExtFunc ftp-ls
    syn keyword schemeGaucheExtFunc ftp-mdtm
    syn keyword schemeGaucheExtFunc ftp-mkdir
    syn keyword schemeGaucheExtFunc ftp-mtime
    syn keyword schemeGaucheExtFunc ftp-name-list
    syn keyword schemeGaucheExtFunc ftp-noop
    syn keyword schemeGaucheExtFunc ftp-put
    syn keyword schemeGaucheExtFunc ftp-put-unique
    syn keyword schemeGaucheExtFunc ftp-quit
    syn keyword schemeGaucheExtFunc ftp-remove
    syn keyword schemeGaucheExtFunc ftp-rename
    syn keyword schemeGaucheExtFunc ftp-rmdir
    syn keyword schemeGaucheExtFunc ftp-site
    syn keyword schemeGaucheExtFunc ftp-size
    syn keyword schemeGaucheExtFunc ftp-stat
    syn keyword schemeGaucheExtFunc ftp-system
    syn keyword schemeGaucheExtFunc ftype-alignment
    syn keyword schemeGaucheExtFunc ftype-endian
    syn keyword schemeGaucheExtFunc ftype-getter
    syn keyword schemeGaucheExtFunc ftype-name
    syn keyword schemeGaucheExtFunc ftype-putter
    syn keyword schemeGaucheExtFunc ftype-size
    syn keyword schemeGaucheExtFunc ftype:slot-name
    syn keyword schemeGaucheExtFunc ftype:slot-position
    syn keyword schemeGaucheExtFunc ftype:slot-type
    syn keyword schemeGaucheExtFunc ftype:struct-slots
    syn keyword schemeGaucheExtFunc gappend
    syn keyword schemeGaucheExtFunc gauche-architecture
    syn keyword schemeGaucheExtFunc gauche-architecture-directory
    syn keyword schemeGaucheExtFunc gauche-character-encoding
    syn keyword schemeGaucheExtFunc gauche-config
    syn keyword schemeGaucheExtFunc gauche-dso-suffix
    syn keyword schemeGaucheExtFunc gauche-library-directory
    syn keyword schemeGaucheExtFunc gauche-package-build
    syn keyword schemeGaucheExtFunc gauche-package-clean
    syn keyword schemeGaucheExtFunc gauche-package-compile
    syn keyword schemeGaucheExtFunc gauche-package-compile-and-link
    syn keyword schemeGaucheExtFunc gauche-package-description-paths
    syn keyword schemeGaucheExtFunc gauche-package-ensure
    syn keyword schemeGaucheExtFunc gauche-package-link
    syn keyword schemeGaucheExtFunc gauche-site-architecture-directory
    syn keyword schemeGaucheExtFunc gauche-site-library-directory
    syn keyword schemeGaucheExtFunc gauche-thread-type
    syn keyword schemeGaucheExtFunc gauche-version
    syn keyword schemeGaucheExtFunc gc
    syn keyword schemeGaucheExtFunc gc-stat
    syn keyword schemeGaucheExtFunc gcons
    syn keyword schemeGaucheExtFunc gdrop
    syn keyword schemeGaucheExtFunc gdrop-while
    syn keyword schemeGaucheExtFunc generator->list
    syn keyword schemeGaucheExtFunc gensym
    syn keyword schemeGaucheExtFunc get-environment-variable
    syn keyword schemeGaucheExtFunc get-environment-variables
    syn keyword schemeGaucheExtFunc get-f16
    syn keyword schemeGaucheExtFunc get-f16be
    syn keyword schemeGaucheExtFunc get-f16le
    syn keyword schemeGaucheExtFunc get-f32
    syn keyword schemeGaucheExtFunc get-f32be
    syn keyword schemeGaucheExtFunc get-f32le
    syn keyword schemeGaucheExtFunc get-f64
    syn keyword schemeGaucheExtFunc get-f64be
    syn keyword schemeGaucheExtFunc get-f64le
    syn keyword schemeGaucheExtFunc get-fobject
    syn keyword schemeGaucheExtFunc get-keyword
    syn keyword schemeGaucheExtFunc get-output-byte-string
    syn keyword schemeGaucheExtFunc get-output-string
    syn keyword schemeGaucheExtFunc get-password
    syn keyword schemeGaucheExtFunc get-remaining-input-string
    syn keyword schemeGaucheExtFunc get-s16
    syn keyword schemeGaucheExtFunc get-s16be
    syn keyword schemeGaucheExtFunc get-s16le
    syn keyword schemeGaucheExtFunc get-s32
    syn keyword schemeGaucheExtFunc get-s32be
    syn keyword schemeGaucheExtFunc get-s32le
    syn keyword schemeGaucheExtFunc get-s64
    syn keyword schemeGaucheExtFunc get-s64be
    syn keyword schemeGaucheExtFunc get-s64le
    syn keyword schemeGaucheExtFunc get-s8
    syn keyword schemeGaucheExtFunc get-signal-handler
    syn keyword schemeGaucheExtFunc get-signal-handler-mask
    syn keyword schemeGaucheExtFunc get-signal-handlers
    syn keyword schemeGaucheExtFunc get-signal-pending-limit
    syn keyword schemeGaucheExtFunc get-u16
    syn keyword schemeGaucheExtFunc get-u16be
    syn keyword schemeGaucheExtFunc get-u16le
    syn keyword schemeGaucheExtFunc get-u32
    syn keyword schemeGaucheExtFunc get-u32be
    syn keyword schemeGaucheExtFunc get-u32le
    syn keyword schemeGaucheExtFunc get-u64
    syn keyword schemeGaucheExtFunc get-u64be
    syn keyword schemeGaucheExtFunc get-u64le
    syn keyword schemeGaucheExtFunc get-u8
    syn keyword schemeGaucheExtFunc getcwd
    syn keyword schemeGaucheExtFunc getenv
    syn keyword schemeGaucheExtFunc getpid
    syn keyword schemeGaucheExtFunc getter-with-setter
    syn keyword schemeGaucheExtFunc gettext
    syn keyword schemeGaucheExtFunc gfilter
    syn keyword schemeGaucheExtFunc giota
    syn keyword schemeGaucheExtFunc glob
    syn keyword schemeGaucheExtFunc glob-component->regexp
    syn keyword schemeGaucheExtFunc glob-fold
    syn keyword schemeGaucheExtFunc global-variable-bound?
    syn keyword schemeGaucheExtFunc global-variable-ref
    syn keyword schemeGaucheExtFunc gmap
    syn keyword schemeGaucheExtFunc greatest-fixnum
    syn keyword schemeGaucheExtFunc gtake
    syn keyword schemeGaucheExtFunc gtake-while
    syn keyword schemeGaucheExtFunc gunfold
    syn keyword schemeGaucheExtFunc has-setter?
    syn keyword schemeGaucheExtFunc hash
    syn keyword schemeGaucheExtFunc hash-table
    syn keyword schemeGaucheExtFunc hash-table->alist
    syn keyword schemeGaucheExtFunc hash-table-clear!
    syn keyword schemeGaucheExtFunc hash-table-copy
    syn keyword schemeGaucheExtFunc hash-table-delete!
    syn keyword schemeGaucheExtFunc hash-table-exists?
    syn keyword schemeGaucheExtFunc hash-table-fold
    syn keyword schemeGaucheExtFunc hash-table-for-each
    syn keyword schemeGaucheExtFunc hash-table-get
    syn keyword schemeGaucheExtFunc hash-table-keys
    syn keyword schemeGaucheExtFunc hash-table-map
    syn keyword schemeGaucheExtFunc hash-table-num-entries
    syn keyword schemeGaucheExtFunc hash-table-pop!
    syn keyword schemeGaucheExtFunc hash-table-push!
    syn keyword schemeGaucheExtFunc hash-table-put!
    syn keyword schemeGaucheExtFunc hash-table-stat
    syn keyword schemeGaucheExtFunc hash-table-type
    syn keyword schemeGaucheExtFunc hash-table-update!
    syn keyword schemeGaucheExtFunc hash-table-values
    syn keyword schemeGaucheExtFunc hash-table?
    syn keyword schemeGaucheExtFunc hexdigit
    syn keyword schemeGaucheExtFunc hmac-digest
    syn keyword schemeGaucheExtFunc hmac-digest-string
    syn keyword schemeGaucheExtFunc home-directory
    syn keyword schemeGaucheExtFunc hook?
    syn keyword schemeGaucheExtFunc html-doctype
    syn keyword schemeGaucheExtFunc html-escape
    syn keyword schemeGaucheExtFunc html-escape-string
    syn keyword schemeGaucheExtFunc html:a
    syn keyword schemeGaucheExtFunc html:abbr
    syn keyword schemeGaucheExtFunc html:acronym
    syn keyword schemeGaucheExtFunc html:address
    syn keyword schemeGaucheExtFunc html:area
    syn keyword schemeGaucheExtFunc html:b
    syn keyword schemeGaucheExtFunc html:base
    syn keyword schemeGaucheExtFunc html:bdo
    syn keyword schemeGaucheExtFunc html:big
    syn keyword schemeGaucheExtFunc html:blockquote
    syn keyword schemeGaucheExtFunc html:body
    syn keyword schemeGaucheExtFunc html:br
    syn keyword schemeGaucheExtFunc html:button
    syn keyword schemeGaucheExtFunc html:caption
    syn keyword schemeGaucheExtFunc html:cite
    syn keyword schemeGaucheExtFunc html:code
    syn keyword schemeGaucheExtFunc html:col
    syn keyword schemeGaucheExtFunc html:colgroup
    syn keyword schemeGaucheExtFunc html:dd
    syn keyword schemeGaucheExtFunc html:del
    syn keyword schemeGaucheExtFunc html:dfn
    syn keyword schemeGaucheExtFunc html:div
    syn keyword schemeGaucheExtFunc html:dl
    syn keyword schemeGaucheExtFunc html:dt
    syn keyword schemeGaucheExtFunc html:em
    syn keyword schemeGaucheExtFunc html:fieldset
    syn keyword schemeGaucheExtFunc html:form
    syn keyword schemeGaucheExtFunc html:frame
    syn keyword schemeGaucheExtFunc html:frameset
    syn keyword schemeGaucheExtFunc html:h1
    syn keyword schemeGaucheExtFunc html:h2
    syn keyword schemeGaucheExtFunc html:h3
    syn keyword schemeGaucheExtFunc html:h4
    syn keyword schemeGaucheExtFunc html:h5
    syn keyword schemeGaucheExtFunc html:h6
    syn keyword schemeGaucheExtFunc html:head
    syn keyword schemeGaucheExtFunc html:hr
    syn keyword schemeGaucheExtFunc html:html
    syn keyword schemeGaucheExtFunc html:i
    syn keyword schemeGaucheExtFunc html:iframe
    syn keyword schemeGaucheExtFunc html:img
    syn keyword schemeGaucheExtFunc html:input
    syn keyword schemeGaucheExtFunc html:ins
    syn keyword schemeGaucheExtFunc html:kbd
    syn keyword schemeGaucheExtFunc html:label
    syn keyword schemeGaucheExtFunc html:legend
    syn keyword schemeGaucheExtFunc html:li
    syn keyword schemeGaucheExtFunc html:link
    syn keyword schemeGaucheExtFunc html:map
    syn keyword schemeGaucheExtFunc html:meta
    syn keyword schemeGaucheExtFunc html:noframes
    syn keyword schemeGaucheExtFunc html:noscript
    syn keyword schemeGaucheExtFunc html:object
    syn keyword schemeGaucheExtFunc html:ol
    syn keyword schemeGaucheExtFunc html:optgroup
    syn keyword schemeGaucheExtFunc html:option
    syn keyword schemeGaucheExtFunc html:p
    syn keyword schemeGaucheExtFunc html:param
    syn keyword schemeGaucheExtFunc html:pre
    syn keyword schemeGaucheExtFunc html:q
    syn keyword schemeGaucheExtFunc html:samp
    syn keyword schemeGaucheExtFunc html:script
    syn keyword schemeGaucheExtFunc html:select
    syn keyword schemeGaucheExtFunc html:small
    syn keyword schemeGaucheExtFunc html:span
    syn keyword schemeGaucheExtFunc html:strong
    syn keyword schemeGaucheExtFunc html:style
    syn keyword schemeGaucheExtFunc html:sub
    syn keyword schemeGaucheExtFunc html:sup
    syn keyword schemeGaucheExtFunc html:table
    syn keyword schemeGaucheExtFunc html:tbody
    syn keyword schemeGaucheExtFunc html:td
    syn keyword schemeGaucheExtFunc html:textarea
    syn keyword schemeGaucheExtFunc html:tfoot
    syn keyword schemeGaucheExtFunc html:th
    syn keyword schemeGaucheExtFunc html:thead
    syn keyword schemeGaucheExtFunc html:title
    syn keyword schemeGaucheExtFunc html:tr
    syn keyword schemeGaucheExtFunc html:tt
    syn keyword schemeGaucheExtFunc html:ul
    syn keyword schemeGaucheExtFunc html:var
    syn keyword schemeGaucheExtFunc http-blob-sender
    syn keyword schemeGaucheExtFunc http-compose-form-data
    syn keyword schemeGaucheExtFunc http-compose-query
    syn keyword schemeGaucheExtFunc http-default-auth-handler
    syn keyword schemeGaucheExtFunc http-delete
    syn keyword schemeGaucheExtFunc http-file-receiver
    syn keyword schemeGaucheExtFunc http-file-sender
    syn keyword schemeGaucheExtFunc http-get
    syn keyword schemeGaucheExtFunc http-head
    syn keyword schemeGaucheExtFunc http-multipart-sender
    syn keyword schemeGaucheExtFunc http-null-receiver
    syn keyword schemeGaucheExtFunc http-null-sender
    syn keyword schemeGaucheExtFunc http-oport-receiver
    syn keyword schemeGaucheExtFunc http-post
    syn keyword schemeGaucheExtFunc http-put
    syn keyword schemeGaucheExtFunc http-request
    syn keyword schemeGaucheExtFunc http-secure-connection-available?
    syn keyword schemeGaucheExtFunc http-string-receiver
    syn keyword schemeGaucheExtFunc http-string-sender
    syn keyword schemeGaucheExtFunc icmp-echo-ident
    syn keyword schemeGaucheExtFunc icmp-echo-sequence
    syn keyword schemeGaucheExtFunc icmp-fill-header!
    syn keyword schemeGaucheExtFunc icmp-packet-code
    syn keyword schemeGaucheExtFunc icmp-packet-type
    syn keyword schemeGaucheExtFunc icmp4-describe-packet
    syn keyword schemeGaucheExtFunc icmp4-exceeded-code->string
    syn keyword schemeGaucheExtFunc icmp4-fill-checksum!
    syn keyword schemeGaucheExtFunc icmp4-fill-echo!
    syn keyword schemeGaucheExtFunc icmp4-message-type->string
    syn keyword schemeGaucheExtFunc icmp4-parameter-code->string
    syn keyword schemeGaucheExtFunc icmp4-redirect-code->string
    syn keyword schemeGaucheExtFunc icmp4-router-code->string
    syn keyword schemeGaucheExtFunc icmp4-security-code->string
    syn keyword schemeGaucheExtFunc icmp4-unreach-code->string
    syn keyword schemeGaucheExtFunc icmp6-describe-packet
    syn keyword schemeGaucheExtFunc icmp6-exceeded-code->string
    syn keyword schemeGaucheExtFunc icmp6-fill-echo!
    syn keyword schemeGaucheExtFunc icmp6-message-type->string
    syn keyword schemeGaucheExtFunc icmp6-parameter-code->string
    syn keyword schemeGaucheExtFunc icmp6-unreach-code->string
    syn keyword schemeGaucheExtFunc identifier->symbol
    syn keyword schemeGaucheExtFunc identifier?
    syn keyword schemeGaucheExtFunc identity
    syn keyword schemeGaucheExtFunc identity-array
    syn keyword schemeGaucheExtFunc if-car-sxpath
    syn keyword schemeGaucheExtFunc if-sxpath
    syn keyword schemeGaucheExtFunc inet-address->string
    syn keyword schemeGaucheExtFunc inet-checksum
    syn keyword schemeGaucheExtFunc inet-string->address
    syn keyword schemeGaucheExtFunc inet-string->address!
    syn keyword schemeGaucheExtFunc inexact-/
    syn keyword schemeGaucheExtFunc infinite?
    syn keyword schemeGaucheExtFunc input-serializer?
    syn keyword schemeGaucheExtFunc instance-slot-ref
    syn keyword schemeGaucheExtFunc instance-slot-set
    syn keyword schemeGaucheExtFunc integer->digit
    syn keyword schemeGaucheExtFunc integer->list
    syn keyword schemeGaucheExtFunc integer-length
    syn keyword schemeGaucheExtFunc integer-range->char-set
    syn keyword schemeGaucheExtFunc integer-range->char-set!
    syn keyword schemeGaucheExtFunc intersperse
    syn keyword schemeGaucheExtFunc iota
    syn keyword schemeGaucheExtFunc ip-destination-address
    syn keyword schemeGaucheExtFunc ip-header-length
    syn keyword schemeGaucheExtFunc ip-protocol
    syn keyword schemeGaucheExtFunc ip-source-address
    syn keyword schemeGaucheExtFunc ip-version
    syn keyword schemeGaucheExtFunc ipv4-global-address?
    syn keyword schemeGaucheExtFunc is-a?
    syn keyword schemeGaucheExtFunc isomorphic?
    syn keyword schemeGaucheExtFunc iterator->stream
    syn keyword schemeGaucheExtFunc job-acknowledge!
    syn keyword schemeGaucheExtFunc job-acknowledge-time
    syn keyword schemeGaucheExtFunc job-finish-time
    syn keyword schemeGaucheExtFunc job-mark-killed!
    syn keyword schemeGaucheExtFunc job-result
    syn keyword schemeGaucheExtFunc job-run!
    syn keyword schemeGaucheExtFunc job-start-time
    syn keyword schemeGaucheExtFunc job-status
    syn keyword schemeGaucheExtFunc job-touch!
    syn keyword schemeGaucheExtFunc job-wait
    syn keyword schemeGaucheExtFunc job?
    syn keyword schemeGaucheExtFunc join-timeout-exception?
    syn keyword schemeGaucheExtFunc judge-file
    syn keyword schemeGaucheExtFunc julian-day->date
    syn keyword schemeGaucheExtFunc julian-day->time-monotonic
    syn keyword schemeGaucheExtFunc julian-day->time-tai
    syn keyword schemeGaucheExtFunc julian-day->time-utc
    syn keyword schemeGaucheExtFunc keyword->string
    syn keyword schemeGaucheExtFunc keyword?
    syn keyword schemeGaucheExtFunc kmp-step
    syn keyword schemeGaucheExtFunc last
    syn keyword schemeGaucheExtFunc last-pair
    syn keyword schemeGaucheExtFunc lcs
    syn keyword schemeGaucheExtFunc lcs-edit-list
    syn keyword schemeGaucheExtFunc lcs-fold
    syn keyword schemeGaucheExtFunc lcs-with-positions
    syn keyword schemeGaucheExtFunc ldexp
    syn keyword schemeGaucheExtFunc least-fixnum
    syn keyword schemeGaucheExtFunc letter
    syn keyword schemeGaucheExtFunc library-exists?
    syn keyword schemeGaucheExtFunc library-fold
    syn keyword schemeGaucheExtFunc library-for-each
    syn keyword schemeGaucheExtFunc library-has-module?
    syn keyword schemeGaucheExtFunc library-map
    syn keyword schemeGaucheExtFunc list*
    syn keyword schemeGaucheExtFunc list->char-set
    syn keyword schemeGaucheExtFunc list->char-set!
    syn keyword schemeGaucheExtFunc list->f16vector
    syn keyword schemeGaucheExtFunc list->f32vector
    syn keyword schemeGaucheExtFunc list->f64vector
    syn keyword schemeGaucheExtFunc list->generator
    syn keyword schemeGaucheExtFunc list->integer
    syn keyword schemeGaucheExtFunc list->peg-stream
    syn keyword schemeGaucheExtFunc list->queue
    syn keyword schemeGaucheExtFunc list->s16vector
    syn keyword schemeGaucheExtFunc list->s32vector
    syn keyword schemeGaucheExtFunc list->s64vector
    syn keyword schemeGaucheExtFunc list->s8vector
    syn keyword schemeGaucheExtFunc list->stream
    syn keyword schemeGaucheExtFunc list->sys-fdset
    syn keyword schemeGaucheExtFunc list->u16vector
    syn keyword schemeGaucheExtFunc list->u32vector
    syn keyword schemeGaucheExtFunc list->u64vector
    syn keyword schemeGaucheExtFunc list->u8vector
    syn keyword schemeGaucheExtFunc list-copy
    syn keyword schemeGaucheExtFunc list-index
    syn keyword schemeGaucheExtFunc list-tabulate
    syn keyword schemeGaucheExtFunc list=
    syn keyword schemeGaucheExtFunc load-bundle!
    syn keyword schemeGaucheExtFunc load-from-port
    syn keyword schemeGaucheExtFunc localized-template
    syn keyword schemeGaucheExtFunc log-open
    syn keyword schemeGaucheExtFunc log2-binary-factors
    syn keyword schemeGaucheExtFunc logand
    syn keyword schemeGaucheExtFunc logbit?
    syn keyword schemeGaucheExtFunc logcount
    syn keyword schemeGaucheExtFunc logior
    syn keyword schemeGaucheExtFunc lognot
    syn keyword schemeGaucheExtFunc logtest
    syn keyword schemeGaucheExtFunc logxor
    syn keyword schemeGaucheExtFunc lower
    syn keyword schemeGaucheExtFunc lset-adjoin
    syn keyword schemeGaucheExtFunc lset-diff+intersection
    syn keyword schemeGaucheExtFunc lset-diff+intersection!
    syn keyword schemeGaucheExtFunc lset-difference
    syn keyword schemeGaucheExtFunc lset-difference!
    syn keyword schemeGaucheExtFunc lset-intersection
    syn keyword schemeGaucheExtFunc lset-intersection!
    syn keyword schemeGaucheExtFunc lset-union
    syn keyword schemeGaucheExtFunc lset-union!
    syn keyword schemeGaucheExtFunc lset-xor
    syn keyword schemeGaucheExtFunc lset-xor!
    syn keyword schemeGaucheExtFunc lset<=
    syn keyword schemeGaucheExtFunc lset=
    syn keyword schemeGaucheExtFunc macroexpand
    syn keyword schemeGaucheExtFunc macroexpand-1
    syn keyword schemeGaucheExtFunc main
    syn keyword schemeGaucheExtFunc make-array
    syn keyword schemeGaucheExtFunc make-bimap
    syn keyword schemeGaucheExtFunc make-byte-string
    syn keyword schemeGaucheExtFunc make-cgen-type
    syn keyword schemeGaucheExtFunc make-char-quotator
    syn keyword schemeGaucheExtFunc make-client-socket
    syn keyword schemeGaucheExtFunc make-compound-condition
    syn keyword schemeGaucheExtFunc make-condition
    syn keyword schemeGaucheExtFunc make-condition-type
    syn keyword schemeGaucheExtFunc make-condition-variable
    syn keyword schemeGaucheExtFunc make-csv-reader
    syn keyword schemeGaucheExtFunc make-csv-writer
    syn keyword schemeGaucheExtFunc make-date
    syn keyword schemeGaucheExtFunc make-directory*
    syn keyword schemeGaucheExtFunc make-empty-attlist
    syn keyword schemeGaucheExtFunc make-f16array
    syn keyword schemeGaucheExtFunc make-f16vector
    syn keyword schemeGaucheExtFunc make-f32array
    syn keyword schemeGaucheExtFunc make-f32vector
    syn keyword schemeGaucheExtFunc make-f64array
    syn keyword schemeGaucheExtFunc make-f64vector
    syn keyword schemeGaucheExtFunc make-fobject
    syn keyword schemeGaucheExtFunc make-fstruct-type
    syn keyword schemeGaucheExtFunc make-gettext
    syn keyword schemeGaucheExtFunc make-glob-fs-fold
    syn keyword schemeGaucheExtFunc make-grapheme-cluster-breaker
    syn keyword schemeGaucheExtFunc make-grapheme-cluster-reader
    syn keyword schemeGaucheExtFunc make-hash-table
    syn keyword schemeGaucheExtFunc make-hook
    syn keyword schemeGaucheExtFunc make-http-connection
    syn keyword schemeGaucheExtFunc make-initial-:-dispatch
    syn keyword schemeGaucheExtFunc make-job
    syn keyword schemeGaucheExtFunc make-keyword
    syn keyword schemeGaucheExtFunc make-kmp-restart-vector
    syn keyword schemeGaucheExtFunc make-list
    syn keyword schemeGaucheExtFunc make-module
    syn keyword schemeGaucheExtFunc make-mtqueue
    syn keyword schemeGaucheExtFunc make-mutex
    syn keyword schemeGaucheExtFunc make-packer
    syn keyword schemeGaucheExtFunc make-parameter
    syn keyword schemeGaucheExtFunc make-peg-parse-error
    syn keyword schemeGaucheExtFunc make-peg-stream
    syn keyword schemeGaucheExtFunc make-queue
    syn keyword schemeGaucheExtFunc make-random-source
    syn keyword schemeGaucheExtFunc make-rbtree
    syn keyword schemeGaucheExtFunc make-record-type
    syn keyword schemeGaucheExtFunc make-rtd
    syn keyword schemeGaucheExtFunc make-s16array
    syn keyword schemeGaucheExtFunc make-s16vector
    syn keyword schemeGaucheExtFunc make-s32array
    syn keyword schemeGaucheExtFunc make-s32vector
    syn keyword schemeGaucheExtFunc make-s64array
    syn keyword schemeGaucheExtFunc make-s64vector
    syn keyword schemeGaucheExtFunc make-s8array
    syn keyword schemeGaucheExtFunc make-s8vector
    syn keyword schemeGaucheExtFunc make-server-socket
    syn keyword schemeGaucheExtFunc make-server-sockets
    syn keyword schemeGaucheExtFunc make-sockaddrs
    syn keyword schemeGaucheExtFunc make-socket
    syn keyword schemeGaucheExtFunc make-sparse-table
    syn keyword schemeGaucheExtFunc make-sparse-vector
    syn keyword schemeGaucheExtFunc make-stream
    syn keyword schemeGaucheExtFunc make-string-pointer
    syn keyword schemeGaucheExtFunc make-sys-addrinfo
    syn keyword schemeGaucheExtFunc make-text-progress-bar
    syn keyword schemeGaucheExtFunc make-thread
    syn keyword schemeGaucheExtFunc make-thread-pool
    syn keyword schemeGaucheExtFunc make-time
    syn keyword schemeGaucheExtFunc make-tree-map
    syn keyword schemeGaucheExtFunc make-trie
    syn keyword schemeGaucheExtFunc make-u16array
    syn keyword schemeGaucheExtFunc make-u16vector
    syn keyword schemeGaucheExtFunc make-u32array
    syn keyword schemeGaucheExtFunc make-u32vector
    syn keyword schemeGaucheExtFunc make-u64array
    syn keyword schemeGaucheExtFunc make-u64vector
    syn keyword schemeGaucheExtFunc make-u8array
    syn keyword schemeGaucheExtFunc make-u8vector
    syn keyword schemeGaucheExtFunc make-weak-vector
    syn keyword schemeGaucheExtFunc make-word-breaker
    syn keyword schemeGaucheExtFunc make-word-reader
    syn keyword schemeGaucheExtFunc make-xml-token
    syn keyword schemeGaucheExtFunc map!
    syn keyword schemeGaucheExtFunc map$
    syn keyword schemeGaucheExtFunc map*
    syn keyword schemeGaucheExtFunc map-in-order
    syn keyword schemeGaucheExtFunc map-union
    syn keyword schemeGaucheExtFunc match:$-ref
    syn keyword schemeGaucheExtFunc match:error
    syn keyword schemeGaucheExtFunc match:every
    syn keyword schemeGaucheExtFunc md5-digest
    syn keyword schemeGaucheExtFunc md5-digest-string
    syn keyword schemeGaucheExtFunc member$
    syn keyword schemeGaucheExtFunc merge
    syn keyword schemeGaucheExtFunc merge!
    syn keyword schemeGaucheExtFunc method-code
    syn keyword schemeGaucheExtFunc mime-body->file
    syn keyword schemeGaucheExtFunc mime-body->string
    syn keyword schemeGaucheExtFunc mime-compose-message
    syn keyword schemeGaucheExtFunc mime-compose-message-string
    syn keyword schemeGaucheExtFunc mime-compose-parameters
    syn keyword schemeGaucheExtFunc mime-decode-text
    syn keyword schemeGaucheExtFunc mime-decode-word
    syn keyword schemeGaucheExtFunc mime-encode-text
    syn keyword schemeGaucheExtFunc mime-encode-word
    syn keyword schemeGaucheExtFunc mime-make-boundary
    syn keyword schemeGaucheExtFunc mime-parse-content-disposition
    syn keyword schemeGaucheExtFunc mime-parse-content-type
    syn keyword schemeGaucheExtFunc mime-parse-message
    syn keyword schemeGaucheExtFunc mime-parse-parameters
    syn keyword schemeGaucheExtFunc mime-parse-version
    syn keyword schemeGaucheExtFunc mime-retrieve-body
    syn keyword schemeGaucheExtFunc min&max
    syn keyword schemeGaucheExtFunc modf
    syn keyword schemeGaucheExtFunc modified-julian-day->date
    syn keyword schemeGaucheExtFunc modified-julian-day->time-monotonic
    syn keyword schemeGaucheExtFunc modified-julian-day->time-tai
    syn keyword schemeGaucheExtFunc modified-julian-day->time-utc
    syn keyword schemeGaucheExtFunc module-exports
    syn keyword schemeGaucheExtFunc module-imports
    syn keyword schemeGaucheExtFunc module-name
    syn keyword schemeGaucheExtFunc module-name->path
    syn keyword schemeGaucheExtFunc module-parents
    syn keyword schemeGaucheExtFunc module-precedence-list
    syn keyword schemeGaucheExtFunc module-table
    syn keyword schemeGaucheExtFunc module?
    syn keyword schemeGaucheExtFunc monotonic-merge
    syn keyword schemeGaucheExtFunc move-file
    syn keyword schemeGaucheExtFunc mt-random-fill-f32vector!
    syn keyword schemeGaucheExtFunc mt-random-fill-f64vector!
    syn keyword schemeGaucheExtFunc mt-random-fill-u32vector!
    syn keyword schemeGaucheExtFunc mt-random-get-state
    syn keyword schemeGaucheExtFunc mt-random-integer
    syn keyword schemeGaucheExtFunc mt-random-real
    syn keyword schemeGaucheExtFunc mt-random-real0
    syn keyword schemeGaucheExtFunc mt-random-set-seed!
    syn keyword schemeGaucheExtFunc mt-random-set-state!
    syn keyword schemeGaucheExtFunc mtqueue-max-length
    syn keyword schemeGaucheExtFunc mtqueue-room
    syn keyword schemeGaucheExtFunc mtqueue?
    syn keyword schemeGaucheExtFunc mutex-lock!
    syn keyword schemeGaucheExtFunc mutex-name
    syn keyword schemeGaucheExtFunc mutex-specific
    syn keyword schemeGaucheExtFunc mutex-specific-set!
    syn keyword schemeGaucheExtFunc mutex-state
    syn keyword schemeGaucheExtFunc mutex-unlock!
    syn keyword schemeGaucheExtFunc mutex?
    syn keyword schemeGaucheExtFunc name-compare
    syn keyword schemeGaucheExtFunc nan?
    syn keyword schemeGaucheExtFunc native-endian
    syn keyword schemeGaucheExtFunc ndbm-clearerror
    syn keyword schemeGaucheExtFunc ndbm-close
    syn keyword schemeGaucheExtFunc ndbm-closed?
    syn keyword schemeGaucheExtFunc ndbm-delete
    syn keyword schemeGaucheExtFunc ndbm-error
    syn keyword schemeGaucheExtFunc ndbm-exists?
    syn keyword schemeGaucheExtFunc ndbm-fetch
    syn keyword schemeGaucheExtFunc ndbm-firstkey
    syn keyword schemeGaucheExtFunc ndbm-nextkey
    syn keyword schemeGaucheExtFunc ndbm-open
    syn keyword schemeGaucheExtFunc ndbm-store
    syn keyword schemeGaucheExtFunc next-token
    syn keyword schemeGaucheExtFunc next-token-of
    syn keyword schemeGaucheExtFunc ngettext
    syn keyword schemeGaucheExtFunc ninth
    syn keyword schemeGaucheExtFunc node-closure
    syn keyword schemeGaucheExtFunc node-eq?
    syn keyword schemeGaucheExtFunc node-equal?
    syn keyword schemeGaucheExtFunc node-join
    syn keyword schemeGaucheExtFunc node-or
    syn keyword schemeGaucheExtFunc node-pos
    syn keyword schemeGaucheExtFunc node-reduce
    syn keyword schemeGaucheExtFunc node-reverse
    syn keyword schemeGaucheExtFunc node-self
    syn keyword schemeGaucheExtFunc node-trace
    syn keyword schemeGaucheExtFunc nodeset?
    syn keyword schemeGaucheExtFunc not-pair?
    syn keyword schemeGaucheExtFunc ntype-names??
    syn keyword schemeGaucheExtFunc ntype-namespace-id??
    syn keyword schemeGaucheExtFunc ntype??
    syn keyword schemeGaucheExtFunc null-device
    syn keyword schemeGaucheExtFunc null-generator
    syn keyword schemeGaucheExtFunc null-list?
    syn keyword schemeGaucheExtFunc number->stream
    syn keyword schemeGaucheExtFunc open-coding-aware-port
    syn keyword schemeGaucheExtFunc open-info-file
    syn keyword schemeGaucheExtFunc open-input-buffered-port
    syn keyword schemeGaucheExtFunc open-input-conversion-port
    syn keyword schemeGaucheExtFunc open-input-fd-port
    syn keyword schemeGaucheExtFunc open-input-limited-length-port
    syn keyword schemeGaucheExtFunc open-input-process-port
    syn keyword schemeGaucheExtFunc open-input-string
    syn keyword schemeGaucheExtFunc open-input-uvector
    syn keyword schemeGaucheExtFunc open-output-buffered-port
    syn keyword schemeGaucheExtFunc open-output-conversion-port
    syn keyword schemeGaucheExtFunc open-output-fd-port
    syn keyword schemeGaucheExtFunc open-output-process-port
    syn keyword schemeGaucheExtFunc open-output-string
    syn keyword schemeGaucheExtFunc open-output-uvector
    syn keyword schemeGaucheExtFunc option
    syn keyword schemeGaucheExtFunc option?
    syn keyword schemeGaucheExtFunc output-serializer?
    syn keyword schemeGaucheExtFunc pa$
    syn keyword schemeGaucheExtFunc pack
    syn keyword schemeGaucheExtFunc pair-fold
    syn keyword schemeGaucheExtFunc pair-fold-right
    syn keyword schemeGaucheExtFunc pair-for-each
    syn keyword schemeGaucheExtFunc parse-cookie-string
    syn keyword schemeGaucheExtFunc parse-json
    syn keyword schemeGaucheExtFunc parse-json-string
    syn keyword schemeGaucheExtFunc parser-error
    syn keyword schemeGaucheExtFunc partition
    syn keyword schemeGaucheExtFunc partition!
    syn keyword schemeGaucheExtFunc partition$
    syn keyword schemeGaucheExtFunc path->gauche-package-description
    syn keyword schemeGaucheExtFunc path->module-name
    syn keyword schemeGaucheExtFunc path-extension
    syn keyword schemeGaucheExtFunc path-sans-extension
    syn keyword schemeGaucheExtFunc path-separator
    syn keyword schemeGaucheExtFunc path-swap-extension
    syn keyword schemeGaucheExtFunc peek-byte
    syn keyword schemeGaucheExtFunc peek-next-char
    syn keyword schemeGaucheExtFunc peg-parse-port
    syn keyword schemeGaucheExtFunc peg-parse-string
    syn keyword schemeGaucheExtFunc peg-run-parser
    syn keyword schemeGaucheExtFunc peg-stream-peek!
    syn keyword schemeGaucheExtFunc peg-stream-position
    syn keyword schemeGaucheExtFunc permutations
    syn keyword schemeGaucheExtFunc permutations*
    syn keyword schemeGaucheExtFunc permutations*-for-each
    syn keyword schemeGaucheExtFunc permutations-for-each
    syn keyword schemeGaucheExtFunc port->byte-string
    syn keyword schemeGaucheExtFunc port->list
    syn keyword schemeGaucheExtFunc port->peg-stream
    syn keyword schemeGaucheExtFunc port->sexp-list
    syn keyword schemeGaucheExtFunc port->stream
    syn keyword schemeGaucheExtFunc port->string
    syn keyword schemeGaucheExtFunc port->string-list
    syn keyword schemeGaucheExtFunc port-buffering
    syn keyword schemeGaucheExtFunc port-case-fold-set!
    syn keyword schemeGaucheExtFunc port-closed?
    syn keyword schemeGaucheExtFunc port-current-line
    syn keyword schemeGaucheExtFunc port-fd-dup!
    syn keyword schemeGaucheExtFunc port-file-number
    syn keyword schemeGaucheExtFunc port-fold
    syn keyword schemeGaucheExtFunc port-fold-right
    syn keyword schemeGaucheExtFunc port-for-each
    syn keyword schemeGaucheExtFunc port-map
    syn keyword schemeGaucheExtFunc port-name
    syn keyword schemeGaucheExtFunc port-position-prefix
    syn keyword schemeGaucheExtFunc port-seek
    syn keyword schemeGaucheExtFunc port-tell
    syn keyword schemeGaucheExtFunc port-type
    syn keyword schemeGaucheExtFunc posix-access
    syn keyword schemeGaucheExtFunc posix-chmod
    syn keyword schemeGaucheExtFunc posix-ctime
    syn keyword schemeGaucheExtFunc posix-domain-name
    syn keyword schemeGaucheExtFunc posix-fork
    syn keyword schemeGaucheExtFunc posix-getlogin
    syn keyword schemeGaucheExtFunc posix-gmtime
    syn keyword schemeGaucheExtFunc posix-host-name
    syn keyword schemeGaucheExtFunc posix-localtime
    syn keyword schemeGaucheExtFunc posix-mktime
    syn keyword schemeGaucheExtFunc posix-pipe
    syn keyword schemeGaucheExtFunc posix-rename
    syn keyword schemeGaucheExtFunc posix-rmdir
    syn keyword schemeGaucheExtFunc posix-stat
    syn keyword schemeGaucheExtFunc posix-stat->vector
    syn keyword schemeGaucheExtFunc posix-strftime
    syn keyword schemeGaucheExtFunc posix-symlink
    syn keyword schemeGaucheExtFunc posix-time
    syn keyword schemeGaucheExtFunc posix-tm->vector
    syn keyword schemeGaucheExtFunc posix-uname
    syn keyword schemeGaucheExtFunc posix-unlink
    syn keyword schemeGaucheExtFunc posix-wait
    syn keyword schemeGaucheExtFunc post-order
    syn keyword schemeGaucheExtFunc power-set
    syn keyword schemeGaucheExtFunc power-set*
    syn keyword schemeGaucheExtFunc power-set*-for-each
    syn keyword schemeGaucheExtFunc power-set-binary
    syn keyword schemeGaucheExtFunc power-set-for-each
    syn keyword schemeGaucheExtFunc pp
    syn keyword schemeGaucheExtFunc pre-post-order
    syn keyword schemeGaucheExtFunc pretty-print-array
    syn keyword schemeGaucheExtFunc prim-test
    syn keyword schemeGaucheExtFunc print
    syn keyword schemeGaucheExtFunc procedure-arity-includes?
    syn keyword schemeGaucheExtFunc procedure-info
    syn keyword schemeGaucheExtFunc process-alive?
    syn keyword schemeGaucheExtFunc process-continue
    syn keyword schemeGaucheExtFunc process-error
    syn keyword schemeGaucheExtFunc process-input
    syn keyword schemeGaucheExtFunc process-kill
    syn keyword schemeGaucheExtFunc process-list
    syn keyword schemeGaucheExtFunc process-output
    syn keyword schemeGaucheExtFunc process-output->string
    syn keyword schemeGaucheExtFunc process-output->string-list
    syn keyword schemeGaucheExtFunc process-send-signal
    syn keyword schemeGaucheExtFunc process-stop
    syn keyword schemeGaucheExtFunc process-wait
    syn keyword schemeGaucheExtFunc process-wait-any
    syn keyword schemeGaucheExtFunc process?
    syn keyword schemeGaucheExtFunc profiler-get-result
    syn keyword schemeGaucheExtFunc profiler-reset
    syn keyword schemeGaucheExtFunc profiler-show
    syn keyword schemeGaucheExtFunc profiler-show-load-stats
    syn keyword schemeGaucheExtFunc profiler-start
    syn keyword schemeGaucheExtFunc profiler-stop
    syn keyword schemeGaucheExtFunc promise-kind
    syn keyword schemeGaucheExtFunc promise?
    syn keyword schemeGaucheExtFunc proper-list?
    syn keyword schemeGaucheExtFunc provide
    syn keyword schemeGaucheExtFunc provided?
    syn keyword schemeGaucheExtFunc put-f16!
    syn keyword schemeGaucheExtFunc put-f16be!
    syn keyword schemeGaucheExtFunc put-f16le!
    syn keyword schemeGaucheExtFunc put-f32!
    syn keyword schemeGaucheExtFunc put-f32be!
    syn keyword schemeGaucheExtFunc put-f32le!
    syn keyword schemeGaucheExtFunc put-f64!
    syn keyword schemeGaucheExtFunc put-f64be!
    syn keyword schemeGaucheExtFunc put-f64le!
    syn keyword schemeGaucheExtFunc put-fobject!
    syn keyword schemeGaucheExtFunc put-s16!
    syn keyword schemeGaucheExtFunc put-s16be!
    syn keyword schemeGaucheExtFunc put-s16le!
    syn keyword schemeGaucheExtFunc put-s32!
    syn keyword schemeGaucheExtFunc put-s32be!
    syn keyword schemeGaucheExtFunc put-s32le!
    syn keyword schemeGaucheExtFunc put-s64!
    syn keyword schemeGaucheExtFunc put-s64be!
    syn keyword schemeGaucheExtFunc put-s64le!
    syn keyword schemeGaucheExtFunc put-s8!
    syn keyword schemeGaucheExtFunc put-u16!
    syn keyword schemeGaucheExtFunc put-u16be!
    syn keyword schemeGaucheExtFunc put-u16le!
    syn keyword schemeGaucheExtFunc put-u32!
    syn keyword schemeGaucheExtFunc put-u32be!
    syn keyword schemeGaucheExtFunc put-u32le!
    syn keyword schemeGaucheExtFunc put-u64!
    syn keyword schemeGaucheExtFunc put-u64be!
    syn keyword schemeGaucheExtFunc put-u64le!
    syn keyword schemeGaucheExtFunc put-u8!
    syn keyword schemeGaucheExtFunc queue->list
    syn keyword schemeGaucheExtFunc queue-empty?
    syn keyword schemeGaucheExtFunc queue-front
    syn keyword schemeGaucheExtFunc queue-length
    syn keyword schemeGaucheExtFunc queue-pop!
    syn keyword schemeGaucheExtFunc queue-pop/wait!
    syn keyword schemeGaucheExtFunc queue-push!
    syn keyword schemeGaucheExtFunc queue-push-unique!
    syn keyword schemeGaucheExtFunc queue-push/wait!
    syn keyword schemeGaucheExtFunc queue-rear
    syn keyword schemeGaucheExtFunc queue?
    syn keyword schemeGaucheExtFunc quoted-printable-decode
    syn keyword schemeGaucheExtFunc quoted-printable-decode-string
    syn keyword schemeGaucheExtFunc quoted-printable-encode
    syn keyword schemeGaucheExtFunc quoted-printable-encode-string
    syn keyword schemeGaucheExtFunc quotient&remainder
    syn keyword schemeGaucheExtFunc raise
    syn keyword schemeGaucheExtFunc random
    syn keyword schemeGaucheExtFunc random-integer
    syn keyword schemeGaucheExtFunc random-real
    syn keyword schemeGaucheExtFunc random-source-make-integers
    syn keyword schemeGaucheExtFunc random-source-make-reals
    syn keyword schemeGaucheExtFunc random-source-pseudo-randomize!
    syn keyword schemeGaucheExtFunc random-source-randomize!
    syn keyword schemeGaucheExtFunc random-source-state-ref
    syn keyword schemeGaucheExtFunc random-source-state-set!
    syn keyword schemeGaucheExtFunc random-source?
    syn keyword schemeGaucheExtFunc rassoc
    syn keyword schemeGaucheExtFunc rassoc-ref
    syn keyword schemeGaucheExtFunc rassq
    syn keyword schemeGaucheExtFunc rassq-ref
    syn keyword schemeGaucheExtFunc rassv
    syn keyword schemeGaucheExtFunc rassv-ref
    syn keyword schemeGaucheExtFunc rbtree->alist
    syn keyword schemeGaucheExtFunc rbtree-copy
    syn keyword schemeGaucheExtFunc rbtree-delete!
    syn keyword schemeGaucheExtFunc rbtree-empty?
    syn keyword schemeGaucheExtFunc rbtree-exists?
    syn keyword schemeGaucheExtFunc rbtree-extract-max!
    syn keyword schemeGaucheExtFunc rbtree-extract-min!
    syn keyword schemeGaucheExtFunc rbtree-fold
    syn keyword schemeGaucheExtFunc rbtree-fold-right
    syn keyword schemeGaucheExtFunc rbtree-get
    syn keyword schemeGaucheExtFunc rbtree-keys
    syn keyword schemeGaucheExtFunc rbtree-max
    syn keyword schemeGaucheExtFunc rbtree-min
    syn keyword schemeGaucheExtFunc rbtree-num-entries
    syn keyword schemeGaucheExtFunc rbtree-pop!
    syn keyword schemeGaucheExtFunc rbtree-push!
    syn keyword schemeGaucheExtFunc rbtree-put!
    syn keyword schemeGaucheExtFunc rbtree-update!
    syn keyword schemeGaucheExtFunc rbtree-values
    syn keyword schemeGaucheExtFunc rbtree?
    syn keyword schemeGaucheExtFunc read-ber-integer
    syn keyword schemeGaucheExtFunc read-binary-double
    syn keyword schemeGaucheExtFunc read-binary-float
    syn keyword schemeGaucheExtFunc read-binary-long
    syn keyword schemeGaucheExtFunc read-binary-short
    syn keyword schemeGaucheExtFunc read-binary-sint
    syn keyword schemeGaucheExtFunc read-binary-sint16
    syn keyword schemeGaucheExtFunc read-binary-sint32
    syn keyword schemeGaucheExtFunc read-binary-sint64
    syn keyword schemeGaucheExtFunc read-binary-sint8
    syn keyword schemeGaucheExtFunc read-binary-uint
    syn keyword schemeGaucheExtFunc read-binary-uint16
    syn keyword schemeGaucheExtFunc read-binary-uint32
    syn keyword schemeGaucheExtFunc read-binary-uint64
    syn keyword schemeGaucheExtFunc read-binary-uint8
    syn keyword schemeGaucheExtFunc read-binary-ulong
    syn keyword schemeGaucheExtFunc read-binary-ushort
    syn keyword schemeGaucheExtFunc read-block
    syn keyword schemeGaucheExtFunc read-block!
    syn keyword schemeGaucheExtFunc read-byte
    syn keyword schemeGaucheExtFunc read-char-set
    syn keyword schemeGaucheExtFunc read-eval-print-loop
    syn keyword schemeGaucheExtFunc read-f16
    syn keyword schemeGaucheExtFunc read-f32
    syn keyword schemeGaucheExtFunc read-f64
    syn keyword schemeGaucheExtFunc read-fobject
    syn keyword schemeGaucheExtFunc read-fobject!/uv
    syn keyword schemeGaucheExtFunc read-from-string
    syn keyword schemeGaucheExtFunc read-line
    syn keyword schemeGaucheExtFunc read-list
    syn keyword schemeGaucheExtFunc read-reference-has-value?
    syn keyword schemeGaucheExtFunc read-reference-value
    syn keyword schemeGaucheExtFunc read-reference?
    syn keyword schemeGaucheExtFunc read-s16
    syn keyword schemeGaucheExtFunc read-s32
    syn keyword schemeGaucheExtFunc read-s64
    syn keyword schemeGaucheExtFunc read-s8
    syn keyword schemeGaucheExtFunc read-sint
    syn keyword schemeGaucheExtFunc read-string
    syn keyword schemeGaucheExtFunc read-u16
    syn keyword schemeGaucheExtFunc read-u32
    syn keyword schemeGaucheExtFunc read-u64
    syn keyword schemeGaucheExtFunc read-u8
    syn keyword schemeGaucheExtFunc read-uint
    syn keyword schemeGaucheExtFunc read-with-shared-structure
    syn keyword schemeGaucheExtFunc read/ss
    syn keyword schemeGaucheExtFunc record-accessor
    syn keyword schemeGaucheExtFunc record-constructor
    syn keyword schemeGaucheExtFunc record-modifier
    syn keyword schemeGaucheExtFunc record-predicate
    syn keyword schemeGaucheExtFunc record-rtd
    syn keyword schemeGaucheExtFunc record-type-descriptor
    syn keyword schemeGaucheExtFunc record-type-fields
    syn keyword schemeGaucheExtFunc record-type-name
    syn keyword schemeGaucheExtFunc record?
    syn keyword schemeGaucheExtFunc redefine-class!
    syn keyword schemeGaucheExtFunc reduce
    syn keyword schemeGaucheExtFunc reduce$
    syn keyword schemeGaucheExtFunc reduce-right
    syn keyword schemeGaucheExtFunc reduce-right$
    syn keyword schemeGaucheExtFunc ref*
    syn keyword schemeGaucheExtFunc regexp->string
    syn keyword schemeGaucheExtFunc regexp-ast
    syn keyword schemeGaucheExtFunc regexp-case-fold?
    syn keyword schemeGaucheExtFunc regexp-compile
    syn keyword schemeGaucheExtFunc regexp-optimize
    syn keyword schemeGaucheExtFunc regexp-parse
    syn keyword schemeGaucheExtFunc regexp-quote
    syn keyword schemeGaucheExtFunc regexp-replace
    syn keyword schemeGaucheExtFunc regexp-replace*
    syn keyword schemeGaucheExtFunc regexp-replace-all
    syn keyword schemeGaucheExtFunc regexp-replace-all*
    syn keyword schemeGaucheExtFunc regexp-unparse
    syn keyword schemeGaucheExtFunc regexp?
    syn keyword schemeGaucheExtFunc regmatch?
    syn keyword schemeGaucheExtFunc relative-path?
    syn keyword schemeGaucheExtFunc relnum-compare
    syn keyword schemeGaucheExtFunc reload
    syn keyword schemeGaucheExtFunc reload-modified-modules
    syn keyword schemeGaucheExtFunc remove
    syn keyword schemeGaucheExtFunc remove!
    syn keyword schemeGaucheExtFunc remove$
    syn keyword schemeGaucheExtFunc remove-directory*
    syn keyword schemeGaucheExtFunc remove-file
    syn keyword schemeGaucheExtFunc remove-files
    syn keyword schemeGaucheExtFunc remove-from-queue!
    syn keyword schemeGaucheExtFunc remq
    syn keyword schemeGaucheExtFunc remv
    syn keyword schemeGaucheExtFunc rename-file
    syn keyword schemeGaucheExtFunc replace-range
    syn keyword schemeGaucheExtFunc report-error
    syn keyword schemeGaucheExtFunc report-time-results
    syn keyword schemeGaucheExtFunc reset-http-connection
    syn keyword schemeGaucheExtFunc resolve-path
    syn keyword schemeGaucheExtFunc reverse!
    syn keyword schemeGaucheExtFunc reverse-bit-field
    syn keyword schemeGaucheExtFunc reverse-bits->generator
    syn keyword schemeGaucheExtFunc reverse-list->string
    syn keyword schemeGaucheExtFunc reverse-list->vector
    syn keyword schemeGaucheExtFunc reverse-vector->generator
    syn keyword schemeGaucheExtFunc reverse-vector->list
    syn keyword schemeGaucheExtFunc rfc822-atom
    syn keyword schemeGaucheExtFunc rfc822-date->date
    syn keyword schemeGaucheExtFunc rfc822-dot-atom
    syn keyword schemeGaucheExtFunc rfc822-field->tokens
    syn keyword schemeGaucheExtFunc rfc822-header->list
    syn keyword schemeGaucheExtFunc rfc822-header-ref
    syn keyword schemeGaucheExtFunc rfc822-invalid-header-field
    syn keyword schemeGaucheExtFunc rfc822-next-token
    syn keyword schemeGaucheExtFunc rfc822-parse-date
    syn keyword schemeGaucheExtFunc rfc822-parse-errorf
    syn keyword schemeGaucheExtFunc rfc822-quoted-string
    syn keyword schemeGaucheExtFunc rfc822-read-headers
    syn keyword schemeGaucheExtFunc rfc822-skip-cfws
    syn keyword schemeGaucheExtFunc rfc822-write-headers
    syn keyword schemeGaucheExtFunc rope->string
    syn keyword schemeGaucheExtFunc rope-finalize
    syn keyword schemeGaucheExtFunc rotate-bit-field
    syn keyword schemeGaucheExtFunc round->exact
    syn keyword schemeGaucheExtFunc rtd-all-field-names
    syn keyword schemeGaucheExtFunc rtd-field-mutable?
    syn keyword schemeGaucheExtFunc rtd-field-names
    syn keyword schemeGaucheExtFunc rtd-name
    syn keyword schemeGaucheExtFunc rtd-parent
    syn keyword schemeGaucheExtFunc rtd?
    syn keyword schemeGaucheExtFunc run
    syn keyword schemeGaucheExtFunc run-cgi-script->header&body
    syn keyword schemeGaucheExtFunc run-cgi-script->string
    syn keyword schemeGaucheExtFunc run-cgi-script->string-list
    syn keyword schemeGaucheExtFunc run-cgi-script->sxml
    syn keyword schemeGaucheExtFunc run-process
    syn keyword schemeGaucheExtFunc rxmatch
    syn keyword schemeGaucheExtFunc rxmatch->string
    syn keyword schemeGaucheExtFunc rxmatch-after
    syn keyword schemeGaucheExtFunc rxmatch-before
    syn keyword schemeGaucheExtFunc rxmatch-end
    syn keyword schemeGaucheExtFunc rxmatch-num-matches
    syn keyword schemeGaucheExtFunc rxmatch-start
    syn keyword schemeGaucheExtFunc rxmatch-substring
    syn keyword schemeGaucheExtFunc s16vector
    syn keyword schemeGaucheExtFunc s16vector->list
    syn keyword schemeGaucheExtFunc s16vector->vector
    syn keyword schemeGaucheExtFunc s16vector-add
    syn keyword schemeGaucheExtFunc s16vector-add!
    syn keyword schemeGaucheExtFunc s16vector-and
    syn keyword schemeGaucheExtFunc s16vector-and!
    syn keyword schemeGaucheExtFunc s16vector-clamp
    syn keyword schemeGaucheExtFunc s16vector-clamp!
    syn keyword schemeGaucheExtFunc s16vector-copy
    syn keyword schemeGaucheExtFunc s16vector-copy!
    syn keyword schemeGaucheExtFunc s16vector-dot
    syn keyword schemeGaucheExtFunc s16vector-fill!
    syn keyword schemeGaucheExtFunc s16vector-ior
    syn keyword schemeGaucheExtFunc s16vector-ior!
    syn keyword schemeGaucheExtFunc s16vector-length
    syn keyword schemeGaucheExtFunc s16vector-mul
    syn keyword schemeGaucheExtFunc s16vector-mul!
    syn keyword schemeGaucheExtFunc s16vector-range-check
    syn keyword schemeGaucheExtFunc s16vector-ref
    syn keyword schemeGaucheExtFunc s16vector-set!
    syn keyword schemeGaucheExtFunc s16vector-sub
    syn keyword schemeGaucheExtFunc s16vector-sub!
    syn keyword schemeGaucheExtFunc s16vector-swap-bytes
    syn keyword schemeGaucheExtFunc s16vector-swap-bytes!
    syn keyword schemeGaucheExtFunc s16vector-xor
    syn keyword schemeGaucheExtFunc s16vector-xor!
    syn keyword schemeGaucheExtFunc s16vector?
    syn keyword schemeGaucheExtFunc s32vector
    syn keyword schemeGaucheExtFunc s32vector->list
    syn keyword schemeGaucheExtFunc s32vector->string
    syn keyword schemeGaucheExtFunc s32vector->vector
    syn keyword schemeGaucheExtFunc s32vector-add
    syn keyword schemeGaucheExtFunc s32vector-add!
    syn keyword schemeGaucheExtFunc s32vector-and
    syn keyword schemeGaucheExtFunc s32vector-and!
    syn keyword schemeGaucheExtFunc s32vector-clamp
    syn keyword schemeGaucheExtFunc s32vector-clamp!
    syn keyword schemeGaucheExtFunc s32vector-copy
    syn keyword schemeGaucheExtFunc s32vector-copy!
    syn keyword schemeGaucheExtFunc s32vector-dot
    syn keyword schemeGaucheExtFunc s32vector-fill!
    syn keyword schemeGaucheExtFunc s32vector-ior
    syn keyword schemeGaucheExtFunc s32vector-ior!
    syn keyword schemeGaucheExtFunc s32vector-length
    syn keyword schemeGaucheExtFunc s32vector-mul
    syn keyword schemeGaucheExtFunc s32vector-mul!
    syn keyword schemeGaucheExtFunc s32vector-range-check
    syn keyword schemeGaucheExtFunc s32vector-ref
    syn keyword schemeGaucheExtFunc s32vector-set!
    syn keyword schemeGaucheExtFunc s32vector-sub
    syn keyword schemeGaucheExtFunc s32vector-sub!
    syn keyword schemeGaucheExtFunc s32vector-swap-bytes
    syn keyword schemeGaucheExtFunc s32vector-swap-bytes!
    syn keyword schemeGaucheExtFunc s32vector-xor
    syn keyword schemeGaucheExtFunc s32vector-xor!
    syn keyword schemeGaucheExtFunc s32vector?
    syn keyword schemeGaucheExtFunc s64vector
    syn keyword schemeGaucheExtFunc s64vector->list
    syn keyword schemeGaucheExtFunc s64vector->vector
    syn keyword schemeGaucheExtFunc s64vector-add
    syn keyword schemeGaucheExtFunc s64vector-add!
    syn keyword schemeGaucheExtFunc s64vector-and
    syn keyword schemeGaucheExtFunc s64vector-and!
    syn keyword schemeGaucheExtFunc s64vector-clamp
    syn keyword schemeGaucheExtFunc s64vector-clamp!
    syn keyword schemeGaucheExtFunc s64vector-copy
    syn keyword schemeGaucheExtFunc s64vector-copy!
    syn keyword schemeGaucheExtFunc s64vector-dot
    syn keyword schemeGaucheExtFunc s64vector-fill!
    syn keyword schemeGaucheExtFunc s64vector-ior
    syn keyword schemeGaucheExtFunc s64vector-ior!
    syn keyword schemeGaucheExtFunc s64vector-length
    syn keyword schemeGaucheExtFunc s64vector-mul
    syn keyword schemeGaucheExtFunc s64vector-mul!
    syn keyword schemeGaucheExtFunc s64vector-range-check
    syn keyword schemeGaucheExtFunc s64vector-ref
    syn keyword schemeGaucheExtFunc s64vector-set!
    syn keyword schemeGaucheExtFunc s64vector-sub
    syn keyword schemeGaucheExtFunc s64vector-sub!
    syn keyword schemeGaucheExtFunc s64vector-swap-bytes
    syn keyword schemeGaucheExtFunc s64vector-swap-bytes!
    syn keyword schemeGaucheExtFunc s64vector-xor
    syn keyword schemeGaucheExtFunc s64vector-xor!
    syn keyword schemeGaucheExtFunc s64vector?
    syn keyword schemeGaucheExtFunc s8vector
    syn keyword schemeGaucheExtFunc s8vector->list
    syn keyword schemeGaucheExtFunc s8vector->string
    syn keyword schemeGaucheExtFunc s8vector->vector
    syn keyword schemeGaucheExtFunc s8vector-add
    syn keyword schemeGaucheExtFunc s8vector-add!
    syn keyword schemeGaucheExtFunc s8vector-and
    syn keyword schemeGaucheExtFunc s8vector-and!
    syn keyword schemeGaucheExtFunc s8vector-clamp
    syn keyword schemeGaucheExtFunc s8vector-clamp!
    syn keyword schemeGaucheExtFunc s8vector-copy
    syn keyword schemeGaucheExtFunc s8vector-copy!
    syn keyword schemeGaucheExtFunc s8vector-dot
    syn keyword schemeGaucheExtFunc s8vector-fill!
    syn keyword schemeGaucheExtFunc s8vector-ior
    syn keyword schemeGaucheExtFunc s8vector-ior!
    syn keyword schemeGaucheExtFunc s8vector-length
    syn keyword schemeGaucheExtFunc s8vector-mul
    syn keyword schemeGaucheExtFunc s8vector-mul!
    syn keyword schemeGaucheExtFunc s8vector-range-check
    syn keyword schemeGaucheExtFunc s8vector-ref
    syn keyword schemeGaucheExtFunc s8vector-set!
    syn keyword schemeGaucheExtFunc s8vector-sub
    syn keyword schemeGaucheExtFunc s8vector-sub!
    syn keyword schemeGaucheExtFunc s8vector-xor
    syn keyword schemeGaucheExtFunc s8vector-xor!
    syn keyword schemeGaucheExtFunc s8vector?
    syn keyword schemeGaucheExtFunc second
    syn keyword schemeGaucheExtFunc seconds->time
    syn keyword schemeGaucheExtFunc select-first-kid
    syn keyword schemeGaucheExtFunc select-kids
    syn keyword schemeGaucheExtFunc select-tmodule
    syn keyword schemeGaucheExtFunc serializer?
    syn keyword schemeGaucheExtFunc set-random-seed!
    syn keyword schemeGaucheExtFunc set-signal-handler!
    syn keyword schemeGaucheExtFunc set-signal-pending-limit
    syn keyword schemeGaucheExtFunc setenv!
    syn keyword schemeGaucheExtFunc setter
    syn keyword schemeGaucheExtFunc setter of dict-get
    syn keyword schemeGaucheExtFunc setter of instance-pool-of
    syn keyword schemeGaucheExtFunc setter of instance-pools-of
    syn keyword schemeGaucheExtFunc setter of object-apply
    syn keyword schemeGaucheExtFunc setter of ref
    syn keyword schemeGaucheExtFunc seventh
    syn keyword schemeGaucheExtFunc sha1-digest
    syn keyword schemeGaucheExtFunc sha1-digest-string
    syn keyword schemeGaucheExtFunc sha224-digest
    syn keyword schemeGaucheExtFunc sha224-digest-string
    syn keyword schemeGaucheExtFunc sha256-digest
    syn keyword schemeGaucheExtFunc sha256-digest-string
    syn keyword schemeGaucheExtFunc sha384-digest
    syn keyword schemeGaucheExtFunc sha384-digest-string
    syn keyword schemeGaucheExtFunc sha512-digest
    syn keyword schemeGaucheExtFunc sha512-digest-string
    syn keyword schemeGaucheExtFunc shape
    syn keyword schemeGaucheExtFunc shape-for-each
    syn keyword schemeGaucheExtFunc share-array
    syn keyword schemeGaucheExtFunc shell-escape-string
    syn keyword schemeGaucheExtFunc simplify-path
    syn keyword schemeGaucheExtFunc sinh
    syn keyword schemeGaucheExtFunc sixth
    syn keyword schemeGaucheExtFunc skip-until
    syn keyword schemeGaucheExtFunc skip-while
    syn keyword schemeGaucheExtFunc slices
    syn keyword schemeGaucheExtFunc slot-bound-using-accessor?
    syn keyword schemeGaucheExtFunc slot-bound?
    syn keyword schemeGaucheExtFunc slot-definition-accessor
    syn keyword schemeGaucheExtFunc slot-definition-allocation
    syn keyword schemeGaucheExtFunc slot-definition-getter
    syn keyword schemeGaucheExtFunc slot-definition-name
    syn keyword schemeGaucheExtFunc slot-definition-option
    syn keyword schemeGaucheExtFunc slot-definition-options
    syn keyword schemeGaucheExtFunc slot-definition-setter
    syn keyword schemeGaucheExtFunc slot-exists?
    syn keyword schemeGaucheExtFunc slot-initialize-using-accessor!
    syn keyword schemeGaucheExtFunc slot-pop!
    syn keyword schemeGaucheExtFunc slot-push!
    syn keyword schemeGaucheExtFunc slot-ref
    syn keyword schemeGaucheExtFunc slot-ref-using-accessor
    syn keyword schemeGaucheExtFunc slot-set!
    syn keyword schemeGaucheExtFunc slot-set-using-accessor!
    syn keyword schemeGaucheExtFunc socket-accept
    syn keyword schemeGaucheExtFunc socket-address
    syn keyword schemeGaucheExtFunc socket-bind
    syn keyword schemeGaucheExtFunc socket-buildmsg
    syn keyword schemeGaucheExtFunc socket-close
    syn keyword schemeGaucheExtFunc socket-connect
    syn keyword schemeGaucheExtFunc socket-fd
    syn keyword schemeGaucheExtFunc socket-getpeername
    syn keyword schemeGaucheExtFunc socket-getsockname
    syn keyword schemeGaucheExtFunc socket-getsockopt
    syn keyword schemeGaucheExtFunc socket-input-port
    syn keyword schemeGaucheExtFunc socket-ioctl
    syn keyword schemeGaucheExtFunc socket-listen
    syn keyword schemeGaucheExtFunc socket-output-port
    syn keyword schemeGaucheExtFunc socket-recv
    syn keyword schemeGaucheExtFunc socket-recv!
    syn keyword schemeGaucheExtFunc socket-recvfrom
    syn keyword schemeGaucheExtFunc socket-recvfrom!
    syn keyword schemeGaucheExtFunc socket-send
    syn keyword schemeGaucheExtFunc socket-sendmsg
    syn keyword schemeGaucheExtFunc socket-sendto
    syn keyword schemeGaucheExtFunc socket-setsockopt
    syn keyword schemeGaucheExtFunc socket-shutdown
    syn keyword schemeGaucheExtFunc socket-status
    syn keyword schemeGaucheExtFunc sort
    syn keyword schemeGaucheExtFunc sort!
    syn keyword schemeGaucheExtFunc sort-by
    syn keyword schemeGaucheExtFunc sort-by!
    syn keyword schemeGaucheExtFunc sorted?
    syn keyword schemeGaucheExtFunc space
    syn keyword schemeGaucheExtFunc spaces
    syn keyword schemeGaucheExtFunc span
    syn keyword schemeGaucheExtFunc span!
    syn keyword schemeGaucheExtFunc sparse-table-clear!
    syn keyword schemeGaucheExtFunc sparse-table-copy
    syn keyword schemeGaucheExtFunc sparse-table-delete!
    syn keyword schemeGaucheExtFunc sparse-table-exists?
    syn keyword schemeGaucheExtFunc sparse-table-fold
    syn keyword schemeGaucheExtFunc sparse-table-for-each
    syn keyword schemeGaucheExtFunc sparse-table-keys
    syn keyword schemeGaucheExtFunc sparse-table-map
    syn keyword schemeGaucheExtFunc sparse-table-num-entries
    syn keyword schemeGaucheExtFunc sparse-table-pop!
    syn keyword schemeGaucheExtFunc sparse-table-push!
    syn keyword schemeGaucheExtFunc sparse-table-ref
    syn keyword schemeGaucheExtFunc sparse-table-set!
    syn keyword schemeGaucheExtFunc sparse-table-update!
    syn keyword schemeGaucheExtFunc sparse-table-values
    syn keyword schemeGaucheExtFunc sparse-vector-clear!
    syn keyword schemeGaucheExtFunc sparse-vector-copy
    syn keyword schemeGaucheExtFunc sparse-vector-delete!
    syn keyword schemeGaucheExtFunc sparse-vector-exists?
    syn keyword schemeGaucheExtFunc sparse-vector-fold
    syn keyword schemeGaucheExtFunc sparse-vector-for-each
    syn keyword schemeGaucheExtFunc sparse-vector-inc!
    syn keyword schemeGaucheExtFunc sparse-vector-keys
    syn keyword schemeGaucheExtFunc sparse-vector-map
    syn keyword schemeGaucheExtFunc sparse-vector-max-index-bits
    syn keyword schemeGaucheExtFunc sparse-vector-num-entries
    syn keyword schemeGaucheExtFunc sparse-vector-pop!
    syn keyword schemeGaucheExtFunc sparse-vector-push!
    syn keyword schemeGaucheExtFunc sparse-vector-ref
    syn keyword schemeGaucheExtFunc sparse-vector-set!
    syn keyword schemeGaucheExtFunc sparse-vector-update!
    syn keyword schemeGaucheExtFunc sparse-vector-values
    syn keyword schemeGaucheExtFunc split-at
    syn keyword schemeGaucheExtFunc split-at!
    syn keyword schemeGaucheExtFunc split-at*
    syn keyword schemeGaucheExtFunc split-string
    syn keyword schemeGaucheExtFunc sql-tokenize
    syn keyword schemeGaucheExtFunc srfi-42--dispatch
    syn keyword schemeGaucheExtFunc srfi-42--dispatch-ref
    syn keyword schemeGaucheExtFunc srfi-42--dispatch-set!
    syn keyword schemeGaucheExtFunc srl:display-sxml
    syn keyword schemeGaucheExtFunc srl:parameterizable
    syn keyword schemeGaucheExtFunc srl:sxml->html
    syn keyword schemeGaucheExtFunc srl:sxml->html-noindent
    syn keyword schemeGaucheExtFunc srl:sxml->string
    syn keyword schemeGaucheExtFunc srl:sxml->xml
    syn keyword schemeGaucheExtFunc srl:sxml->xml-noindent
    syn keyword schemeGaucheExtFunc ssax:assert-token
    syn keyword schemeGaucheExtFunc ssax:complete-start-tag
    syn keyword schemeGaucheExtFunc ssax:handle-parsed-entity
    syn keyword schemeGaucheExtFunc ssax:ncname-starting-char?
    syn keyword schemeGaucheExtFunc ssax:read-NCName
    syn keyword schemeGaucheExtFunc ssax:read-QName
    syn keyword schemeGaucheExtFunc ssax:read-attributes
    syn keyword schemeGaucheExtFunc ssax:read-cdata-body
    syn keyword schemeGaucheExtFunc ssax:read-char-data
    syn keyword schemeGaucheExtFunc ssax:read-char-ref
    syn keyword schemeGaucheExtFunc ssax:read-external-id
    syn keyword schemeGaucheExtFunc ssax:read-markup-token
    syn keyword schemeGaucheExtFunc ssax:read-pi-body-as-string
    syn keyword schemeGaucheExtFunc ssax:resolve-name
    syn keyword schemeGaucheExtFunc ssax:reverse-collect-str
    syn keyword schemeGaucheExtFunc ssax:reverse-collect-str-drop-ws
    syn keyword schemeGaucheExtFunc ssax:scan-Misc
    syn keyword schemeGaucheExtFunc ssax:skip-S
    syn keyword schemeGaucheExtFunc ssax:skip-internal-dtd
    syn keyword schemeGaucheExtFunc ssax:skip-pi
    syn keyword schemeGaucheExtFunc ssax:uri-string->symbol
    syn keyword schemeGaucheExtFunc ssax:warn
    syn keyword schemeGaucheExtFunc ssax:xml->sxml
    syn keyword schemeGaucheExtFunc stable-sort
    syn keyword schemeGaucheExtFunc stable-sort!
    syn keyword schemeGaucheExtFunc stable-sort-by
    syn keyword schemeGaucheExtFunc stable-sort-by!
    syn keyword schemeGaucheExtFunc standard-error-port
    syn keyword schemeGaucheExtFunc standard-input-port
    syn keyword schemeGaucheExtFunc standard-output-port
    syn keyword schemeGaucheExtFunc store-bundle!
    syn keyword schemeGaucheExtFunc stream
    syn keyword schemeGaucheExtFunc stream->list
    syn keyword schemeGaucheExtFunc stream->number
    syn keyword schemeGaucheExtFunc stream->string
    syn keyword schemeGaucheExtFunc stream->symbol
    syn keyword schemeGaucheExtFunc stream-any
    syn keyword schemeGaucheExtFunc stream-append
    syn keyword schemeGaucheExtFunc stream-break
    syn keyword schemeGaucheExtFunc stream-butlast
    syn keyword schemeGaucheExtFunc stream-butlast-n
    syn keyword schemeGaucheExtFunc stream-caaaar
    syn keyword schemeGaucheExtFunc stream-caaadr
    syn keyword schemeGaucheExtFunc stream-caaar
    syn keyword schemeGaucheExtFunc stream-caadar
    syn keyword schemeGaucheExtFunc stream-caaddr
    syn keyword schemeGaucheExtFunc stream-caadr
    syn keyword schemeGaucheExtFunc stream-caar
    syn keyword schemeGaucheExtFunc stream-cadaar
    syn keyword schemeGaucheExtFunc stream-cadadr
    syn keyword schemeGaucheExtFunc stream-cadar
    syn keyword schemeGaucheExtFunc stream-caddar
    syn keyword schemeGaucheExtFunc stream-cadddr
    syn keyword schemeGaucheExtFunc stream-caddr
    syn keyword schemeGaucheExtFunc stream-cadr
    syn keyword schemeGaucheExtFunc stream-car
    syn keyword schemeGaucheExtFunc stream-cdaaar
    syn keyword schemeGaucheExtFunc stream-cdaadr
    syn keyword schemeGaucheExtFunc stream-cdaar
    syn keyword schemeGaucheExtFunc stream-cdadar
    syn keyword schemeGaucheExtFunc stream-cdaddr
    syn keyword schemeGaucheExtFunc stream-cdadr
    syn keyword schemeGaucheExtFunc stream-cdar
    syn keyword schemeGaucheExtFunc stream-cddaar
    syn keyword schemeGaucheExtFunc stream-cddadr
    syn keyword schemeGaucheExtFunc stream-cddar
    syn keyword schemeGaucheExtFunc stream-cdddar
    syn keyword schemeGaucheExtFunc stream-cddddr
    syn keyword schemeGaucheExtFunc stream-cdddr
    syn keyword schemeGaucheExtFunc stream-cddr
    syn keyword schemeGaucheExtFunc stream-cdr
    syn keyword schemeGaucheExtFunc stream-concatenate
    syn keyword schemeGaucheExtFunc stream-cons*
    syn keyword schemeGaucheExtFunc stream-count
    syn keyword schemeGaucheExtFunc stream-delete
    syn keyword schemeGaucheExtFunc stream-delete-duplicates
    syn keyword schemeGaucheExtFunc stream-drop
    syn keyword schemeGaucheExtFunc stream-drop-safe
    syn keyword schemeGaucheExtFunc stream-drop-while
    syn keyword schemeGaucheExtFunc stream-eighth
    syn keyword schemeGaucheExtFunc stream-every
    syn keyword schemeGaucheExtFunc stream-fifth
    syn keyword schemeGaucheExtFunc stream-filter
    syn keyword schemeGaucheExtFunc stream-find
    syn keyword schemeGaucheExtFunc stream-find-tail
    syn keyword schemeGaucheExtFunc stream-first
    syn keyword schemeGaucheExtFunc stream-for-each
    syn keyword schemeGaucheExtFunc stream-format
    syn keyword schemeGaucheExtFunc stream-fourth
    syn keyword schemeGaucheExtFunc stream-grep
    syn keyword schemeGaucheExtFunc stream-index
    syn keyword schemeGaucheExtFunc stream-intersperse
    syn keyword schemeGaucheExtFunc stream-iota
    syn keyword schemeGaucheExtFunc stream-last
    syn keyword schemeGaucheExtFunc stream-last-n
    syn keyword schemeGaucheExtFunc stream-length
    syn keyword schemeGaucheExtFunc stream-length>=
    syn keyword schemeGaucheExtFunc stream-lines
    syn keyword schemeGaucheExtFunc stream-map
    syn keyword schemeGaucheExtFunc stream-member
    syn keyword schemeGaucheExtFunc stream-memq
    syn keyword schemeGaucheExtFunc stream-memv
    syn keyword schemeGaucheExtFunc stream-ninth
    syn keyword schemeGaucheExtFunc stream-null?
    syn keyword schemeGaucheExtFunc stream-pair?
    syn keyword schemeGaucheExtFunc stream-partition
    syn keyword schemeGaucheExtFunc stream-prefix=
    syn keyword schemeGaucheExtFunc stream-ref
    syn keyword schemeGaucheExtFunc stream-remove
    syn keyword schemeGaucheExtFunc stream-replace
    syn keyword schemeGaucheExtFunc stream-reverse
    syn keyword schemeGaucheExtFunc stream-second
    syn keyword schemeGaucheExtFunc stream-seventh
    syn keyword schemeGaucheExtFunc stream-sixth
    syn keyword schemeGaucheExtFunc stream-span
    syn keyword schemeGaucheExtFunc stream-split
    syn keyword schemeGaucheExtFunc stream-tabulate
    syn keyword schemeGaucheExtFunc stream-take
    syn keyword schemeGaucheExtFunc stream-take-safe
    syn keyword schemeGaucheExtFunc stream-take-while
    syn keyword schemeGaucheExtFunc stream-tenth
    syn keyword schemeGaucheExtFunc stream-third
    syn keyword schemeGaucheExtFunc stream-translate
    syn keyword schemeGaucheExtFunc stream-unfoldn
    syn keyword schemeGaucheExtFunc stream-xcons
    syn keyword schemeGaucheExtFunc stream=
    syn keyword schemeGaucheExtFunc stream?
    syn keyword schemeGaucheExtFunc string->char-set
    syn keyword schemeGaucheExtFunc string->char-set!
    syn keyword schemeGaucheExtFunc string->date
    syn keyword schemeGaucheExtFunc string->generator
    syn keyword schemeGaucheExtFunc string->grapheme-clusters
    syn keyword schemeGaucheExtFunc string->peg-stream
    syn keyword schemeGaucheExtFunc string->regexp
    syn keyword schemeGaucheExtFunc string->s32vector
    syn keyword schemeGaucheExtFunc string->s8vector
    syn keyword schemeGaucheExtFunc string->s8vector!
    syn keyword schemeGaucheExtFunc string->stream
    syn keyword schemeGaucheExtFunc string->u32vector
    syn keyword schemeGaucheExtFunc string->u8vector
    syn keyword schemeGaucheExtFunc string->u8vector!
    syn keyword schemeGaucheExtFunc string->uninterned-symbol
    syn keyword schemeGaucheExtFunc string->words
    syn keyword schemeGaucheExtFunc string-any
    syn keyword schemeGaucheExtFunc string-append/shared
    syn keyword schemeGaucheExtFunc string-byte-ref
    syn keyword schemeGaucheExtFunc string-byte-set!
    syn keyword schemeGaucheExtFunc string-ci<
    syn keyword schemeGaucheExtFunc string-ci<=
    syn keyword schemeGaucheExtFunc string-ci<>
    syn keyword schemeGaucheExtFunc string-ci=
    syn keyword schemeGaucheExtFunc string-ci>
    syn keyword schemeGaucheExtFunc string-ci>=
    syn keyword schemeGaucheExtFunc string-compare
    syn keyword schemeGaucheExtFunc string-compare-ci
    syn keyword schemeGaucheExtFunc string-complete->incomplete
    syn keyword schemeGaucheExtFunc string-concatenate
    syn keyword schemeGaucheExtFunc string-concatenate-reverse
    syn keyword schemeGaucheExtFunc string-concatenate-reverse/shared
    syn keyword schemeGaucheExtFunc string-concatenate/shared
    syn keyword schemeGaucheExtFunc string-contains
    syn keyword schemeGaucheExtFunc string-contains-ci
    syn keyword schemeGaucheExtFunc string-copy!
    syn keyword schemeGaucheExtFunc string-count
    syn keyword schemeGaucheExtFunc string-delete
    syn keyword schemeGaucheExtFunc string-downcase
    syn keyword schemeGaucheExtFunc string-downcase!
    syn keyword schemeGaucheExtFunc string-drop
    syn keyword schemeGaucheExtFunc string-drop-right
    syn keyword schemeGaucheExtFunc string-every
    syn keyword schemeGaucheExtFunc string-fill!
    syn keyword schemeGaucheExtFunc string-filter
    syn keyword schemeGaucheExtFunc string-find
    syn keyword schemeGaucheExtFunc string-fold
    syn keyword schemeGaucheExtFunc string-fold-right
    syn keyword schemeGaucheExtFunc string-foldcase
    syn keyword schemeGaucheExtFunc string-for-each
    syn keyword schemeGaucheExtFunc string-for-each-index
    syn keyword schemeGaucheExtFunc string-hash
    syn keyword schemeGaucheExtFunc string-hash-ci
    syn keyword schemeGaucheExtFunc string-immutable?
    syn keyword schemeGaucheExtFunc string-incomplete->complete
    syn keyword schemeGaucheExtFunc string-incomplete->complete!
    syn keyword schemeGaucheExtFunc string-incomplete?
    syn keyword schemeGaucheExtFunc string-index
    syn keyword schemeGaucheExtFunc string-index-right
    syn keyword schemeGaucheExtFunc string-interpolate
    syn keyword schemeGaucheExtFunc string-join
    syn keyword schemeGaucheExtFunc string-kmp-partial-search
    syn keyword schemeGaucheExtFunc string-lower
    syn keyword schemeGaucheExtFunc string-map
    syn keyword schemeGaucheExtFunc string-map!
    syn keyword schemeGaucheExtFunc string-null?
    syn keyword schemeGaucheExtFunc string-pad
    syn keyword schemeGaucheExtFunc string-pad-right
    syn keyword schemeGaucheExtFunc string-parse-final-start+end
    syn keyword schemeGaucheExtFunc string-parse-start+end
    syn keyword schemeGaucheExtFunc string-pointer-byte-index
    syn keyword schemeGaucheExtFunc string-pointer-copy
    syn keyword schemeGaucheExtFunc string-pointer-index
    syn keyword schemeGaucheExtFunc string-pointer-next!
    syn keyword schemeGaucheExtFunc string-pointer-prev!
    syn keyword schemeGaucheExtFunc string-pointer-ref
    syn keyword schemeGaucheExtFunc string-pointer-set!
    syn keyword schemeGaucheExtFunc string-pointer-substring
    syn keyword schemeGaucheExtFunc string-pointer?
    syn keyword schemeGaucheExtFunc string-prefix-ci?
    syn keyword schemeGaucheExtFunc string-prefix-length
    syn keyword schemeGaucheExtFunc string-prefix-length-ci
    syn keyword schemeGaucheExtFunc string-prefix?
    syn keyword schemeGaucheExtFunc string-replace
    syn keyword schemeGaucheExtFunc string-reverse
    syn keyword schemeGaucheExtFunc string-reverse!
    syn keyword schemeGaucheExtFunc string-rindex
    syn keyword schemeGaucheExtFunc string-scan
    syn keyword schemeGaucheExtFunc string-size
    syn keyword schemeGaucheExtFunc string-skip
    syn keyword schemeGaucheExtFunc string-skip-right
    syn keyword schemeGaucheExtFunc string-split
    syn keyword schemeGaucheExtFunc string-suffix-ci?
    syn keyword schemeGaucheExtFunc string-suffix-length
    syn keyword schemeGaucheExtFunc string-suffix-length-ci
    syn keyword schemeGaucheExtFunc string-suffix?
    syn keyword schemeGaucheExtFunc string-tabulate
    syn keyword schemeGaucheExtFunc string-take
    syn keyword schemeGaucheExtFunc string-take-right
    syn keyword schemeGaucheExtFunc string-titlecase
    syn keyword schemeGaucheExtFunc string-titlecase!
    syn keyword schemeGaucheExtFunc string-tokenize
    syn keyword schemeGaucheExtFunc string-tr
    syn keyword schemeGaucheExtFunc string-transliterate
    syn keyword schemeGaucheExtFunc string-trim
    syn keyword schemeGaucheExtFunc string-trim-both
    syn keyword schemeGaucheExtFunc string-trim-right
    syn keyword schemeGaucheExtFunc string-unfold
    syn keyword schemeGaucheExtFunc string-unfold-right
    syn keyword schemeGaucheExtFunc string-upcase
    syn keyword schemeGaucheExtFunc string-upcase!
    syn keyword schemeGaucheExtFunc string-upper
    syn keyword schemeGaucheExtFunc string-whitespace?
    syn keyword schemeGaucheExtFunc string-xcopy!
    syn keyword schemeGaucheExtFunc string<
    syn keyword schemeGaucheExtFunc string<=
    syn keyword schemeGaucheExtFunc string<>
    syn keyword schemeGaucheExtFunc string=
    syn keyword schemeGaucheExtFunc string>
    syn keyword schemeGaucheExtFunc string>=
    syn keyword schemeGaucheExtFunc subarray
    syn keyword schemeGaucheExtFunc subr?
    syn keyword schemeGaucheExtFunc substring-spec-ok?
    syn keyword schemeGaucheExtFunc substring/shared
    syn keyword schemeGaucheExtFunc substring?
    syn keyword schemeGaucheExtFunc subtract-duration
    syn keyword schemeGaucheExtFunc subtract-duration!
    syn keyword schemeGaucheExtFunc supported-character-encoding?
    syn keyword schemeGaucheExtFunc supported-character-encodings
    syn keyword schemeGaucheExtFunc sxml:add-attr
    syn keyword schemeGaucheExtFunc sxml:add-attr!
    syn keyword schemeGaucheExtFunc sxml:add-aux
    syn keyword schemeGaucheExtFunc sxml:add-aux!
    syn keyword schemeGaucheExtFunc sxml:add-parents
    syn keyword schemeGaucheExtFunc sxml:ancestor
    syn keyword schemeGaucheExtFunc sxml:ancestor-or-self
    syn keyword schemeGaucheExtFunc sxml:attr
    syn keyword schemeGaucheExtFunc sxml:attr->html
    syn keyword schemeGaucheExtFunc sxml:attr->xml
    syn keyword schemeGaucheExtFunc sxml:attr-as-list
    syn keyword schemeGaucheExtFunc sxml:attr-list
    syn keyword schemeGaucheExtFunc sxml:attr-list-node
    syn keyword schemeGaucheExtFunc sxml:attr-list-u
    syn keyword schemeGaucheExtFunc sxml:attr-u
    syn keyword schemeGaucheExtFunc sxml:attribute
    syn keyword schemeGaucheExtFunc sxml:aux-as-list
    syn keyword schemeGaucheExtFunc sxml:aux-list
    syn keyword schemeGaucheExtFunc sxml:aux-list-node
    syn keyword schemeGaucheExtFunc sxml:aux-list-u
    syn keyword schemeGaucheExtFunc sxml:aux-node
    syn keyword schemeGaucheExtFunc sxml:aux-nodes
    syn keyword schemeGaucheExtFunc sxml:boolean
    syn keyword schemeGaucheExtFunc sxml:change-attr
    syn keyword schemeGaucheExtFunc sxml:change-attr!
    syn keyword schemeGaucheExtFunc sxml:change-attrlist
    syn keyword schemeGaucheExtFunc sxml:change-attrlist!
    syn keyword schemeGaucheExtFunc sxml:change-content
    syn keyword schemeGaucheExtFunc sxml:change-content!
    syn keyword schemeGaucheExtFunc sxml:change-name
    syn keyword schemeGaucheExtFunc sxml:change-name!
    syn keyword schemeGaucheExtFunc sxml:child
    syn keyword schemeGaucheExtFunc sxml:child-elements
    syn keyword schemeGaucheExtFunc sxml:child-nodes
    syn keyword schemeGaucheExtFunc sxml:clean
    syn keyword schemeGaucheExtFunc sxml:clean-feed
    syn keyword schemeGaucheExtFunc sxml:content
    syn keyword schemeGaucheExtFunc sxml:content-raw
    syn keyword schemeGaucheExtFunc sxml:descendant
    syn keyword schemeGaucheExtFunc sxml:descendant-or-self
    syn keyword schemeGaucheExtFunc sxml:element-name
    syn keyword schemeGaucheExtFunc sxml:element?
    syn keyword schemeGaucheExtFunc sxml:empty-element?
    syn keyword schemeGaucheExtFunc sxml:equal?
    syn keyword schemeGaucheExtFunc sxml:equality-cmp
    syn keyword schemeGaucheExtFunc sxml:error
    syn keyword schemeGaucheExtFunc sxml:filter
    syn keyword schemeGaucheExtFunc sxml:following
    syn keyword schemeGaucheExtFunc sxml:following-sibling
    syn keyword schemeGaucheExtFunc sxml:id
    syn keyword schemeGaucheExtFunc sxml:id-alist
    syn keyword schemeGaucheExtFunc sxml:invert
    syn keyword schemeGaucheExtFunc sxml:lookup
    syn keyword schemeGaucheExtFunc sxml:minimized?
    syn keyword schemeGaucheExtFunc sxml:name
    syn keyword schemeGaucheExtFunc sxml:name->ns-id
    syn keyword schemeGaucheExtFunc sxml:namespace
    syn keyword schemeGaucheExtFunc sxml:ncname
    syn keyword schemeGaucheExtFunc sxml:node-name
    syn keyword schemeGaucheExtFunc sxml:node-parent
    syn keyword schemeGaucheExtFunc sxml:node?
    syn keyword schemeGaucheExtFunc sxml:non-terminated-html-tag?
    syn keyword schemeGaucheExtFunc sxml:normalized?
    syn keyword schemeGaucheExtFunc sxml:not-equal?
    syn keyword schemeGaucheExtFunc sxml:ns-id
    syn keyword schemeGaucheExtFunc sxml:ns-id->nodes
    syn keyword schemeGaucheExtFunc sxml:ns-id->uri
    syn keyword schemeGaucheExtFunc sxml:ns-list
    syn keyword schemeGaucheExtFunc sxml:ns-prefix
    syn keyword schemeGaucheExtFunc sxml:ns-uri
    syn keyword schemeGaucheExtFunc sxml:ns-uri->id
    syn keyword schemeGaucheExtFunc sxml:ns-uri->nodes
    syn keyword schemeGaucheExtFunc sxml:num-attr
    syn keyword schemeGaucheExtFunc sxml:number
    syn keyword schemeGaucheExtFunc sxml:parent
    syn keyword schemeGaucheExtFunc sxml:preceding
    syn keyword schemeGaucheExtFunc sxml:preceding-sibling
    syn keyword schemeGaucheExtFunc sxml:relational-cmp
    syn keyword schemeGaucheExtFunc sxml:set-attr
    syn keyword schemeGaucheExtFunc sxml:set-attr!
    syn keyword schemeGaucheExtFunc sxml:shallow-minimized?
    syn keyword schemeGaucheExtFunc sxml:shallow-normalized?
    syn keyword schemeGaucheExtFunc sxml:squeeze
    syn keyword schemeGaucheExtFunc sxml:squeeze!
    syn keyword schemeGaucheExtFunc sxml:string
    syn keyword schemeGaucheExtFunc sxml:string->html
    syn keyword schemeGaucheExtFunc sxml:string->xml
    syn keyword schemeGaucheExtFunc sxml:string-value
    syn keyword schemeGaucheExtFunc sxml:sxml->html
    syn keyword schemeGaucheExtFunc sxml:sxml->xml
    syn keyword schemeGaucheExtFunc sxpath
    syn keyword schemeGaucheExtFunc symbol->stream
    syn keyword schemeGaucheExtFunc symbol-bound?
    syn keyword schemeGaucheExtFunc symbol-interned?
    syn keyword schemeGaucheExtFunc symbol-sans-prefix
    syn keyword schemeGaucheExtFunc sys-abort
    syn keyword schemeGaucheExtFunc sys-access
    syn keyword schemeGaucheExtFunc sys-alarm
    syn keyword schemeGaucheExtFunc sys-asctime
    syn keyword schemeGaucheExtFunc sys-basename
    syn keyword schemeGaucheExtFunc sys-cfgetispeed
    syn keyword schemeGaucheExtFunc sys-cfgetospeed
    syn keyword schemeGaucheExtFunc sys-cfsetispeed
    syn keyword schemeGaucheExtFunc sys-cfsetospeed
    syn keyword schemeGaucheExtFunc sys-chdir
    syn keyword schemeGaucheExtFunc sys-chmod
    syn keyword schemeGaucheExtFunc sys-chown
    syn keyword schemeGaucheExtFunc sys-clearenv
    syn keyword schemeGaucheExtFunc sys-close
    syn keyword schemeGaucheExtFunc sys-closelog
    syn keyword schemeGaucheExtFunc sys-crypt
    syn keyword schemeGaucheExtFunc sys-ctermid
    syn keyword schemeGaucheExtFunc sys-ctime
    syn keyword schemeGaucheExtFunc sys-difftime
    syn keyword schemeGaucheExtFunc sys-dirname
    syn keyword schemeGaucheExtFunc sys-environ
    syn keyword schemeGaucheExtFunc sys-environ->alist
    syn keyword schemeGaucheExtFunc sys-exec
    syn keyword schemeGaucheExtFunc sys-exit
    syn keyword schemeGaucheExtFunc sys-fchmod
    syn keyword schemeGaucheExtFunc sys-fcntl
    syn keyword schemeGaucheExtFunc sys-fdset
    syn keyword schemeGaucheExtFunc sys-fdset->list
    syn keyword schemeGaucheExtFunc sys-fdset-clear!
    syn keyword schemeGaucheExtFunc sys-fdset-copy!
    syn keyword schemeGaucheExtFunc sys-fdset-max-fd
    syn keyword schemeGaucheExtFunc sys-fdset-ref
    syn keyword schemeGaucheExtFunc sys-fdset-set!
    syn keyword schemeGaucheExtFunc sys-fork
    syn keyword schemeGaucheExtFunc sys-fork-and-exec
    syn keyword schemeGaucheExtFunc sys-forkpty
    syn keyword schemeGaucheExtFunc sys-forkpty-and-exec
    syn keyword schemeGaucheExtFunc sys-fstat
    syn keyword schemeGaucheExtFunc sys-ftruncate
    syn keyword schemeGaucheExtFunc sys-getaddrinfo
    syn keyword schemeGaucheExtFunc sys-getcwd
    syn keyword schemeGaucheExtFunc sys-getdomainname
    syn keyword schemeGaucheExtFunc sys-getegid
    syn keyword schemeGaucheExtFunc sys-getenv
    syn keyword schemeGaucheExtFunc sys-geteuid
    syn keyword schemeGaucheExtFunc sys-getgid
    syn keyword schemeGaucheExtFunc sys-getgrgid
    syn keyword schemeGaucheExtFunc sys-getgrnam
    syn keyword schemeGaucheExtFunc sys-getgroups
    syn keyword schemeGaucheExtFunc sys-gethostbyaddr
    syn keyword schemeGaucheExtFunc sys-gethostbyname
    syn keyword schemeGaucheExtFunc sys-gethostname
    syn keyword schemeGaucheExtFunc sys-getloadavg
    syn keyword schemeGaucheExtFunc sys-getlogin
    syn keyword schemeGaucheExtFunc sys-getnameinfo
    syn keyword schemeGaucheExtFunc sys-getpgid
    syn keyword schemeGaucheExtFunc sys-getpgrp
    syn keyword schemeGaucheExtFunc sys-getpid
    syn keyword schemeGaucheExtFunc sys-getppid
    syn keyword schemeGaucheExtFunc sys-getprotobyname
    syn keyword schemeGaucheExtFunc sys-getprotobynumber
    syn keyword schemeGaucheExtFunc sys-getpwnam
    syn keyword schemeGaucheExtFunc sys-getpwuid
    syn keyword schemeGaucheExtFunc sys-getrlimit
    syn keyword schemeGaucheExtFunc sys-getservbyname
    syn keyword schemeGaucheExtFunc sys-getservbyport
    syn keyword schemeGaucheExtFunc sys-gettimeofday
    syn keyword schemeGaucheExtFunc sys-getuid
    syn keyword schemeGaucheExtFunc sys-gid->group-name
    syn keyword schemeGaucheExtFunc sys-glob
    syn keyword schemeGaucheExtFunc sys-gmtime
    syn keyword schemeGaucheExtFunc sys-group-name->gid
    syn keyword schemeGaucheExtFunc sys-htonl
    syn keyword schemeGaucheExtFunc sys-htons
    syn keyword schemeGaucheExtFunc sys-isatty
    syn keyword schemeGaucheExtFunc sys-kill
    syn keyword schemeGaucheExtFunc sys-lchown
    syn keyword schemeGaucheExtFunc sys-link
    syn keyword schemeGaucheExtFunc sys-localeconv
    syn keyword schemeGaucheExtFunc sys-localtime
    syn keyword schemeGaucheExtFunc sys-logmask
    syn keyword schemeGaucheExtFunc sys-lstat
    syn keyword schemeGaucheExtFunc sys-mkdir
    syn keyword schemeGaucheExtFunc sys-mkfifo
    syn keyword schemeGaucheExtFunc sys-mkstemp
    syn keyword schemeGaucheExtFunc sys-mktime
    syn keyword schemeGaucheExtFunc sys-nanosleep
    syn keyword schemeGaucheExtFunc sys-normalize-pathname
    syn keyword schemeGaucheExtFunc sys-ntohl
    syn keyword schemeGaucheExtFunc sys-ntohs
    syn keyword schemeGaucheExtFunc sys-openlog
    syn keyword schemeGaucheExtFunc sys-openpty
    syn keyword schemeGaucheExtFunc sys-pause
    syn keyword schemeGaucheExtFunc sys-pipe
    syn keyword schemeGaucheExtFunc sys-putenv
    syn keyword schemeGaucheExtFunc sys-random
    syn keyword schemeGaucheExtFunc sys-readdir
    syn keyword schemeGaucheExtFunc sys-readlink
    syn keyword schemeGaucheExtFunc sys-realpath
    syn keyword schemeGaucheExtFunc sys-remove
    syn keyword schemeGaucheExtFunc sys-rename
    syn keyword schemeGaucheExtFunc sys-rmdir
    syn keyword schemeGaucheExtFunc sys-select
    syn keyword schemeGaucheExtFunc sys-select!
    syn keyword schemeGaucheExtFunc sys-setenv
    syn keyword schemeGaucheExtFunc sys-setgid
    syn keyword schemeGaucheExtFunc sys-setlocale
    syn keyword schemeGaucheExtFunc sys-setlogmask
    syn keyword schemeGaucheExtFunc sys-setpgid
    syn keyword schemeGaucheExtFunc sys-setrlimit
    syn keyword schemeGaucheExtFunc sys-setsid
    syn keyword schemeGaucheExtFunc sys-setuid
    syn keyword schemeGaucheExtFunc sys-sigmask
    syn keyword schemeGaucheExtFunc sys-signal-name
    syn keyword schemeGaucheExtFunc sys-sigset
    syn keyword schemeGaucheExtFunc sys-sigset-add!
    syn keyword schemeGaucheExtFunc sys-sigset-delete!
    syn keyword schemeGaucheExtFunc sys-sigset-empty!
    syn keyword schemeGaucheExtFunc sys-sigset-fill!
    syn keyword schemeGaucheExtFunc sys-sigsuspend
    syn keyword schemeGaucheExtFunc sys-sigwait
    syn keyword schemeGaucheExtFunc sys-sleep
    syn keyword schemeGaucheExtFunc sys-srandom
    syn keyword schemeGaucheExtFunc sys-stat
    syn keyword schemeGaucheExtFunc sys-stat->atime
    syn keyword schemeGaucheExtFunc sys-stat->ctime
    syn keyword schemeGaucheExtFunc sys-stat->dev
    syn keyword schemeGaucheExtFunc sys-stat->file-type
    syn keyword schemeGaucheExtFunc sys-stat->gid
    syn keyword schemeGaucheExtFunc sys-stat->ino
    syn keyword schemeGaucheExtFunc sys-stat->mode
    syn keyword schemeGaucheExtFunc sys-stat->mtime
    syn keyword schemeGaucheExtFunc sys-stat->nlink
    syn keyword schemeGaucheExtFunc sys-stat->rdev
    syn keyword schemeGaucheExtFunc sys-stat->size
    syn keyword schemeGaucheExtFunc sys-stat->type
    syn keyword schemeGaucheExtFunc sys-stat->uid
    syn keyword schemeGaucheExtFunc sys-strerror
    syn keyword schemeGaucheExtFunc sys-strftime
    syn keyword schemeGaucheExtFunc sys-symlink
    syn keyword schemeGaucheExtFunc sys-syslog
    syn keyword schemeGaucheExtFunc sys-system
    syn keyword schemeGaucheExtFunc sys-tcdrain
    syn keyword schemeGaucheExtFunc sys-tcflow
    syn keyword schemeGaucheExtFunc sys-tcflush
    syn keyword schemeGaucheExtFunc sys-tcgetattr
    syn keyword schemeGaucheExtFunc sys-tcgetpgrp
    syn keyword schemeGaucheExtFunc sys-tcsendbreak
    syn keyword schemeGaucheExtFunc sys-tcsetattr
    syn keyword schemeGaucheExtFunc sys-tcsetpgrp
    syn keyword schemeGaucheExtFunc sys-time
    syn keyword schemeGaucheExtFunc sys-times
    syn keyword schemeGaucheExtFunc sys-tm->alist
    syn keyword schemeGaucheExtFunc sys-tmpdir
    syn keyword schemeGaucheExtFunc sys-tmpnam
    syn keyword schemeGaucheExtFunc sys-truncate
    syn keyword schemeGaucheExtFunc sys-ttyname
    syn keyword schemeGaucheExtFunc sys-uid->user-name
    syn keyword schemeGaucheExtFunc sys-umask
    syn keyword schemeGaucheExtFunc sys-uname
    syn keyword schemeGaucheExtFunc sys-unlink
    syn keyword schemeGaucheExtFunc sys-unsetenv
    syn keyword schemeGaucheExtFunc sys-user-name->uid
    syn keyword schemeGaucheExtFunc sys-utime
    syn keyword schemeGaucheExtFunc sys-wait
    syn keyword schemeGaucheExtFunc sys-wait-exit-status
    syn keyword schemeGaucheExtFunc sys-wait-exited?
    syn keyword schemeGaucheExtFunc sys-wait-signaled?
    syn keyword schemeGaucheExtFunc sys-wait-stopped?
    syn keyword schemeGaucheExtFunc sys-wait-stopsig
    syn keyword schemeGaucheExtFunc sys-wait-termsig
    syn keyword schemeGaucheExtFunc sys-waitpid
    syn keyword schemeGaucheExtFunc system
    syn keyword schemeGaucheExtFunc tab
    syn keyword schemeGaucheExtFunc tabulate-array
    syn keyword schemeGaucheExtFunc take
    syn keyword schemeGaucheExtFunc take!
    syn keyword schemeGaucheExtFunc take*
    syn keyword schemeGaucheExtFunc take-after
    syn keyword schemeGaucheExtFunc take-right
    syn keyword schemeGaucheExtFunc take-right*
    syn keyword schemeGaucheExtFunc take-until
    syn keyword schemeGaucheExtFunc take-while
    syn keyword schemeGaucheExtFunc take-while!
    syn keyword schemeGaucheExtFunc tanh
    syn keyword schemeGaucheExtFunc temporary-file-name
    syn keyword schemeGaucheExtFunc tenth
    syn keyword schemeGaucheExtFunc terminate-all!
    syn keyword schemeGaucheExtFunc terminated-thread-exception?
    syn keyword schemeGaucheExtFunc test
    syn keyword schemeGaucheExtFunc test-check
    syn keyword schemeGaucheExtFunc test-end
    syn keyword schemeGaucheExtFunc test-error
    syn keyword schemeGaucheExtFunc test-error?
    syn keyword schemeGaucheExtFunc test-module
    syn keyword schemeGaucheExtFunc test-one-of
    syn keyword schemeGaucheExtFunc test-record-file
    syn keyword schemeGaucheExtFunc test-section
    syn keyword schemeGaucheExtFunc test-start
    syn keyword schemeGaucheExtFunc textdomain
    syn keyword schemeGaucheExtFunc third
    syn keyword schemeGaucheExtFunc thread-cont!
    syn keyword schemeGaucheExtFunc thread-join!
    syn keyword schemeGaucheExtFunc thread-name
    syn keyword schemeGaucheExtFunc thread-pool-results
    syn keyword schemeGaucheExtFunc thread-pool-shut-down?
    syn keyword schemeGaucheExtFunc thread-sleep!
    syn keyword schemeGaucheExtFunc thread-specific
    syn keyword schemeGaucheExtFunc thread-specific-set!
    syn keyword schemeGaucheExtFunc thread-start!
    syn keyword schemeGaucheExtFunc thread-state
    syn keyword schemeGaucheExtFunc thread-stop!
    syn keyword schemeGaucheExtFunc thread-terminate!
    syn keyword schemeGaucheExtFunc thread-yield!
    syn keyword schemeGaucheExtFunc thread?
    syn keyword schemeGaucheExtFunc time->seconds
    syn keyword schemeGaucheExtFunc time-difference
    syn keyword schemeGaucheExtFunc time-difference!
    syn keyword schemeGaucheExtFunc time-monotonic->date
    syn keyword schemeGaucheExtFunc time-monotonic->julian-day
    syn keyword schemeGaucheExtFunc time-monotonic->modified-julian-day
    syn keyword schemeGaucheExtFunc time-monotonic->time-tai
    syn keyword schemeGaucheExtFunc time-monotonic->time-tai!
    syn keyword schemeGaucheExtFunc time-monotonic->time-utc
    syn keyword schemeGaucheExtFunc time-monotonic->time-utc!
    syn keyword schemeGaucheExtFunc time-resolution
    syn keyword schemeGaucheExtFunc time-result+
    syn keyword schemeGaucheExtFunc time-result-
    syn keyword schemeGaucheExtFunc time-tai->date
    syn keyword schemeGaucheExtFunc time-tai->julian-day
    syn keyword schemeGaucheExtFunc time-tai->modified-julian-day
    syn keyword schemeGaucheExtFunc time-tai->time-monotonic
    syn keyword schemeGaucheExtFunc time-tai->time-monotonic!
    syn keyword schemeGaucheExtFunc time-tai->time-utc
    syn keyword schemeGaucheExtFunc time-tai->time-utc!
    syn keyword schemeGaucheExtFunc time-these
    syn keyword schemeGaucheExtFunc time-these/report
    syn keyword schemeGaucheExtFunc time-this
    syn keyword schemeGaucheExtFunc time-utc->date
    syn keyword schemeGaucheExtFunc time-utc->julian-day
    syn keyword schemeGaucheExtFunc time-utc->modified-julian-day
    syn keyword schemeGaucheExtFunc time-utc->time-monotonic
    syn keyword schemeGaucheExtFunc time-utc->time-monotonic!
    syn keyword schemeGaucheExtFunc time-utc->time-tai
    syn keyword schemeGaucheExtFunc time-utc->time-tai!
    syn keyword schemeGaucheExtFunc time<=?
    syn keyword schemeGaucheExtFunc time<?
    syn keyword schemeGaucheExtFunc time=?
    syn keyword schemeGaucheExtFunc time>=?
    syn keyword schemeGaucheExtFunc time>?
    syn keyword schemeGaucheExtFunc time?
    syn keyword schemeGaucheExtFunc tmodule-cname
    syn keyword schemeGaucheExtFunc toplevel-closure?
    syn keyword schemeGaucheExtFunc topological-sort
    syn keyword schemeGaucheExtFunc touch-file
    syn keyword schemeGaucheExtFunc touch-instance!
    syn keyword schemeGaucheExtFunc tr
    syn keyword schemeGaucheExtFunc transliterate
    syn keyword schemeGaucheExtFunc tree->string
    syn keyword schemeGaucheExtFunc tree-fold
    syn keyword schemeGaucheExtFunc tree-fold-bf
    syn keyword schemeGaucheExtFunc tree-map->alist
    syn keyword schemeGaucheExtFunc tree-map-ceiling
    syn keyword schemeGaucheExtFunc tree-map-ceiling-key
    syn keyword schemeGaucheExtFunc tree-map-ceiling-value
    syn keyword schemeGaucheExtFunc tree-map-clear!
    syn keyword schemeGaucheExtFunc tree-map-copy
    syn keyword schemeGaucheExtFunc tree-map-delete!
    syn keyword schemeGaucheExtFunc tree-map-empty?
    syn keyword schemeGaucheExtFunc tree-map-exists?
    syn keyword schemeGaucheExtFunc tree-map-floor
    syn keyword schemeGaucheExtFunc tree-map-floor-key
    syn keyword schemeGaucheExtFunc tree-map-floor-value
    syn keyword schemeGaucheExtFunc tree-map-fold
    syn keyword schemeGaucheExtFunc tree-map-fold-right
    syn keyword schemeGaucheExtFunc tree-map-for-each
    syn keyword schemeGaucheExtFunc tree-map-get
    syn keyword schemeGaucheExtFunc tree-map-keys
    syn keyword schemeGaucheExtFunc tree-map-map
    syn keyword schemeGaucheExtFunc tree-map-max
    syn keyword schemeGaucheExtFunc tree-map-min
    syn keyword schemeGaucheExtFunc tree-map-num-entries
    syn keyword schemeGaucheExtFunc tree-map-pop!
    syn keyword schemeGaucheExtFunc tree-map-pop-max!
    syn keyword schemeGaucheExtFunc tree-map-pop-min!
    syn keyword schemeGaucheExtFunc tree-map-predecessor
    syn keyword schemeGaucheExtFunc tree-map-predecessor-key
    syn keyword schemeGaucheExtFunc tree-map-predecessor-value
    syn keyword schemeGaucheExtFunc tree-map-push!
    syn keyword schemeGaucheExtFunc tree-map-put!
    syn keyword schemeGaucheExtFunc tree-map-successor
    syn keyword schemeGaucheExtFunc tree-map-successor-key
    syn keyword schemeGaucheExtFunc tree-map-successor-value
    syn keyword schemeGaucheExtFunc tree-map-update!
    syn keyword schemeGaucheExtFunc tree-map-values
    syn keyword schemeGaucheExtFunc tree-map?
    syn keyword schemeGaucheExtFunc tree-walk
    syn keyword schemeGaucheExtFunc tree-walk-bf
    syn keyword schemeGaucheExtFunc trie
    syn keyword schemeGaucheExtFunc trie->hash-table
    syn keyword schemeGaucheExtFunc trie->list
    syn keyword schemeGaucheExtFunc trie-common-prefix
    syn keyword schemeGaucheExtFunc trie-common-prefix-fold
    syn keyword schemeGaucheExtFunc trie-common-prefix-for-each
    syn keyword schemeGaucheExtFunc trie-common-prefix-keys
    syn keyword schemeGaucheExtFunc trie-common-prefix-map
    syn keyword schemeGaucheExtFunc trie-common-prefix-values
    syn keyword schemeGaucheExtFunc trie-delete!
    syn keyword schemeGaucheExtFunc trie-exists?
    syn keyword schemeGaucheExtFunc trie-fold
    syn keyword schemeGaucheExtFunc trie-for-each
    syn keyword schemeGaucheExtFunc trie-get
    syn keyword schemeGaucheExtFunc trie-keys
    syn keyword schemeGaucheExtFunc trie-map
    syn keyword schemeGaucheExtFunc trie-num-entries
    syn keyword schemeGaucheExtFunc trie-put!
    syn keyword schemeGaucheExtFunc trie-update!
    syn keyword schemeGaucheExtFunc trie-values
    syn keyword schemeGaucheExtFunc trie-with-keys
    syn keyword schemeGaucheExtFunc trie?
    syn keyword schemeGaucheExtFunc truncate->exact
    syn keyword schemeGaucheExtFunc u16vector
    syn keyword schemeGaucheExtFunc u16vector->list
    syn keyword schemeGaucheExtFunc u16vector->vector
    syn keyword schemeGaucheExtFunc u16vector-add
    syn keyword schemeGaucheExtFunc u16vector-add!
    syn keyword schemeGaucheExtFunc u16vector-and
    syn keyword schemeGaucheExtFunc u16vector-and!
    syn keyword schemeGaucheExtFunc u16vector-clamp
    syn keyword schemeGaucheExtFunc u16vector-clamp!
    syn keyword schemeGaucheExtFunc u16vector-copy
    syn keyword schemeGaucheExtFunc u16vector-copy!
    syn keyword schemeGaucheExtFunc u16vector-dot
    syn keyword schemeGaucheExtFunc u16vector-fill!
    syn keyword schemeGaucheExtFunc u16vector-ior
    syn keyword schemeGaucheExtFunc u16vector-ior!
    syn keyword schemeGaucheExtFunc u16vector-length
    syn keyword schemeGaucheExtFunc u16vector-mul
    syn keyword schemeGaucheExtFunc u16vector-mul!
    syn keyword schemeGaucheExtFunc u16vector-range-check
    syn keyword schemeGaucheExtFunc u16vector-ref
    syn keyword schemeGaucheExtFunc u16vector-set!
    syn keyword schemeGaucheExtFunc u16vector-sub
    syn keyword schemeGaucheExtFunc u16vector-sub!
    syn keyword schemeGaucheExtFunc u16vector-swap-bytes
    syn keyword schemeGaucheExtFunc u16vector-swap-bytes!
    syn keyword schemeGaucheExtFunc u16vector-xor
    syn keyword schemeGaucheExtFunc u16vector-xor!
    syn keyword schemeGaucheExtFunc u16vector?
    syn keyword schemeGaucheExtFunc u32vector
    syn keyword schemeGaucheExtFunc u32vector->list
    syn keyword schemeGaucheExtFunc u32vector->string
    syn keyword schemeGaucheExtFunc u32vector->vector
    syn keyword schemeGaucheExtFunc u32vector-add
    syn keyword schemeGaucheExtFunc u32vector-add!
    syn keyword schemeGaucheExtFunc u32vector-and
    syn keyword schemeGaucheExtFunc u32vector-and!
    syn keyword schemeGaucheExtFunc u32vector-clamp
    syn keyword schemeGaucheExtFunc u32vector-clamp!
    syn keyword schemeGaucheExtFunc u32vector-copy
    syn keyword schemeGaucheExtFunc u32vector-copy!
    syn keyword schemeGaucheExtFunc u32vector-dot
    syn keyword schemeGaucheExtFunc u32vector-fill!
    syn keyword schemeGaucheExtFunc u32vector-ior
    syn keyword schemeGaucheExtFunc u32vector-ior!
    syn keyword schemeGaucheExtFunc u32vector-length
    syn keyword schemeGaucheExtFunc u32vector-mul
    syn keyword schemeGaucheExtFunc u32vector-mul!
    syn keyword schemeGaucheExtFunc u32vector-range-check
    syn keyword schemeGaucheExtFunc u32vector-ref
    syn keyword schemeGaucheExtFunc u32vector-set!
    syn keyword schemeGaucheExtFunc u32vector-sub
    syn keyword schemeGaucheExtFunc u32vector-sub!
    syn keyword schemeGaucheExtFunc u32vector-swap-bytes
    syn keyword schemeGaucheExtFunc u32vector-swap-bytes!
    syn keyword schemeGaucheExtFunc u32vector-xor
    syn keyword schemeGaucheExtFunc u32vector-xor!
    syn keyword schemeGaucheExtFunc u32vector?
    syn keyword schemeGaucheExtFunc u64vector
    syn keyword schemeGaucheExtFunc u64vector->list
    syn keyword schemeGaucheExtFunc u64vector->vector
    syn keyword schemeGaucheExtFunc u64vector-add
    syn keyword schemeGaucheExtFunc u64vector-add!
    syn keyword schemeGaucheExtFunc u64vector-and
    syn keyword schemeGaucheExtFunc u64vector-and!
    syn keyword schemeGaucheExtFunc u64vector-clamp
    syn keyword schemeGaucheExtFunc u64vector-clamp!
    syn keyword schemeGaucheExtFunc u64vector-copy
    syn keyword schemeGaucheExtFunc u64vector-copy!
    syn keyword schemeGaucheExtFunc u64vector-dot
    syn keyword schemeGaucheExtFunc u64vector-fill!
    syn keyword schemeGaucheExtFunc u64vector-ior
    syn keyword schemeGaucheExtFunc u64vector-ior!
    syn keyword schemeGaucheExtFunc u64vector-length
    syn keyword schemeGaucheExtFunc u64vector-mul
    syn keyword schemeGaucheExtFunc u64vector-mul!
    syn keyword schemeGaucheExtFunc u64vector-range-check
    syn keyword schemeGaucheExtFunc u64vector-ref
    syn keyword schemeGaucheExtFunc u64vector-set!
    syn keyword schemeGaucheExtFunc u64vector-sub
    syn keyword schemeGaucheExtFunc u64vector-sub!
    syn keyword schemeGaucheExtFunc u64vector-swap-bytes
    syn keyword schemeGaucheExtFunc u64vector-swap-bytes!
    syn keyword schemeGaucheExtFunc u64vector-xor
    syn keyword schemeGaucheExtFunc u64vector-xor!
    syn keyword schemeGaucheExtFunc u64vector?
    syn keyword schemeGaucheExtFunc u8vector
    syn keyword schemeGaucheExtFunc u8vector->list
    syn keyword schemeGaucheExtFunc u8vector->string
    syn keyword schemeGaucheExtFunc u8vector->vector
    syn keyword schemeGaucheExtFunc u8vector-add
    syn keyword schemeGaucheExtFunc u8vector-add!
    syn keyword schemeGaucheExtFunc u8vector-and
    syn keyword schemeGaucheExtFunc u8vector-and!
    syn keyword schemeGaucheExtFunc u8vector-clamp
    syn keyword schemeGaucheExtFunc u8vector-clamp!
    syn keyword schemeGaucheExtFunc u8vector-copy
    syn keyword schemeGaucheExtFunc u8vector-copy!
    syn keyword schemeGaucheExtFunc u8vector-dot
    syn keyword schemeGaucheExtFunc u8vector-fill!
    syn keyword schemeGaucheExtFunc u8vector-ior
    syn keyword schemeGaucheExtFunc u8vector-ior!
    syn keyword schemeGaucheExtFunc u8vector-length
    syn keyword schemeGaucheExtFunc u8vector-mul
    syn keyword schemeGaucheExtFunc u8vector-mul!
    syn keyword schemeGaucheExtFunc u8vector-range-check
    syn keyword schemeGaucheExtFunc u8vector-ref
    syn keyword schemeGaucheExtFunc u8vector-set!
    syn keyword schemeGaucheExtFunc u8vector-sub
    syn keyword schemeGaucheExtFunc u8vector-sub!
    syn keyword schemeGaucheExtFunc u8vector-xor
    syn keyword schemeGaucheExtFunc u8vector-xor!
    syn keyword schemeGaucheExtFunc u8vector?
    syn keyword schemeGaucheExtFunc ucs->char
    syn keyword schemeGaucheExtFunc ucs-range->char-set
    syn keyword schemeGaucheExtFunc ucs-range->char-set!
    syn keyword schemeGaucheExtFunc ucs4->utf16
    syn keyword schemeGaucheExtFunc ucs4->utf8
    syn keyword schemeGaucheExtFunc ucscode->char
    syn keyword schemeGaucheExtFunc uncaught-exception-reason
    syn keyword schemeGaucheExtFunc uncaught-exception?
    syn keyword schemeGaucheExtFunc undefined
    syn keyword schemeGaucheExtFunc undefined?
    syn keyword schemeGaucheExtFunc unfold
    syn keyword schemeGaucheExtFunc unfold-right
    syn keyword schemeGaucheExtFunc unpack
    syn keyword schemeGaucheExtFunc unpack-skip
    syn keyword schemeGaucheExtFunc unwrap-syntax
    syn keyword schemeGaucheExtFunc unzip1
    syn keyword schemeGaucheExtFunc unzip2
    syn keyword schemeGaucheExtFunc unzip3
    syn keyword schemeGaucheExtFunc unzip4
    syn keyword schemeGaucheExtFunc unzip5
    syn keyword schemeGaucheExtFunc upper
    syn keyword schemeGaucheExtFunc uri-compose
    syn keyword schemeGaucheExtFunc uri-decode
    syn keyword schemeGaucheExtFunc uri-decode-string
    syn keyword schemeGaucheExtFunc uri-decompose-authority
    syn keyword schemeGaucheExtFunc uri-decompose-hierarchical
    syn keyword schemeGaucheExtFunc uri-encode
    syn keyword schemeGaucheExtFunc uri-encode-string
    syn keyword schemeGaucheExtFunc uri-merge
    syn keyword schemeGaucheExtFunc uri-parse
    syn keyword schemeGaucheExtFunc uri-scheme&specific
    syn keyword schemeGaucheExtFunc utf16->ucs4
    syn keyword schemeGaucheExtFunc utf16-length
    syn keyword schemeGaucheExtFunc utf8->ucs4
    syn keyword schemeGaucheExtFunc utf8-length
    syn keyword schemeGaucheExtFunc uvector-alias
    syn keyword schemeGaucheExtFunc uvector-copy!
    syn keyword schemeGaucheExtFunc uvector-immutable?
    syn keyword schemeGaucheExtFunc uvector-length
    syn keyword schemeGaucheExtFunc uvector-size
    syn keyword schemeGaucheExtFunc uvector-swap-bytes
    syn keyword schemeGaucheExtFunc uvector-swap-bytes!
    syn keyword schemeGaucheExtFunc vector->f16vector
    syn keyword schemeGaucheExtFunc vector->f32vector
    syn keyword schemeGaucheExtFunc vector->f64vector
    syn keyword schemeGaucheExtFunc vector->generator
    syn keyword schemeGaucheExtFunc vector->posix-tm
    syn keyword schemeGaucheExtFunc vector->s16vector
    syn keyword schemeGaucheExtFunc vector->s32vector
    syn keyword schemeGaucheExtFunc vector->s64vector
    syn keyword schemeGaucheExtFunc vector->s8vector
    syn keyword schemeGaucheExtFunc vector->u16vector
    syn keyword schemeGaucheExtFunc vector->u32vector
    syn keyword schemeGaucheExtFunc vector->u64vector
    syn keyword schemeGaucheExtFunc vector->u8vector
    syn keyword schemeGaucheExtFunc vector-any
    syn keyword schemeGaucheExtFunc vector-append
    syn keyword schemeGaucheExtFunc vector-binary-search
    syn keyword schemeGaucheExtFunc vector-concatenate
    syn keyword schemeGaucheExtFunc vector-copy
    syn keyword schemeGaucheExtFunc vector-copy!
    syn keyword schemeGaucheExtFunc vector-count
    syn keyword schemeGaucheExtFunc vector-empty?
    syn keyword schemeGaucheExtFunc vector-every
    syn keyword schemeGaucheExtFunc vector-fold
    syn keyword schemeGaucheExtFunc vector-fold-right
    syn keyword schemeGaucheExtFunc vector-for-each
    syn keyword schemeGaucheExtFunc vector-index
    syn keyword schemeGaucheExtFunc vector-index-right
    syn keyword schemeGaucheExtFunc vector-map
    syn keyword schemeGaucheExtFunc vector-map!
    syn keyword schemeGaucheExtFunc vector-reverse!
    syn keyword schemeGaucheExtFunc vector-reverse-copy
    syn keyword schemeGaucheExtFunc vector-reverse-copy!
    syn keyword schemeGaucheExtFunc vector-skip
    syn keyword schemeGaucheExtFunc vector-skip-right
    syn keyword schemeGaucheExtFunc vector-swap!
    syn keyword schemeGaucheExtFunc vector-unfold
    syn keyword schemeGaucheExtFunc vector-unfold-right
    syn keyword schemeGaucheExtFunc vector=
    syn keyword schemeGaucheExtFunc version
    syn keyword schemeGaucheExtFunc version-compare
    syn keyword schemeGaucheExtFunc version<=?
    syn keyword schemeGaucheExtFunc version<?
    syn keyword schemeGaucheExtFunc version=?
    syn keyword schemeGaucheExtFunc version>=?
    syn keyword schemeGaucheExtFunc version>?
    syn keyword schemeGaucheExtFunc vm-build-insn
    syn keyword schemeGaucheExtFunc vm-dump
    syn keyword schemeGaucheExtFunc vm-find-insn-info
    syn keyword schemeGaucheExtFunc vm-get-stack-trace
    syn keyword schemeGaucheExtFunc vm-get-stack-trace-lite
    syn keyword schemeGaucheExtFunc vm-set-default-exception-handler
    syn keyword schemeGaucheExtFunc wait-all
    syn keyword schemeGaucheExtFunc warn
    syn keyword schemeGaucheExtFunc weak-vector-length
    syn keyword schemeGaucheExtFunc weak-vector-ref
    syn keyword schemeGaucheExtFunc weak-vector-set!
    syn keyword schemeGaucheExtFunc with-error-handler
    syn keyword schemeGaucheExtFunc with-error-to-port
    syn keyword schemeGaucheExtFunc with-exception-handler
    syn keyword schemeGaucheExtFunc with-input-conversion
    syn keyword schemeGaucheExtFunc with-input-from-port
    syn keyword schemeGaucheExtFunc with-input-from-process
    syn keyword schemeGaucheExtFunc with-input-from-string
    syn keyword schemeGaucheExtFunc with-lock-file
    syn keyword schemeGaucheExtFunc with-locking-mutex
    syn keyword schemeGaucheExtFunc with-output-conversion
    syn keyword schemeGaucheExtFunc with-output-to-port
    syn keyword schemeGaucheExtFunc with-output-to-process
    syn keyword schemeGaucheExtFunc with-output-to-string
    syn keyword schemeGaucheExtFunc with-port-locking
    syn keyword schemeGaucheExtFunc with-ports
    syn keyword schemeGaucheExtFunc with-string-io
    syn keyword schemeGaucheExtFunc without-echoing
    syn keyword schemeGaucheExtFunc wrap-with-input-conversion
    syn keyword schemeGaucheExtFunc wrap-with-output-conversion
    syn keyword schemeGaucheExtFunc write*
    syn keyword schemeGaucheExtFunc write-ber-integer
    syn keyword schemeGaucheExtFunc write-binary-double
    syn keyword schemeGaucheExtFunc write-binary-float
    syn keyword schemeGaucheExtFunc write-binary-long
    syn keyword schemeGaucheExtFunc write-binary-short
    syn keyword schemeGaucheExtFunc write-binary-sint
    syn keyword schemeGaucheExtFunc write-binary-sint16
    syn keyword schemeGaucheExtFunc write-binary-sint32
    syn keyword schemeGaucheExtFunc write-binary-sint64
    syn keyword schemeGaucheExtFunc write-binary-sint8
    syn keyword schemeGaucheExtFunc write-binary-uint
    syn keyword schemeGaucheExtFunc write-binary-uint16
    syn keyword schemeGaucheExtFunc write-binary-uint32
    syn keyword schemeGaucheExtFunc write-binary-uint64
    syn keyword schemeGaucheExtFunc write-binary-uint8
    syn keyword schemeGaucheExtFunc write-binary-ulong
    syn keyword schemeGaucheExtFunc write-binary-ushort
    syn keyword schemeGaucheExtFunc write-block
    syn keyword schemeGaucheExtFunc write-byte
    syn keyword schemeGaucheExtFunc write-f16
    syn keyword schemeGaucheExtFunc write-f32
    syn keyword schemeGaucheExtFunc write-f64
    syn keyword schemeGaucheExtFunc write-fobject
    syn keyword schemeGaucheExtFunc write-fobject/uv
    syn keyword schemeGaucheExtFunc write-limited
    syn keyword schemeGaucheExtFunc write-s16
    syn keyword schemeGaucheExtFunc write-s32
    syn keyword schemeGaucheExtFunc write-s64
    syn keyword schemeGaucheExtFunc write-s8
    syn keyword schemeGaucheExtFunc write-sint
    syn keyword schemeGaucheExtFunc write-stream
    syn keyword schemeGaucheExtFunc write-to-string
    syn keyword schemeGaucheExtFunc write-u16
    syn keyword schemeGaucheExtFunc write-u32
    syn keyword schemeGaucheExtFunc write-u64
    syn keyword schemeGaucheExtFunc write-u8
    syn keyword schemeGaucheExtFunc write-uint
    syn keyword schemeGaucheExtFunc write-with-shared-structure
    syn keyword schemeGaucheExtFunc write/ss
    syn keyword schemeGaucheExtFunc xcons
    syn keyword schemeGaucheExtFunc xml-token-head
    syn keyword schemeGaucheExtFunc xml-token-kind
    syn keyword schemeGaucheExtFunc xml-token?
    syn keyword schemeGaucheExtFunc xsubstring
    syn keyword schemeGaucheExtFunc zip
    syn keyword schemeGaucheExtFunc ~


    " method
    syn keyword schemeGaucheExtFunc add-hook!
    syn keyword schemeGaucheExtFunc add-method!
    syn keyword schemeGaucheExtFunc allocate-instance
    syn keyword schemeGaucheExtFunc apply-generic
    syn keyword schemeGaucheExtFunc apply-method
    syn keyword schemeGaucheExtFunc apply-methods
    syn keyword schemeGaucheExtFunc array-add-elements!
    syn keyword schemeGaucheExtFunc array-div-elements!
    syn keyword schemeGaucheExtFunc array-map
    syn keyword schemeGaucheExtFunc array-map!
    syn keyword schemeGaucheExtFunc array-mul-elements!
    syn keyword schemeGaucheExtFunc array-ref
    syn keyword schemeGaucheExtFunc array-retabulate!
    syn keyword schemeGaucheExtFunc array-set!
    syn keyword schemeGaucheExtFunc array-sub-elements!
    syn keyword schemeGaucheExtFunc call-with-builder
    syn keyword schemeGaucheExtFunc call-with-iterator
    syn keyword schemeGaucheExtFunc cgen-c-name
    syn keyword schemeGaucheExtFunc cgen-cexpr
    syn keyword schemeGaucheExtFunc cgen-emit
    syn keyword schemeGaucheExtFunc cgen-emit-body
    syn keyword schemeGaucheExtFunc cgen-emit-c
    syn keyword schemeGaucheExtFunc cgen-emit-decl
    syn keyword schemeGaucheExtFunc cgen-emit-h
    syn keyword schemeGaucheExtFunc cgen-emit-init
    syn keyword schemeGaucheExtFunc cgen-emit-static-data
    syn keyword schemeGaucheExtFunc cgen-emit-xtrn
    syn keyword schemeGaucheExtFunc cgen-literal-static?
    syn keyword schemeGaucheExtFunc cgen-make-literal
    syn keyword schemeGaucheExtFunc cgen-unit-c-file
    syn keyword schemeGaucheExtFunc cgen-unit-h-file
    syn keyword schemeGaucheExtFunc cgen-unit-init-name
    syn keyword schemeGaucheExtFunc cgen-unit-toplevel-nodes
    syn keyword schemeGaucheExtFunc change-class
    syn keyword schemeGaucheExtFunc class-redefinition
    syn keyword schemeGaucheExtFunc coerce-to
    syn keyword schemeGaucheExtFunc compute-applicable-methods
    syn keyword schemeGaucheExtFunc compute-cpl
    syn keyword schemeGaucheExtFunc compute-get-n-set
    syn keyword schemeGaucheExtFunc compute-slot-accessor
    syn keyword schemeGaucheExtFunc compute-slots
    syn keyword schemeGaucheExtFunc copy-queue
    syn keyword schemeGaucheExtFunc date-day
    syn keyword schemeGaucheExtFunc date-hour
    syn keyword schemeGaucheExtFunc date-minute
    syn keyword schemeGaucheExtFunc date-month
    syn keyword schemeGaucheExtFunc date-nanosecond
    syn keyword schemeGaucheExtFunc date-second
    syn keyword schemeGaucheExtFunc date-year
    syn keyword schemeGaucheExtFunc date-zone-offset
    syn keyword schemeGaucheExtFunc dbi-close
    syn keyword schemeGaucheExtFunc dbi-do
    syn keyword schemeGaucheExtFunc dbi-escape-sql
    syn keyword schemeGaucheExtFunc dbi-execute
    syn keyword schemeGaucheExtFunc dbi-execute-query
    syn keyword schemeGaucheExtFunc dbi-execute-using-connection
    syn keyword schemeGaucheExtFunc dbi-get-value
    syn keyword schemeGaucheExtFunc dbi-make-connection
    syn keyword schemeGaucheExtFunc dbi-make-query
    syn keyword schemeGaucheExtFunc dbi-open?
    syn keyword schemeGaucheExtFunc dbi-prepare
    syn keyword schemeGaucheExtFunc dbm-close
    syn keyword schemeGaucheExtFunc dbm-closed?
    syn keyword schemeGaucheExtFunc dbm-db-copy
    syn keyword schemeGaucheExtFunc dbm-db-exists?
    syn keyword schemeGaucheExtFunc dbm-db-move
    syn keyword schemeGaucheExtFunc dbm-db-remove
    syn keyword schemeGaucheExtFunc dbm-db-rename
    syn keyword schemeGaucheExtFunc dbm-delete!
    syn keyword schemeGaucheExtFunc dbm-exists?
    syn keyword schemeGaucheExtFunc dbm-fold
    syn keyword schemeGaucheExtFunc dbm-for-each
    syn keyword schemeGaucheExtFunc dbm-get
    syn keyword schemeGaucheExtFunc dbm-map
    syn keyword schemeGaucheExtFunc dbm-open
    syn keyword schemeGaucheExtFunc dbm-put!
    syn keyword schemeGaucheExtFunc delete-hook!
    syn keyword schemeGaucheExtFunc delete-method!
    syn keyword schemeGaucheExtFunc dict-delete!
    syn keyword schemeGaucheExtFunc dict-exists?
    syn keyword schemeGaucheExtFunc dict-fold
    syn keyword schemeGaucheExtFunc dict-fold-right
    syn keyword schemeGaucheExtFunc dict-for-each
    syn keyword schemeGaucheExtFunc dict-get
    syn keyword schemeGaucheExtFunc dict-keys
    syn keyword schemeGaucheExtFunc dict-map
    syn keyword schemeGaucheExtFunc dict-put!
    syn keyword schemeGaucheExtFunc dict-values
    syn keyword schemeGaucheExtFunc digest
    syn keyword schemeGaucheExtFunc digest-final!
    syn keyword schemeGaucheExtFunc digest-string
    syn keyword schemeGaucheExtFunc digest-update!
    syn keyword schemeGaucheExtFunc direction-of
    syn keyword schemeGaucheExtFunc file-atime<=?
    syn keyword schemeGaucheExtFunc file-atime<?
    syn keyword schemeGaucheExtFunc file-atime=?
    syn keyword schemeGaucheExtFunc file-atime>=?
    syn keyword schemeGaucheExtFunc file-atime>?
    syn keyword schemeGaucheExtFunc file-ctime<=?
    syn keyword schemeGaucheExtFunc file-ctime<?
    syn keyword schemeGaucheExtFunc file-ctime=?
    syn keyword schemeGaucheExtFunc file-ctime>=?
    syn keyword schemeGaucheExtFunc file-ctime>?
    syn keyword schemeGaucheExtFunc file-mtime<=?
    syn keyword schemeGaucheExtFunc file-mtime<?
    syn keyword schemeGaucheExtFunc file-mtime=?
    syn keyword schemeGaucheExtFunc file-mtime>=?
    syn keyword schemeGaucheExtFunc file-mtime>?
    syn keyword schemeGaucheExtFunc filter-to
    syn keyword schemeGaucheExtFunc find-index
    syn keyword schemeGaucheExtFunc find-max
    syn keyword schemeGaucheExtFunc find-min
    syn keyword schemeGaucheExtFunc find-min&max
    syn keyword schemeGaucheExtFunc find-with-index
    syn keyword schemeGaucheExtFunc fold$
    syn keyword schemeGaucheExtFunc fold-with-index
    syn keyword schemeGaucheExtFunc fold2
    syn keyword schemeGaucheExtFunc fold2$
    syn keyword schemeGaucheExtFunc fold3
    syn keyword schemeGaucheExtFunc fold3$
    syn keyword schemeGaucheExtFunc for-each-with-index
    syn keyword schemeGaucheExtFunc ftp-passive?
    syn keyword schemeGaucheExtFunc ftp-transfer-type
    syn keyword schemeGaucheExtFunc get-serializable-slots
    syn keyword schemeGaucheExtFunc group-collection
    syn keyword schemeGaucheExtFunc group-sequence
    syn keyword schemeGaucheExtFunc hmac-final!
    syn keyword schemeGaucheExtFunc hmac-update!
    syn keyword schemeGaucheExtFunc hook->list
    syn keyword schemeGaucheExtFunc hook-empty?
    syn keyword schemeGaucheExtFunc info-get-node
    syn keyword schemeGaucheExtFunc info-parse-menu
    syn keyword schemeGaucheExtFunc initialize
    syn keyword schemeGaucheExtFunc instance-of
    syn keyword schemeGaucheExtFunc instance-pool->list
    syn keyword schemeGaucheExtFunc instance-pool-find
    syn keyword schemeGaucheExtFunc instance-pool-fold
    syn keyword schemeGaucheExtFunc instance-pool-for-each
    syn keyword schemeGaucheExtFunc instance-pool-map
    syn keyword schemeGaucheExtFunc instance-pool-of
    syn keyword schemeGaucheExtFunc instance-pool-remove!
    syn keyword schemeGaucheExtFunc instance-pool:->list
    syn keyword schemeGaucheExtFunc instance-pool:add
    syn keyword schemeGaucheExtFunc instance-pool:compute-pools
    syn keyword schemeGaucheExtFunc instance-pool:create-pool
    syn keyword schemeGaucheExtFunc instance-pool:find
    syn keyword schemeGaucheExtFunc instance-pool:fold
    syn keyword schemeGaucheExtFunc instance-pool:for-each
    syn keyword schemeGaucheExtFunc instance-pool:map
    syn keyword schemeGaucheExtFunc instance-pool:remove!
    syn keyword schemeGaucheExtFunc instance-pools-of
    syn keyword schemeGaucheExtFunc lazy-size-of
    syn keyword schemeGaucheExtFunc listener-read-handler
    syn keyword schemeGaucheExtFunc listener-show-prompt
    syn keyword schemeGaucheExtFunc log-format
    syn keyword schemeGaucheExtFunc make
    syn keyword schemeGaucheExtFunc map-accum
    syn keyword schemeGaucheExtFunc map-to
    syn keyword schemeGaucheExtFunc map-to-with-index
    syn keyword schemeGaucheExtFunc map-with-index
    syn keyword schemeGaucheExtFunc method-more-specific?
    syn keyword schemeGaucheExtFunc modifier
    syn keyword schemeGaucheExtFunc object-*
    syn keyword schemeGaucheExtFunc object-+
    syn keyword schemeGaucheExtFunc object--
    syn keyword schemeGaucheExtFunc object-/
    syn keyword schemeGaucheExtFunc object-apply
    syn keyword schemeGaucheExtFunc object-compare
    syn keyword schemeGaucheExtFunc object-equal?
    syn keyword schemeGaucheExtFunc object-hash
    syn keyword schemeGaucheExtFunc object-isomorphic?
    syn keyword schemeGaucheExtFunc option-names
    syn keyword schemeGaucheExtFunc option-optional-arg?
    syn keyword schemeGaucheExtFunc option-processor
    syn keyword schemeGaucheExtFunc option-required-arg?
    syn keyword schemeGaucheExtFunc parameter-observer-add!
    syn keyword schemeGaucheExtFunc parameter-observer-delete!
    syn keyword schemeGaucheExtFunc parameter-post-observers
    syn keyword schemeGaucheExtFunc parameter-pre-observers
    syn keyword schemeGaucheExtFunc partition-to
    syn keyword schemeGaucheExtFunc permute
    syn keyword schemeGaucheExtFunc permute!
    syn keyword schemeGaucheExtFunc permute-to
    syn keyword schemeGaucheExtFunc port-of
    syn keyword schemeGaucheExtFunc process-command
    syn keyword schemeGaucheExtFunc process-exit-status
    syn keyword schemeGaucheExtFunc process-pid
    syn keyword schemeGaucheExtFunc pseudo-rtd
    syn keyword schemeGaucheExtFunc read-from-file-with-serializer
    syn keyword schemeGaucheExtFunc read-from-serializer
    syn keyword schemeGaucheExtFunc read-from-string-with-serializer
    syn keyword schemeGaucheExtFunc ref
    syn keyword schemeGaucheExtFunc referencer
    syn keyword schemeGaucheExtFunc relation-accessor
    syn keyword schemeGaucheExtFunc relation-coercer
    syn keyword schemeGaucheExtFunc relation-column-getter
    syn keyword schemeGaucheExtFunc relation-column-getters
    syn keyword schemeGaucheExtFunc relation-column-name?
    syn keyword schemeGaucheExtFunc relation-column-names
    syn keyword schemeGaucheExtFunc relation-column-setter
    syn keyword schemeGaucheExtFunc relation-column-setters
    syn keyword schemeGaucheExtFunc relation-deletable?
    syn keyword schemeGaucheExtFunc relation-delete!
    syn keyword schemeGaucheExtFunc relation-fold
    syn keyword schemeGaucheExtFunc relation-insert!
    syn keyword schemeGaucheExtFunc relation-insertable?
    syn keyword schemeGaucheExtFunc relation-modifier
    syn keyword schemeGaucheExtFunc relation-ref
    syn keyword schemeGaucheExtFunc relation-rows
    syn keyword schemeGaucheExtFunc relation-set!
    syn keyword schemeGaucheExtFunc remove-hook!
    syn keyword schemeGaucheExtFunc remove-to
    syn keyword schemeGaucheExtFunc reset-hook!
    syn keyword schemeGaucheExtFunc rtd-accessor
    syn keyword schemeGaucheExtFunc rtd-constructor
    syn keyword schemeGaucheExtFunc rtd-mutator
    syn keyword schemeGaucheExtFunc rtd-predicate
    syn keyword schemeGaucheExtFunc run-hook
    syn keyword schemeGaucheExtFunc selector-add!
    syn keyword schemeGaucheExtFunc selector-delete!
    syn keyword schemeGaucheExtFunc selector-select
    syn keyword schemeGaucheExtFunc set-time-nanosecond!
    syn keyword schemeGaucheExtFunc set-time-second!
    syn keyword schemeGaucheExtFunc set-time-type!
    syn keyword schemeGaucheExtFunc shape-valid-index?
    syn keyword schemeGaucheExtFunc shuffle
    syn keyword schemeGaucheExtFunc shuffle!
    syn keyword schemeGaucheExtFunc shuffle-to
    syn keyword schemeGaucheExtFunc size-of
    syn keyword schemeGaucheExtFunc slot-bound-using-class?
    syn keyword schemeGaucheExtFunc slot-exists-using-class?
    syn keyword schemeGaucheExtFunc slot-missing
    syn keyword schemeGaucheExtFunc slot-ref-using-class
    syn keyword schemeGaucheExtFunc slot-set-using-class!
    syn keyword schemeGaucheExtFunc slot-unbound
    syn keyword schemeGaucheExtFunc sockaddr-addr
    syn keyword schemeGaucheExtFunc sockaddr-family
    syn keyword schemeGaucheExtFunc sockaddr-name
    syn keyword schemeGaucheExtFunc sockaddr-port
    syn keyword schemeGaucheExtFunc sort-applicable-methods
    syn keyword schemeGaucheExtFunc subseq
    syn keyword schemeGaucheExtFunc time-counter-get-current-time
    syn keyword schemeGaucheExtFunc time-counter-get-delta
    syn keyword schemeGaucheExtFunc time-counter-reset!
    syn keyword schemeGaucheExtFunc time-counter-start!
    syn keyword schemeGaucheExtFunc time-counter-stop!
    syn keyword schemeGaucheExtFunc time-counter-value
    syn keyword schemeGaucheExtFunc time-nanosecond
    syn keyword schemeGaucheExtFunc time-second
    syn keyword schemeGaucheExtFunc time-type
    syn keyword schemeGaucheExtFunc update-direct-method!
    syn keyword schemeGaucheExtFunc update-direct-subclass!
    syn keyword schemeGaucheExtFunc write-gauche-package-description
    syn keyword schemeGaucheExtFunc write-object
    syn keyword schemeGaucheExtFunc write-to-file-with-serializer
    syn keyword schemeGaucheExtFunc write-to-serializer
    syn keyword schemeGaucheExtFunc write-to-string-with-serializer
    syn keyword schemeGaucheExtFunc write-tree
    syn keyword schemeGaucheExtFunc x->integer
    syn keyword schemeGaucheExtFunc x->number
    syn keyword schemeGaucheExtFunc x->string


    " class
    syn keyword schemeGaucheExtFunc &condition
    syn keyword schemeGaucheExtFunc &error
    syn keyword schemeGaucheExtFunc &i/o-closed-error
    syn keyword schemeGaucheExtFunc &i/o-error
    syn keyword schemeGaucheExtFunc &i/o-port-error
    syn keyword schemeGaucheExtFunc &i/o-read-error
    syn keyword schemeGaucheExtFunc &i/o-write-error
    syn keyword schemeGaucheExtFunc &message
    syn keyword schemeGaucheExtFunc &read-error
    syn keyword schemeGaucheExtFunc &serious
    syn keyword schemeGaucheExtFunc <%box-meta>
    syn keyword schemeGaucheExtFunc <%box>
    syn keyword schemeGaucheExtFunc <abandoned-mutex-exception-meta>
    syn keyword schemeGaucheExtFunc <abandoned-mutex-exception>
    syn keyword schemeGaucheExtFunc <accessor-method>
    syn keyword schemeGaucheExtFunc <arity-at-least>
    syn keyword schemeGaucheExtFunc <array-meta>
    syn keyword schemeGaucheExtFunc <array>
    syn keyword schemeGaucheExtFunc <autoload-meta>
    syn keyword schemeGaucheExtFunc <autoload>
    syn keyword schemeGaucheExtFunc <bimap>
    syn keyword schemeGaucheExtFunc <boolean-meta>
    syn keyword schemeGaucheExtFunc <boolean>
    syn keyword schemeGaucheExtFunc <buffered-input-port>
    syn keyword schemeGaucheExtFunc <buffered-output-port>
    syn keyword schemeGaucheExtFunc <cgen-literal>
    syn keyword schemeGaucheExtFunc <cgen-node>
    syn keyword schemeGaucheExtFunc <cgen-stub-error>
    syn keyword schemeGaucheExtFunc <cgen-stub-unit>
    syn keyword schemeGaucheExtFunc <cgen-type>
    syn keyword schemeGaucheExtFunc <cgen-unit>
    syn keyword schemeGaucheExtFunc <cgi-content-type-error>
    syn keyword schemeGaucheExtFunc <cgi-error>
    syn keyword schemeGaucheExtFunc <cgi-request-method-error>
    syn keyword schemeGaucheExtFunc <cgi-request-size-error>
    syn keyword schemeGaucheExtFunc <char-meta>
    syn keyword schemeGaucheExtFunc <char-set-meta>
    syn keyword schemeGaucheExtFunc <char-set>
    syn keyword schemeGaucheExtFunc <char>
    syn keyword schemeGaucheExtFunc <class>
    syn keyword schemeGaucheExtFunc <coding-aware-port>
    syn keyword schemeGaucheExtFunc <collection>
    syn keyword schemeGaucheExtFunc <compiled-code>
    syn keyword schemeGaucheExtFunc <complex-meta>
    syn keyword schemeGaucheExtFunc <complex>
    syn keyword schemeGaucheExtFunc <compound-condition>
    syn keyword schemeGaucheExtFunc <condition-meta>
    syn keyword schemeGaucheExtFunc <condition>
    syn keyword schemeGaucheExtFunc <csv>
    syn keyword schemeGaucheExtFunc <date>
    syn keyword schemeGaucheExtFunc <dbi-connection>
    syn keyword schemeGaucheExtFunc <dbi-driver>
    syn keyword schemeGaucheExtFunc <dbi-error>
    syn keyword schemeGaucheExtFunc <dbi-exception>
    syn keyword schemeGaucheExtFunc <dbi-nonexistent-driver-error>
    syn keyword schemeGaucheExtFunc <dbi-parameter-error>
    syn keyword schemeGaucheExtFunc <dbi-query>
    syn keyword schemeGaucheExtFunc <dbi-result-set>
    syn keyword schemeGaucheExtFunc <dbi-unsupported-error>
    syn keyword schemeGaucheExtFunc <dbm-meta>
    syn keyword schemeGaucheExtFunc <dbm>
    syn keyword schemeGaucheExtFunc <dictionary>
    syn keyword schemeGaucheExtFunc <eof-object>
    syn keyword schemeGaucheExtFunc <error>
    syn keyword schemeGaucheExtFunc <exception>
    syn keyword schemeGaucheExtFunc <f16array>
    syn keyword schemeGaucheExtFunc <f16vector-meta>
    syn keyword schemeGaucheExtFunc <f16vector>
    syn keyword schemeGaucheExtFunc <f32array>
    syn keyword schemeGaucheExtFunc <f32vector-meta>
    syn keyword schemeGaucheExtFunc <f32vector>
    syn keyword schemeGaucheExtFunc <f64array>
    syn keyword schemeGaucheExtFunc <f64vector-meta>
    syn keyword schemeGaucheExtFunc <f64vector>
    syn keyword schemeGaucheExtFunc <foreign-pointer>
    syn keyword schemeGaucheExtFunc <fsdbm>
    syn keyword schemeGaucheExtFunc <ftp-connection>
    syn keyword schemeGaucheExtFunc <ftp-error>
    syn keyword schemeGaucheExtFunc <gauche-package-description>
    syn keyword schemeGaucheExtFunc <generic>
    syn keyword schemeGaucheExtFunc <gloc-meta>
    syn keyword schemeGaucheExtFunc <gloc>
    syn keyword schemeGaucheExtFunc <hash-table-meta>
    syn keyword schemeGaucheExtFunc <hash-table>
    syn keyword schemeGaucheExtFunc <hmac>
    syn keyword schemeGaucheExtFunc <hook>
    syn keyword schemeGaucheExtFunc <http-error>
    syn keyword schemeGaucheExtFunc <identifier>
    syn keyword schemeGaucheExtFunc <info-file>
    syn keyword schemeGaucheExtFunc <info-node>
    syn keyword schemeGaucheExtFunc <instance-pool-meta>
    syn keyword schemeGaucheExtFunc <instance-pool-mixin>
    syn keyword schemeGaucheExtFunc <integer-meta>
    syn keyword schemeGaucheExtFunc <integer>
    syn keyword schemeGaucheExtFunc <io-closed-error>
    syn keyword schemeGaucheExtFunc <io-error>
    syn keyword schemeGaucheExtFunc <io-read-error>
    syn keyword schemeGaucheExtFunc <io-unit-error>
    syn keyword schemeGaucheExtFunc <io-write-error>
    syn keyword schemeGaucheExtFunc <join-timeout-exception-meta>
    syn keyword schemeGaucheExtFunc <join-timeout-exception>
    syn keyword schemeGaucheExtFunc <json-construct-error>
    syn keyword schemeGaucheExtFunc <json-parse-error>
    syn keyword schemeGaucheExtFunc <keyword-meta>
    syn keyword schemeGaucheExtFunc <keyword>
    syn keyword schemeGaucheExtFunc <list-meta>
    syn keyword schemeGaucheExtFunc <list>
    syn keyword schemeGaucheExtFunc <listener>
    syn keyword schemeGaucheExtFunc <lock-file-failure>
    syn keyword schemeGaucheExtFunc <log-drain>
    syn keyword schemeGaucheExtFunc <macro-meta>
    syn keyword schemeGaucheExtFunc <macro>
    syn keyword schemeGaucheExtFunc <md5>
    syn keyword schemeGaucheExtFunc <mersenne-twister>
    syn keyword schemeGaucheExtFunc <message-condition>
    syn keyword schemeGaucheExtFunc <message-digest-algorithm-meta>
    syn keyword schemeGaucheExtFunc <message-digest-algorithm>
    syn keyword schemeGaucheExtFunc <method>
    syn keyword schemeGaucheExtFunc <mime-part>
    syn keyword schemeGaucheExtFunc <module-meta>
    syn keyword schemeGaucheExtFunc <module>
    syn keyword schemeGaucheExtFunc <mtqueue>
    syn keyword schemeGaucheExtFunc <ndbm>
    syn keyword schemeGaucheExtFunc <next-method>
    syn keyword schemeGaucheExtFunc <null-meta>
    syn keyword schemeGaucheExtFunc <null>
    syn keyword schemeGaucheExtFunc <number-meta>
    syn keyword schemeGaucheExtFunc <number>
    syn keyword schemeGaucheExtFunc <object-set-relation>
    syn keyword schemeGaucheExtFunc <object>
    syn keyword schemeGaucheExtFunc <ordered-dictionary>
    syn keyword schemeGaucheExtFunc <pair-meta>
    syn keyword schemeGaucheExtFunc <pair>
    syn keyword schemeGaucheExtFunc <parameter>
    syn keyword schemeGaucheExtFunc <parse-error>
    syn keyword schemeGaucheExtFunc <parseopt-error>
    syn keyword schemeGaucheExtFunc <port-error>
    syn keyword schemeGaucheExtFunc <port>
    syn keyword schemeGaucheExtFunc <procedure>
    syn keyword schemeGaucheExtFunc <process-abnormal-exit>
    syn keyword schemeGaucheExtFunc <process-time-counter>
    syn keyword schemeGaucheExtFunc <process>
    syn keyword schemeGaucheExtFunc <promise-meta>
    syn keyword schemeGaucheExtFunc <promise>
    syn keyword schemeGaucheExtFunc <propagate-meta>
    syn keyword schemeGaucheExtFunc <propagate-mixin>
    syn keyword schemeGaucheExtFunc <pseudo-record-meta>
    syn keyword schemeGaucheExtFunc <queue>
    syn keyword schemeGaucheExtFunc <rational-meta>
    syn keyword schemeGaucheExtFunc <rational>
    syn keyword schemeGaucheExtFunc <rbtree>
    syn keyword schemeGaucheExtFunc <read-context>
    syn keyword schemeGaucheExtFunc <read-error>
    syn keyword schemeGaucheExtFunc <read-reference>
    syn keyword schemeGaucheExtFunc <real-meta>
    syn keyword schemeGaucheExtFunc <real-time-counter>
    syn keyword schemeGaucheExtFunc <real>
    syn keyword schemeGaucheExtFunc <record-meta>
    syn keyword schemeGaucheExtFunc <record>
    syn keyword schemeGaucheExtFunc <regexp-invalid-ast>
    syn keyword schemeGaucheExtFunc <regexp-meta>
    syn keyword schemeGaucheExtFunc <regexp>
    syn keyword schemeGaucheExtFunc <regmatch-meta>
    syn keyword schemeGaucheExtFunc <regmatch>
    syn keyword schemeGaucheExtFunc <relation>
    syn keyword schemeGaucheExtFunc <rfc822-parse-error>
    syn keyword schemeGaucheExtFunc <s16array>
    syn keyword schemeGaucheExtFunc <s16vector-meta>
    syn keyword schemeGaucheExtFunc <s16vector>
    syn keyword schemeGaucheExtFunc <s32array>
    syn keyword schemeGaucheExtFunc <s32vector-meta>
    syn keyword schemeGaucheExtFunc <s32vector>
    syn keyword schemeGaucheExtFunc <s64array>
    syn keyword schemeGaucheExtFunc <s64vector-meta>
    syn keyword schemeGaucheExtFunc <s64vector>
    syn keyword schemeGaucheExtFunc <s8array>
    syn keyword schemeGaucheExtFunc <s8vector-meta>
    syn keyword schemeGaucheExtFunc <s8vector>
    syn keyword schemeGaucheExtFunc <selector>
    syn keyword schemeGaucheExtFunc <sequence>
    syn keyword schemeGaucheExtFunc <serializer>
    syn keyword schemeGaucheExtFunc <serious-compound-condition>
    syn keyword schemeGaucheExtFunc <serious-condition>
    syn keyword schemeGaucheExtFunc <sha1>
    syn keyword schemeGaucheExtFunc <sha224>
    syn keyword schemeGaucheExtFunc <sha256>
    syn keyword schemeGaucheExtFunc <sha384>
    syn keyword schemeGaucheExtFunc <sha512>
    syn keyword schemeGaucheExtFunc <simple-relation>
    syn keyword schemeGaucheExtFunc <singleton-meta>
    syn keyword schemeGaucheExtFunc <singleton-mixin>
    syn keyword schemeGaucheExtFunc <slot-accessor>
    syn keyword schemeGaucheExtFunc <sockaddr-in6>
    syn keyword schemeGaucheExtFunc <sockaddr-in>
    syn keyword schemeGaucheExtFunc <sockaddr-un>
    syn keyword schemeGaucheExtFunc <sockaddr>
    syn keyword schemeGaucheExtFunc <socket>
    syn keyword schemeGaucheExtFunc <sparse-f16vector>
    syn keyword schemeGaucheExtFunc <sparse-f32vector>
    syn keyword schemeGaucheExtFunc <sparse-f64vector>
    syn keyword schemeGaucheExtFunc <sparse-s16vector>
    syn keyword schemeGaucheExtFunc <sparse-s32vector>
    syn keyword schemeGaucheExtFunc <sparse-s64vector>
    syn keyword schemeGaucheExtFunc <sparse-s8vector>
    syn keyword schemeGaucheExtFunc <sparse-table>
    syn keyword schemeGaucheExtFunc <sparse-u16vector>
    syn keyword schemeGaucheExtFunc <sparse-u32vector>
    syn keyword schemeGaucheExtFunc <sparse-u64vector>
    syn keyword schemeGaucheExtFunc <sparse-u8vector>
    syn keyword schemeGaucheExtFunc <sparse-vector-base>
    syn keyword schemeGaucheExtFunc <sparse-vector>
    syn keyword schemeGaucheExtFunc <sql-parse-error>
    syn keyword schemeGaucheExtFunc <string-meta>
    syn keyword schemeGaucheExtFunc <string-pointer-meta>
    syn keyword schemeGaucheExtFunc <string-pointer>
    syn keyword schemeGaucheExtFunc <string>
    syn keyword schemeGaucheExtFunc <symbol-meta>
    syn keyword schemeGaucheExtFunc <symbol>
    syn keyword schemeGaucheExtFunc <syntactic-closure>
    syn keyword schemeGaucheExtFunc <syntax-meta>
    syn keyword schemeGaucheExtFunc <syntax-pattern-meta>
    syn keyword schemeGaucheExtFunc <syntax-pattern>
    syn keyword schemeGaucheExtFunc <syntax-rules-meta>
    syn keyword schemeGaucheExtFunc <syntax-rules>
    syn keyword schemeGaucheExtFunc <syntax>
    syn keyword schemeGaucheExtFunc <sys-addrinfo>
    syn keyword schemeGaucheExtFunc <sys-fdset>
    syn keyword schemeGaucheExtFunc <sys-flock>
    syn keyword schemeGaucheExtFunc <sys-group>
    syn keyword schemeGaucheExtFunc <sys-hostent>
    syn keyword schemeGaucheExtFunc <sys-passwd>
    syn keyword schemeGaucheExtFunc <sys-protoent>
    syn keyword schemeGaucheExtFunc <sys-servent>
    syn keyword schemeGaucheExtFunc <sys-sigset>
    syn keyword schemeGaucheExtFunc <sys-stat>
    syn keyword schemeGaucheExtFunc <sys-termios>
    syn keyword schemeGaucheExtFunc <sys-tm>
    syn keyword schemeGaucheExtFunc <system-error>
    syn keyword schemeGaucheExtFunc <system-time-counter>
    syn keyword schemeGaucheExtFunc <terminated-thread-exception-meta>
    syn keyword schemeGaucheExtFunc <terminated-thread-exception>
    syn keyword schemeGaucheExtFunc <thread-exception-meta>
    syn keyword schemeGaucheExtFunc <thread-exception>
    syn keyword schemeGaucheExtFunc <thread-meta>
    syn keyword schemeGaucheExtFunc <thread-pool-shut-down>
    syn keyword schemeGaucheExtFunc <thread-pool>
    syn keyword schemeGaucheExtFunc <thread>
    syn keyword schemeGaucheExtFunc <time-counter>
    syn keyword schemeGaucheExtFunc <time-result>
    syn keyword schemeGaucheExtFunc <time>
    syn keyword schemeGaucheExtFunc <tmodule>
    syn keyword schemeGaucheExtFunc <top>
    syn keyword schemeGaucheExtFunc <tree-map-meta>
    syn keyword schemeGaucheExtFunc <tree-map>
    syn keyword schemeGaucheExtFunc <trie>
    syn keyword schemeGaucheExtFunc <u16array>
    syn keyword schemeGaucheExtFunc <u16vector-meta>
    syn keyword schemeGaucheExtFunc <u16vector>
    syn keyword schemeGaucheExtFunc <u32array>
    syn keyword schemeGaucheExtFunc <u32vector-meta>
    syn keyword schemeGaucheExtFunc <u32vector>
    syn keyword schemeGaucheExtFunc <u64array>
    syn keyword schemeGaucheExtFunc <u64vector-meta>
    syn keyword schemeGaucheExtFunc <u64vector>
    syn keyword schemeGaucheExtFunc <u8array>
    syn keyword schemeGaucheExtFunc <u8vector-meta>
    syn keyword schemeGaucheExtFunc <u8vector>
    syn keyword schemeGaucheExtFunc <uncaught-exception-meta>
    syn keyword schemeGaucheExtFunc <uncaught-exception>
    syn keyword schemeGaucheExtFunc <undefined-object>
    syn keyword schemeGaucheExtFunc <unhandled-signal-error>
    syn keyword schemeGaucheExtFunc <unknown>
    syn keyword schemeGaucheExtFunc <user-time-counter>
    syn keyword schemeGaucheExtFunc <uvector-meta>
    syn keyword schemeGaucheExtFunc <uvector>
    syn keyword schemeGaucheExtFunc <validator-meta>
    syn keyword schemeGaucheExtFunc <validator-mixin>
    syn keyword schemeGaucheExtFunc <vector-meta>
    syn keyword schemeGaucheExtFunc <vector>
    syn keyword schemeGaucheExtFunc <virtual-input-port>
    syn keyword schemeGaucheExtFunc <virtual-output-port>
    syn keyword schemeGaucheExtFunc <vm-insn-info>
    syn keyword schemeGaucheExtFunc <weak-hash-table-meta>
    syn keyword schemeGaucheExtFunc <weak-hash-table>
    syn keyword schemeGaucheExtFunc <weak-vector-meta>
    syn keyword schemeGaucheExtFunc <weak-vector>
    syn keyword schemeGaucheExtFunc fobject
    syn keyword schemeGaucheExtFunc ftype
    syn keyword schemeGaucheExtFunc ftype:slot
    syn keyword schemeGaucheExtFunc ftype:struct
    syn keyword schemeGaucheExtFunc job


    " char-set
    syn keyword schemeGaucheExtFunc *rfc2396-unreserved-char-set*
    syn keyword schemeGaucheExtFunc *rfc3986-unreserved-char-set*
    syn keyword schemeGaucheExtFunc *rfc822-atext-chars*
    syn keyword schemeGaucheExtFunc char-set:ascii
    syn keyword schemeGaucheExtFunc char-set:blank
    syn keyword schemeGaucheExtFunc char-set:digit
    syn keyword schemeGaucheExtFunc char-set:empty
    syn keyword schemeGaucheExtFunc char-set:full
    syn keyword schemeGaucheExtFunc char-set:graphic
    syn keyword schemeGaucheExtFunc char-set:hex-digit
    syn keyword schemeGaucheExtFunc char-set:iso-control
    syn keyword schemeGaucheExtFunc char-set:letter
    syn keyword schemeGaucheExtFunc char-set:letter+digit
    syn keyword schemeGaucheExtFunc char-set:lower-case
    syn keyword schemeGaucheExtFunc char-set:printing
    syn keyword schemeGaucheExtFunc char-set:punctuation
    syn keyword schemeGaucheExtFunc char-set:symbol
    syn keyword schemeGaucheExtFunc char-set:title-case
    syn keyword schemeGaucheExtFunc char-set:upper-case
    syn keyword schemeGaucheExtFunc char-set:whitespace


    " parameter
    syn keyword schemeGaucheExtFunc cgen-current-unit
    syn keyword schemeGaucheExtFunc cgi-metavariables
    syn keyword schemeGaucheExtFunc cgi-output-character-encoding
    syn keyword schemeGaucheExtFunc cgi-temporary-files
    syn keyword schemeGaucheExtFunc cise-context
    syn keyword schemeGaucheExtFunc cise-emit-source-line
    syn keyword schemeGaucheExtFunc current-country
    syn keyword schemeGaucheExtFunc current-language
    syn keyword schemeGaucheExtFunc current-locale-details
    syn keyword schemeGaucheExtFunc current-tmodule-class
    syn keyword schemeGaucheExtFunc debug-print-width
    syn keyword schemeGaucheExtFunc dry-run
    syn keyword schemeGaucheExtFunc http-user-agent
    syn keyword schemeGaucheExtFunc log-default-drain
    syn keyword schemeGaucheExtFunc module-reload-rules
    syn keyword schemeGaucheExtFunc reload-verbose
    syn keyword schemeGaucheExtFunc ssax:warn-handler
    syn keyword schemeGaucheExtFunc temporary-directory
    syn keyword schemeGaucheExtFunc verbose-run


    " other lispwords
    set lispwords+=call-with-output-file
    set lispwords+=call-with-input-file
    set lispwords+=with-input-from-port
    set lispwords+=call-with-input-string
    set lispwords+=let-args

" meddlesome
set ts=8 sts=2 sw=2 et nocindent lisp
endif


" Synchronization and the wrapping up...

syn sync match matchPlace grouphere NONE "^[^ \t]"
" ... i.e. synchronize on a line that starts at the left margin

call scheme#syntax#srfi#define_srfi()
call scheme#syntax#define_highligts()
if exists("b:is_r7rs") || exists("g:is_r7rs")
  call scheme#syntax#r7rs#define_r7rs()
endif

let b:current_syntax = "scheme"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim:filetype=vim
