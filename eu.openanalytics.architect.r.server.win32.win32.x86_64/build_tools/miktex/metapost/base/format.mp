% $Id: format.mp,v 1.2 2004/09/19 21:47:10 karl Exp $
% Public domain.

% Macros for generating typeset pictures of computed numbers

% format(f,x)               typeset generalized number x using format string f
% Mformat(f,x)              like format, but x is in Mlog form (see marith.mp)
% init_numbers(s,m,x,sn,e)  choose typeset style given sample sign, mantissa,...
% roundd(x,d)               round numeric x to d places right of decimal point
% Fe_base                   what precedes the exponent for typeset powers of 10
% Fe_plus                   plus sign if any for typesetting positive exponents
% Ten_to[]                  powers of ten for indices 0,1,2,3,4

% Other than the above-documented user interface, all externally visible names
% start with F and end with _.


if unknown Fmfont_:                     % If this file has not been read yet
begingroup interim warningcheck:=0;     % Allow big numbers in token lists

input string


%%%%%%%%%%%%%%%%%%%%%%% Choosing the Layout %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

picture Fmneg_, Femarker_, Feneg_, Fe_base, Fe_plus;
string Fmfont_, Fefont_;
numeric Fmscale_, Fescale_, Feraise_;


% Argument s is a leading minus sign;  m is a 1-digit mantissa;
% x is whatever follows the mantissa; sn is a leading minus for the exponent;
% and e is a 1-digit exponent.  Numbers in scientific notation are constructed
% by placing these peices side-by-side; decimal numbers use only m and/or s.
% To get exponenets with leading plus signs, assign to Fe_plus after calling
% init_numbers.  To do something special with a unit mantissa followed by x,
% assign to Fe_base after calling init_numbers.
vardef init_numbers(expr s, m, x, sn, e) =
  Fmneg_ := s;
  for p within m: 
    Fmfont_ := fontpart p;
    Fmscale_ := xxpart p;
    exitif true;
  endfor
  Femarker_ := x;
  Feneg_ := sn;
  for p within e:
    Fefont_ := fontpart p;
    Fescale_ := xxpart p;
    Feraise_ := ypart llcorner p;
    exitif true;
  endfor
  Fe_base := Fline_up_("1" infont Fmfont_ scaled Fmscale_, Femarker_);
  Fe_plus := nullpicture;
enddef;



%%%%%%%%%%%%%%%%%%%%%%% Low-Level Typesetting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef Fmant_(expr x) =
  (decimal abs x infont Fmfont_ scaled Fmscale_)
enddef;

vardef Fexp_(expr x) =
  (decimal x infont Fefont_ scaled Fescale_ shifted (0,Feraise_))
enddef;

vardef Fline_up_(text t_) =
  save p_, c_;
  picture p_; p_=nullpicture;
  pair c_; c_=(0,0);
  for q_=t_:
    addto p_ also q_ if string q_: infont defaultfont scaled defaultscale fi
        shifted c_;
    c_ := (xpart lrcorner p_, 0);
  endfor
  p_
enddef;

vardef Fdec_o_(expr x) =
  if x<0: Fline_up_(Fmneg_, Fmant_(x))
  else: Fmant_(x)
  fi
enddef;

vardef Fsci_o_(expr x, e) =
  Fline_up_(if x<0: Fmneg_,fi
      if abs x =1:  Fe_base  else:  Fmant_(x), Femarker_  fi,
      if e<0:  Feneg_  else:  Fe_plus  fi,
      Fexp_(abs e))
enddef;


% Assume troffmode=1 implies troff mode. This internal is present
% since version 0.99, and should be set in the change file.  
% As a default, fall back to the previous 'prologues=1' test.
% The mpx file mechanism requires separate input files here.
if troffmode=1:  input troffnum
else:  
  if prologues=1:  input troffnum
  else:            input texnum
  fi
fi



%%%%%%%%%%%%%%%%%%%%%%% Scaling and Rounding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Find a pair p where x=xpart p*10**ypart p and either p=(0,0) or xpart p is
% between 1000 and 9999.99999.  This is the `exponent form' of x.
vardef Feform_(expr x) =
  interim warningcheck:=0;
  if string x:
    if unknown Mzero: scantokens "input marith"; fi
    Meform(Mlog_str x)
  else:
    save b, e;
    b=x; e=0;
    if abs b>=10000: (b/10, 1)
    elseif b=0: origin
    else: forever:
      exitif abs b>=1000;
      b:=b*10; e:=e-1;
      endfor
     (b, e)
    fi
  fi
enddef;

% The marith.mp macros include a similar macro Meform that converts from
% `Mlog form' to exponent form.


