% $Id: TEX.mp,v 1.5 2005/03/19 20:16:08 taco Exp $
% Public domain.
% This file defines TEX <string_primary> to return the picture
% resulting from running the string through tex.  It is slow,
% but more general than the standard btex..etex construction
%
% New in this version (1.4), for metapost 0.9: 
% support of pre- and post TeX texts. 

string preverbatimtex_, postverbatimtex_; 

vardef TEXPRE text s =  preverbatimtex_ := s; enddef;

vardef TEXPOST text s =  postverbatimtex_ := s; enddef;

vardef TEX primary s =
  if known preverbatimtex_:
    write "verbatimtex "&preverbatimtex_&" etex" to "mptextmp.mp";
  fi
  write "btex "&s&" etex" to "mptextmp.mp";
  if known postverbatimtex_:
    write "verbatimtex "&postverbatimtex_&" etex" to "mptextmp.mp";
  fi
  write EOF to "mptextmp.mp";
  scantokens "input mptextmp"
enddef;

