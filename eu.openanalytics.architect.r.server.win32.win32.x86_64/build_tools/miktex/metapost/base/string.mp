% $Id: string.mp,v 1.2 2004/09/19 21:47:11 karl Exp $
% Public domain.

% String manipulation routines for MetaPost
% It is harmless to input this file more than once.


vardef isdigit primary d =
  ("0"<=d)and(d<="9") enddef;


% Number of initial characters of string s where `c <character>' is true
vardef cspan(expr s)(text c) =
  0
  for i=1 upto length s:
    exitunless c substring (i-1,i) of s;
    + 1
  endfor
enddef;


% String s is composed of items separated by white space.  Lop off the first
% item and the surrounding white space and return just the item.
vardef loptok suffix s =
  save t, k;
  k = cspan(s," ">=);
  if k>0: s:=substring(k,infinity) of s; fi
  k := cspan(s," "<);
  string t;
  t = substring (0,k) of s;
  s := substring (k,infinity) of s;
  s := substring (cspan(s," ">=),infinity) of s;
  t
enddef;