% In case rounding has made the xpart of an exponent form number too large,
% fix it.
vardef Feadj_(expr x, y) =
  if abs x>=10000: (x/10, y+1)   else: (x,y)  fi
enddef;


% Round x to d places right of the decimal point.  When d<0, round to the
% nearest multiple of 10 to the -d.
vardef roundd(expr x, d) =
  if abs d >4:
    if d>0: x else: 0 fi
  elseif d>0:
    save i; i=floor x;
    i + round(Ten_to[d]*(x-i))/Ten_to[d]
  else:
    round(x/Ten_to[-d])*Ten_to[-d]
  fi
enddef;

Ten_to0=1; Ten_to1=10; Ten_to2=100; Ten_to3=1000; Ten_to4=10000;



% Round an exponent form number p to k significant figures.
primarydef p Fprec_ k =
  Feadj_ (roundd(xpart p,k-4), ypart p)  enddef;

% Round an exponent form number p to k digits right of the decimal point.
primarydef p Fdigs_ k =
  Feadj_ (roundd(xpart p,k+ypart p), ypart p)  enddef;



%%%%%%%%%%%%%%%%%%%%%%% High-Level Routines %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The following operators convert z from exponent form and produce typeset
% output:  Formsci_ generates scientific notation; Formdec_ generates decimal
% notation; and Formgen_ generates whatever is likely to be most compact.

vardef Formsci_(expr z) = Fsci_o_(xpart z/1000, ypart z +3)  enddef;

vardef Formdec_(expr z) =
  if ypart z>0: Formsci_(z)
  else:
    Fdec_o_(xpart z
        if ypart z>=-4: /Ten_to[-ypart z]
	else: for i=ypart z upto -5: /(10) endfor/10000  fi)
  fi
enddef;

vardef Formgen_(expr q) =
  clearxy; (x,y)=q;
  if x=0: Formdec_
  elseif y>=-6: Formdec_
  else: Formsci_
  fi (q)
enddef;


def Fset_item_(expr s) =
  if s<>"":  s infont defaultfont scaled defaultscale,  fi
enddef;


% For each format letter, the table below tells how to round and typeset
% a quantity z in exponent form.
string fmt_[];
fmt_[ASCII "e"] = "Formsci_(z Fprec_ p)"; % scientific, p significant figures
fmt_[ASCII "f"] = "Formdec_(z Fdigs_ p)"; % decimal, p digits right of the point
fmt_[ASCII "g"] = "Formgen_(z Fprec_ p)"; % decimal or scientific, p sig. figs.
fmt_[ASCII "G"] = "Formgen_(z Fdigs_ p)"; % decimal or scientific, p digits


% The format and Mformat macros take a format string f and generate typeset
% output for a numeric quantity x.  String f should contain a `%' followed by
% an optional number and one of the format letters defined above.  The number
% should be an integer giving the precision (default 3).  

vardef dofmt_@#(expr f, x) =
  if f="": nullpicture
  else:
    interim warningcheck:=0;
    save k, l, s, p, z;
    pair z; z=@#(x);
    k = 1 + cspan(f, "%"<>);
    l-k = cspan(substring(k,infinity)of f, isdigit);
    p = if l>k:  scantokens substring(k,l)of f  else: 3 fi;
    string s; s=fmt_[ASCII substring (l,l+1) of f];
    if unknown s:
      if k<=length f: errmessage("No valid format letter found in "&f); fi
      s = "nullpicture";
    fi
    Fline_up_(
      Fset_item_(substring (0,k-1) of f)
      scantokens s,
      Fset_item_(substring (l+1,infinity) of f)
      nullpicture)
  fi
enddef;

vardef format(expr f, x) = dofmt_.Feform_(f,x) enddef;
vardef Mformat(expr f, x) = dofmt_.Meform(f,x) enddef;


endgroup;    % restore warningcheck to previous value
fi           % end the if..fi that encloses this file
