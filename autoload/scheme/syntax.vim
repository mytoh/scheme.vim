
function! scheme#syntax#define_highligts()
" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_scheme_syntax_inits")
  if version < 508
    let did_scheme_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink schemeSyntax		Statement
  HiLink schemeFunc		Function

  HiLink schemeString		String
  HiLink schemeCharacter		Character
  HiLink schemeNumber		Number
  HiLink schemeBoolean		Boolean

  HiLink schemeDelimiter	Delimiter
  HiLink schemeConstant		Constant

  HiLink schemeComment		Comment
  HiLink schemeMultilineComment	Comment
  HiLink schemeError		Error
  HiLink schemeTodo             Todo

  HiLink schemeExtSyntax	Type
  HiLink schemeExtFunc		PreProc

  HiLink schemeRegexp		schemeString
  HiLink schemeSrfi62Comment	schemeComment
  HiLink schemeSharpBang	Special
  HiLink schemeInclude		Include
  HiLink schemeInterpolation	Debug

  delcommand HiLink
endif

endfunction
