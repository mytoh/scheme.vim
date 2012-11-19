
function! scheme#syntax#srfi#srfi_1#define_srfi_1()
  syntax keyword schemeFunc xcons cons* make-list list-tabulate list-copy circular-list iota
  syntax keyword schemeFunc proper-list? circular-list? dotted-list? not-pair? null-list? list=
  syntax keyword schemeFunc first second third fourth fifth sixth seventh eighth ninth tenth
  syntax keyword schemeFunc car+cdr take drop take-right drop-right take! drop-right! split-at split-at!
  syntax keyword schemeFunc last last-pair length+ concatenate append! concatenate! reverse!
  syntax keyword schemeFunc append-reverse append-reverse!
  syntax keyword schemeFunc zip unzip1 unzip2 unzip3 unzip4 unzip5 count
  syntax keyword schemeFunc fold unfold pair-fold reduce fold-right unfold-right
  syntax keyword schemeFunc pair-fold-right reduce-right
  syntax keyword schemeFunc append-map append-map! map! pair-for-each filter-map map-in-order
  syntax keyword schemeFunc filter partition remove filter! partition! remove! find find-tail any every
  syntax keyword schemeFunc list-index take-while drop-while take-while! span break span! break!
  syntax keyword schemeFunc delete delete-duplicates delete! delete-duplicates!
  syntax keyword schemeFunc alist-cons alist-copy alist-delete alist-delete!
  syntax keyword schemeFunc lset<= lset= lset-adjoin lset-union lset-union! lset-intersection
  syntax keyword schemeFunc lset-intersection! lset-difference lset-difference! lset-xor lset-xor!
  syntax keyword schemeFunc lset-diff+intersection lset-diff+intersection!
endfunction
