% $Id: boxes.mp,v 1.5 2005/02/25 11:28:56 taco Exp $
% Public domain.

% Macros for boxes


% Find the length of the prefix of string s for which cond is true for each
% character c of the prefix
vardef str_prefix(expr s)(text cond) =
  save i_, c; string c;
  i_ = 0;
  forever:
    c := substring (i_,i_+1) of s;
    exitunless cond;
    exitif incr i_=length s;
  endfor
  i_
enddef;

% Take a string returned by the str operator and return the same string
% with explicit numeric subscripts replaced by generic subscript symbols [].
%
% Fixed version supplied by Eddie Kohler

vardef generisize (expr ss) =
  save res, s, stest, l; string res, s, stest;
  res = "";             % result so far
  s = ss;               % left to process
  forever: exitif s="";
    l := str_prefix(s, (c<>"[") and ((c<"0") or (c>"9")));
    res := res & substring (0,l) of s;
    s := substring (l,infinity) of s;
    if s<>"":
      if (s>="[") and (length s > 1):
        stest := substring (1,2) of s;
        if stest="[":
          l := 2;
          res := res & "[[";
        else:
          l := 1 + str_prefix(s, c<>"]");
          res := res & "[]";
        fi
      else:
        res := res & "[]";
        l := str_prefix(s, (c=".") or ("0"<=c) and (c<="9"));
      fi
      s := substring(l,infinity) of s;
    fi
  endfor
  res
enddef;


% Make sure the string _n_gen_ is generisize(_n_):
vardef set_n_gen_ =
  if _n_ <> _n_cur_:
    _n_cur_:=_n_;
    _n_gen_:=generisize(_n_);
  fi
enddef;

string _n_, _n_cur_, _n_gen_;
_n_cur_ := "]";              % this won't match _n_


% Given a type t and list of variable names vars, make sure that they are
% of type t and redeclare them as necessary.  In the vars list _n represents
% scantokens _n_, a suffix that might contain numeric subscripts.
% This suffix needs to be replaced by scantokens _n_gen_ in order to get
% a variable that can be declared to be of type t.
vardef generic_declare(text t) text vars =
  set_n_gen_;
  forsuffixes v_=vars:
    if  forsuffixes _n=scantokens _n_: not t v_ endfor:
      def _gdmac_ text _n = t v_ enddef;
      expandafter _gdmac_ scantokens _n_gen_;
    fi
  endfor
enddef;

% Here is another version that redeclares the vars even if they are already
% of the right type.
vardef generic_redeclare(text t) text vars =
  set_n_gen_;
  def _gdmac_ text _n = t vars enddef;
  expandafter _gdmac_ scantokens _n_gen_;
enddef;







% pp should be a string giving the name of a macro that finds the boundary path
% sp should be a string that names a macro for fixing the size and shape
% The suffix $ is the name of the box
% The text t gives the box contents: either empty, a picture, or a string to
% typeset
def beginbox_(expr pp,sp)(suffix $)(text t) =
  _n_ := str $;
  generic_declare(pair) _n.off, _n.c;
  generic_declare(string) pproc_._n, sproc_._n;
  generic_declare(picture) pic_._n;
  pproc_$:=pp; sproc_$:=sp;
  pic_$ := nullpicture;
  for _p_=t:
    pic_$:=
      if picture _p_: _p_
      else: _p_ infont defaultfont scaled defaultscale
      fi;
  endfor
  $c = $off + .5[llcorner pic_$, urcorner pic_$]
enddef;


% The suffix cl names a vardef macro that clears box-related variables
% The suffix $ is the name of the box being ended.
def endbox_(suffix cl, $) =
  if known pic_.prevbox: _dojoin(prevbox,$); fi
  def prevbox = $ enddef;
  expandafter def expandafter clearboxes expandafter =
    clearboxes cl($);
  enddef
enddef;


% Text t gives equations for joining box a to box b.
def boxjoin(text t) =
  def prevbox=_ enddef;
  def _dojoin(suffix a,b) = t enddef;
enddef;


extra_beginfig := extra_beginfig
  & "boxjoin();save pic_,sproc_,pproc_;def clearboxes=enddef;";
extra_endfig := extra_endfig & "clearboxes;";


% Given a list of box names, give whatever default values are necessary
% in order to fix the size and shape of each box.
vardef fixsize(text t) =
  forsuffixes $=t:  scantokens sproc_$($);  endfor
enddef;


% Given a list of box names, give default values for any unknown positioning
% offsets
vardef fixpos(text t) =
  forsuffixes $=t:
    if unknown xpart $.off:  xpart $.off=0; fi
    if unknown ypart $.off:  ypart $.off=0; fi
  endfor
