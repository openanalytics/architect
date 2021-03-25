% $Id: marith.mp,v 1.2 2004/09/19 21:47:10 karl Exp $
% Public domain.

% Macros for dealing with very large and very small numbers in `Mlog form'.

% A number x in Mlog form represents mexp(x) if x is an even multiple of
% epsilon and -mexp(x) if x is an odd multiple of epsilon, where epsilon=1/65536
% is the basic unit for MetaPost's fixpoint numbers.  Such numbers can represent
% values large as 3.8877e+55 or as small as 1.604e-28.  (Anything less than that
% is treated as zero.)

% Mlog_str <string>            convert a string like "6.02e23" to Mlog form
% Mexp_str <M_numeric>         convert from Mlog form to a string like "6.02e23" 
% Meform(q)                    find (x,y) such that q is the Mlog form of x*10^y
% Mlog <numeric>               convert a number to Mlog form
% Mexp <M_numeric>             convert from Mlog form into ordinary numeric form
% Mabs <M_numeric>             absolute value
% Mlog_Str <string or numeric> convert to Mlog form; unknown results in unknown
% <M_numeric> Madd <M_numeric> add
% <M_numeric> Msub <M_numeric> subtract
% <M_numeric> Mmul <M_numeric> multiply
% <M_numeric> Mdiv <M_numeric> divide
% <M_numeric> Mleq <M_numeric> the boolean operator <=
% Mzero                        constant that represents zero
% Mten                         constant that represents 10.0

% All other externally visible names start with `M' and end with `_'.



warningcheck := 0;  % Need warningcheck:=0 anytime these macros are in use

if unknown Mzero:   % If we have not already seen this file

newinternal Mzero;
Mzero := -16384;    % Anything at least this small is treated as zero


input string.mp



% Ideal value of mlog(10) is 589.4617838 or 38630967.46/65536.  To get an even
% numerator, we round to 38630968/65536 or 589.4617920.
newinternal Mten;
Mten := 589.46179;

% Convert x*10^y to Mlog form, assuming x is already in Mlog form.
primarydef  x M_e_ y = (x+Mten*y) enddef;

def Mgobble_ text t = enddef;
pair M_iv_; M_iv_=(0,4);


% String s is a number in scientific notatation with no leading spaces.
% Convert it to Mlog form.
vardef Mlog_str primary s =
  save k, t, e, r;
  string t;
  if substring(0,1) of s="-":
    r=-epsilon; t=substring (1,infinity) of s;
  else:
    r=0; t=s;
  fi
  let e = Mgobble_;
  if begingroup scantokens substring M_iv_ of t endgroup >= 1000:
    k = cspan(t,isdigit);
    t := substring M_iv_ of t  &  "."  &  substring(4,k) of t  &
         substring (k if substring(k,k+1) of t=".": +1 fi, infinity) of t;
    r := r + (k-4)*Mten;
  fi
  let e = M_e_;
  r + Mlog scantokens t
enddef;


% Convert x from Mlog form into a pair whose xpart gives a mantissa and whose
% ypart gives a power of ten.  The constant 1768.38985 is slightly more than
% 3Mten as is required to ensure that 3Mten-epsilon<=q+e*Mten<4Mten-epsilon.
% This forces the xpart of the result to be between 1000 and 10000.
vardef Meform(expr q) =
  if q<=Mzero: (0,0)
  else:
    save e; e=floor((q-1768.38985)/Mten);
    (Mexp(q-e*Mten), e)
  fi
enddef;

% Perform the inverse of Mlog_str, converting from Mlog form to a string.
vardef Mexp_str primary x =
  save p;
  pair p; p=Meform(x);
  decimal xpart p
  if ypart p<>0: & "e" & decimal ypart p fi
enddef;


vardef Mabs primary x = x*.5*2 enddef;

% Convert a number to Mlog form
vardef Mlog primary x =
  if x>0: Mabs mlog x
  elseif x<0: epsilon + Mabs mlog(-x)
  else: Mzero
  fi
enddef;


% Convert a number from Mlog form
vardef Mexp primary x =
  if x=Mabs x: mexp x
  else: -mexp x
  fi
enddef;


primarydef a Mmul b =
  if (a<=Mzero) or (b<=Mzero): Mzero
  else: (a+b)
  fi
enddef;


primarydef a Mdiv b =
  if a<=Mzero: Mzero
  else: (a-b)
  fi
enddef;


% 256ln(1579)=123556596.0003/65536=1885.3240356445
secondarydef a Madd b =
  if a>=b: (Mlog(1579 + Mexp(b Mmul (1885.32404-a))) + a-1885.32404)
  else:  b Madd a
  fi
enddef;


secondarydef a Msub b = a Madd (b-epsilon) enddef;


tertiarydef a Mleq b =
  (if a=Mabs a:
    if b=Mabs b: a<=b else: false fi
   elseif b=Mabs b: true else: b<=a fi
  )
enddef;



vardef Mlog_Str primary x =
  if unknown x: whatever
  elseif string x: Mlog_str x
  else: Mlog x
  fi
enddef;


fi   % end the if..fi that encloses this file
