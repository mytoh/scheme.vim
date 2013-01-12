
let s:save_cpo = &cpo
set cpo&vim

function! mzscheme#syntax#define_keywords()
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
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