enddef;


% Return the boundary path for the given box
vardef bpath suffix $ =
  fixsize($); fixpos($);
  scantokens pproc_$($)
enddef;


% Return the contents of the given box.  First define a private version that
% the user can't accidently clobber.
vardef pic_mac_ suffix $ =
  fixsize($); fixpos($);
  pic_$ shifted $off
enddef;

vardef pic suffix $ = pic_mac_ $ enddef;


def drawboxed(text t) =         % Draw each box
  fixsize(t); fixpos(t);
  forsuffixes s=t: draw pic_mac_.s; draw bpath.s; endfor
enddef;

def drawunboxed(text t) =       % Draw contents of each box
  fixsize(t); fixpos(t);
  forsuffixes s=t: draw pic_mac_.s; endfor
enddef;

def drawboxes(text t) =         % Draw boundary path for each box
  forsuffixes s=t: draw bpath.s; endfor
enddef;





% Rectangular boxes

newinternal defaultdx, defaultdy;
defaultdx := defaultdy := 3bp;

vardef boxit@#(text tt) =
  beginbox_("boxpath_","sizebox_",@#,tt);
  generic_declare(pair) _n.sw, _n.s, _n.se, _n.e, _n.ne, _n.n, _n.nw, _n.w;
  0 = xpart (@#nw-@#sw) = ypart(@#se-@#sw);
  0 = xpart(@#ne-@#se) = ypart(@#ne-@#nw);
  @#w = .5[@#nw,@#sw];
  @#s = .5[@#sw,@#se];
  @#e = .5[@#ne,@#se];
  @#n = .5[@#ne,@#nw];
  @#ne-@#c = @#c-@#sw = (@#dx,@#dy) + .5*(urcorner pic_@# - llcorner pic_@#);
  endbox_(clearb_,@#);
enddef;

def boxpath_(suffix $) =
  $.sw -- $.se -- $.ne -- $.nw -- cycle
enddef;

def sizebox_(suffix $) =
  if unknown $.dx: $.dx=defaultdx; fi
  if unknown $.dy: $.dy=defaultdy; fi
enddef;

vardef clearb_(suffix $) =
  _n_ := str $;
  generic_redeclare(numeric) _n.sw, _n.s, _n.se, _n.e, _n.ne, _n.n, _n.nw, _n.w,
    _n.c, _n.off, _n.dx, _n.dy;
enddef;





% Circular and oval boxes

newinternal circmargin; circmargin:=2bp;  % default clearance for picture corner

vardef circleit@#(text tt) =
  beginbox_("thecirc_","sizecirc_",@#,tt);
  generic_declare(pair) _n.n, _n.s, _n.e, _n.w;
  @#e-@#c = @#c-@#w = (@#dx,0) + .5*(lrcorner pic_@#-llcorner pic_@#);
  @#n-@#c = @#c-@#s = (0,@#dy) + .5*(ulcorner pic_@#-llcorner pic_@#);
  endbox_(clearc_,@#);
enddef;

def thecirc_(suffix $) =
  $.e{up} ... $.n{left} ... $.w{down} ... $.s{right} ... cycle
enddef;

vardef clearc_(suffix $) =
  _n_ := str $;
  generic_redeclare(numeric) _n.n, _n.s, _n.e, _n.w, _n.c, _n.off, _n.dx, _n.dy;
enddef;

vardef sizecirc_(suffix $) =
  save a_, b_;
  (a_,b_) = .5*(urcorner pic_$ - llcorner pic_$);
  if unknown $dx:
    if unknown $dy:
      if unknown($dy-$dx): a_+$dx=b_+$dy; fi
      if a_+$dx=b_+$dy: a_+$dx = a_++b_ + circmargin;
      else: $dx =
        pathsel_(max(a_,b_+$dx-$dy), (a_+d_,0){up}...(0,b_+d_+$dy-$dx){left});
      fi
    else: $dx = pathsel_(a_, (a_+d_,0){up}...(0,b_+$dy){left});
    fi
  elseif unknown $dy:
    $dy = pathsel_(b_, (a_+$dx,0){up}...(0,b_+d_){left});
  fi
enddef;

vardef pathsel_(expr dhi)(text tt) =
  save f_, p_; path p_;
  p_ = origin..(a_,b_)+circmargin*unitvector(a_,b_);
  vardef f_(expr d_) =
    xpart((tt) intersectiontimes p_) >= 0
  enddef;
  solve f_(0,dhi+1.5circmargin)
enddef;
