% $Id: ao,v 1.2 2004/09/19 21:47:11 karl Exp $
% Public domain.
vardef C.ao(expr n) =
 save p,q; picture p,q;
 p="a"infont n;
 q=char202 infont n;
 addto p also q
  shifted(xpart(urcorner p-urcorner q)/2,.05*fontsize n);
 p enddef;
