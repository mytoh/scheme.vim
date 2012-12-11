
function! scheme#syntax#irregex#define_keywords()
  syntax keyword schemeFunc irregex string->irregex sre->irregex
  syntax keyword schemeFunc string->sre maybe-string->sre
  syntax keyword schemeFunc irregex? irregex-match-data?
  syntax keyword schemeFunc irregex-new-matches irregex-reset-matches!
  syntax keyword schemeFunc irregex-search irregex-search/matches irregex-match
  syntax keyword schemeFunc irregex-search/chunked irregex-match/chunked make-irregex-chunker
  syntax keyword schemeFunc irregex-match-substring irregex-match-subchunk
  syntax keyword schemeFunc irregex-match-start-chunk irregex-match-start-index
  syntax keyword schemeFunc irregex-match-end-chunk irregex-match-end-index
  syntax keyword schemeFunc irregex-match-num-submatches irregex-match-names
  syntax keyword schemeFunc irregex-match-valid-index?
  syntax keyword schemeFunc irregex-fold irregex-replace irregex-replace/all
  syntax keyword schemeFunc irregex-dfa irregex-dfa/search irregex-dfa/extract
  syntax keyword schemeFunc irregex-nfa irregex-flags irregex-lengths irregex-names
  syntax keyword schemeFunc irregex-num-submatches irregex-extract irregex-split
endfunction

