% $Id: graph.mp,v 1.2 2004/09/19 21:47:10 karl Exp $
% Public domain.

% Macros for drawing graphs

% begingraph(width,height)       begin a new graph
% setcoords(xtype,ytype)         sets up a new coordinate system (log,-linear..)
% setrange(lo,hi)                set coord ranges (numeric and string args OK)
% gdraw <file or path> [with...] draw a line in current coord system
% gfill <file or path> [with...] fill a region using current coord system
% gdrawarrow .., gdrawdblarrow.. like gdraw, but with 1 or 2 arrowheads
% Mreadpath(<filename>)          read path from file and return it in Mlog form
% augment<path name>(loc)        append given coordinates to a polygonal path
% glabel<suffix>(pic,loc)        place label pic near graph coords or time loc
% gdotlabel<suffix>(pic,loc)     same with dot
% OUT                            loc value for labels relative to whole graph
% gdata(file,s,text)             read coords from file; evaluate t w/ tokens s[]
% auto.<x or y>                  default x or y tick locations (for interation)
% itick.<bot|top|..>(fmt,u)      draw inward tick from given side at u w/ format
% otick.<bot|top|..>(fmt,u)      draw outward tick at coord u; label format fmt
% grid.<bot|top|..>(fmt,u)       draw grid line at u with given side labelled
% autogrid([itick|.. bot|..],..) iterate over auto.x, auto.y, drawing tick/grids
% frame.[bot|top..]              draw frame (or one side of the frame)
% endgraph                       end of graph--the result is a picture

% option `plot <picture>'        draws picture at each path knot, turns off pen
% Gtemplate.<tickcmd>            template paths for tick marks and grid lines
% Gmargin.low, Gmargin.high      fractions determining margins when no setrange
% Glmarks[], Gumarks, Gemarks    loop text strings used by auto.<x or y>
% Gmarks, Gminlog                numeric parameters used by auto.<x or y>
% Gpaths                         tells how to interpret paths: log or linear
% Autoform                       is the format string used by autogrid

% Other than the above-documented user interface, all externally visible names
% are of the form X_.<suffix>, Y_.<suffix>, or Z_.<suffix>, or they start
% with `G' and end with `_'.


if unknown Mzero:
  begingroup interim	% marith.mp starts with `warningcheck:=0'
  input marith
  endgroup;             % restore warningcheck; we zero it when necessary
fi
if unknown mant_font:
  input format
fi


vardef Gerr_(expr x,s) =
  interim showstopping:=0;
  show x; errmessage s;
enddef;



%%%%%%%%%%%%%%%%%%%%%%%% Data structures, begingraph %%%%%%%%%%%%%%%%%%%%%%%%

vardef Z_@# = (X_@#,Y_@#) enddef; % used in place of plain.mp's z convention

def Gsuf_(suffix $) =             % convert from x or y to X_ or Y_
  if str$="x": X_ else: Y_ fi
enddef;


def begingraph(expr w, h) =
  begingroup
  save X_, Y_, Gfin_, Gcur_, Gcbb_, Gneedgr_, Gneedfr_, Gdidsc_;
  save Gdpic_, Gppic_, Ggl_, Garw_;
  picture Gfin_, Gcur_, Gcbb_, Gdpic_, Gppic_, Ggl_[];
  boolean Gneedgr_, Gneedfr_, Gdidsc_;
  Gfin_ = nullpicture;          % the finished part of the graph
  Gcur_ = nullpicture;          % what has been drawn in current coords
  Gcbb_ = nullpicture;          % picture whose bbox is Gcur_'s w/ linewidths 0
  X_.ctyp = Y_.ctyp = linear;   % coordinate system for each axis
  Z_.gdim = (w,h);              % dimensions of graph not counting axes etc.
  X_.sc = Y_.sc = 0;            % Mlog(the amount Gcur_ has been descaled by)
  Gneedgr_ = true;              % whether autogrid is needed
  Gneedfr_ = true;              % whether frame needs to be drawn
  Gdidsc_ = false;              % set when Glinsc_ rescales coordinates
  Gdpic_ = nullpicture;         % result of last gdraw or gfill
  Garw_ = 0;                    % number of arrowheads for next gdraw
enddef;

% Additional variables not explained above:
% Z_.low, Z_.high       user-specified coordinate ranges in units used in Gcur_
% Gppic_                a picture from the `plot' option known when plot allowed
% Gmll_, Gmhh_          pairs giving bounds used in auto<x or y>
% Gme_, Gcma_           variables and macros used in auto<x or y>
% Gc_                   temporary macro used in auto<x or y>
% Gbias_                an offset to Gmll_ and Gmhh_ to ease computing exponents
% Ggl_[]                labels to place around the whole graph when it is done
% Some additional variables function as constants.  Most can be modified by the
% user to alter the behavior of these macros.
% Not very modifiable:  log, linear, Gboff_, Gfra_, Gfrb_, Gmarg_
% Modifiable:           Gtemplate.suffix, Glmarks[], Gumarks, Gemarks, Gmarks,
%                       Gminlog, Gpaths, Autoform


newinternal log, linear;        % coordinate system codes
newinternal Gpaths;             % path interpretation parameter
log:=1; linear:=2;
Gpaths := linear;



%%%%%%%%%%%%%%%%%%%%%% Coordinates: setcoords, setrange %%%%%%%%%%%%%%%%%%%%%%

% Graph-related usr input is `user graph coordinates' as specified by arguments
% to setcoords.
% `Internal graph coordinates' are used for Gcur_, Gcbb_, Z_.low, Z_.high.
% Their meaning depends on the appropriate component of Z_.ctyp:
% log means internal graph coords = Mlog(user graph coords)
% -log means internal graph coords = -Mlog(user graph coords)
% linear means internal graph coords = Mexp(Mlog(user graph coords) Mdiv ?sc)
% -linear means internal graph coords = -Mexp(Mlog(user graph coords) Mdiv ?sc)
% (In the last two lines, `?sc' means X_.sc or Y_.sc as appropriate.)


vardef Gsetp_ =         % Set default Z_.low, Z_.high
  forsuffixes $=low,high:
    (if known X_$: whatever else: X_$ fi, if known Y_$: whatever else: Y_$ fi)
        = Gmargin$[llcorner Gcbb_,urcorner Gcbb_] + Gmarg_$;
  endfor
enddef;
pair Gmarg_.low, Gmarg_.high;
Gmarg_.high=-Gmarg_.low=(.00002,.00002);


% Set $, $$, $$$ so that shifting by $ then transforming by $$ and then $$$
% maps the essential bounding box of Gcur_ into (0,0)..Z_.gdim.  The
% `essential bounding box' is either what Z_.low and Z_.high imply or the
% result of ignoring pen widths in Gcur_.
vardef Gsetsc_(suffix $,$$,$$$) =
  save p_;
  Gsetp_;
  pair p_, $; $=Gboff_-Z_.low;
  p_ = (max(X_.high-X_.low,.9), max(Y_.high-Y_.low,.9));
  transform $$, $$$;
  forsuffixes #=$$,$$$: xpart#=ypart#=xypart#=yxpart#=0; endfor
  (Z_.high+Gboff_+$) transformed $$ = p_;
  p_ transformed $$$ = Z_.gdim;
enddef;
Gmargin.low=-.07;                       % bbox fraction for default range start
Gmargin.high=1.07;                      % bbox fraction for default range stop
pair Gboff_; Gboff_=epsilon*(3,3);      % allowance to avoid numerical trouble


def Gwithpc_(expr q) =
  withpen penpart q withcolor
  if colormodel q=1:
    false
  elseif colormodel q=3:
    (greypart q)
  elseif colormodel q=5:
    (redpart q, greenpart q, bluepart q)
  elseif colormodel q=7:
    (cyanpart q, magentapart q, yellowpart q, blackpart q)
  fi
enddef;

% Add picture component q to picture @# and change part p to tp, where p is
% something from q that needs coordinate transformation.  The type of p is pair
% or path.
% Pair o is the value of p that makes tp (0,0).  This implements the trick
% whereby using 1 instead of 0 for th the width or height or the setbounds path
% for a label picture supresses shifting in x or y.
vardef old_Gpconv_@#(expr q, o)(text tp) =
  save p;
  if stroked q:
    path p; p=pathpart q;
    addto @# doublepath tp Gwithpc_(q) dashed dashpart q;
  elseif filled q:
    path p; p=pathpart q;
    addto @# contour tp Gwithpc_(q);
  else:
    interim truecorners:=0;
    pair p; p=llcorner q;
    if urcorner q<>p: p:=p+Gcmul_(o-p,urcorner q-p); fi
    addto @# also q shifted ((tp)-llcorner q);
  fi
enddef;
% TH: new version from code found at sarovar tracker. This makes 
%     grdaw clip the result to the window defined with setrange
vardef Gpconv_@#(expr q, o)(text tp) =
  save p, tp_geclipt; 
  picture tp_geclipt; tp_geclipt:=nullpicture;
  if stroked q:
    path p; p=pathpart q;
    %%%  --- SDV added
      addto tp_geclipt doublepath tp Gwithpc_(q) dashed dashpart q;
      clip tp_geclipt to origin--(xpart Z_.gdim,0)--Z_.gdim--(0, ypart Z_.gdim)--cycle;
      addto @# also tp_geclipt;
    %%%  
    %%%  --- SDV deleted
    %%addto @# doublepath tp Gwithpc_(q) dashed dashpart q;
    %%%
  elseif filled q:
    path p; p=pathpart q;
    addto @# contour tp Gwithpc_(q);
  else:
    interim truecorners:=0;
    pair p; p=llcorner q;
    if urcorner q<>p: p:=p+Gcmul_(o-p,urcorner q-p); fi
    addto @# also q shifted ((tp)-llcorner q);
  fi
enddef;

def Gcmul_(expr a,b) = (xpart a*xpart b, ypart a*ypart b) enddef;


vardef Gclbnds_@# =  numeric @#.low, @#.high;  enddef;


% Finalize anything drawn in the present coordinate system and set up a new
% system as requested
vardef setcoords(expr tx, ty) =
  interim warningcheck:=0;
  if length Gcur_>0:
    save s, S, T;
    Gsetsc_(s, S, T);
    for q within Gcur_:
      Gpconv_.Gfin_(q, -s, p shifted s transformed S transformed T);
    endfor
    Gcur_ := Gcbb_ := nullpicture;
  fi
  Gclbnds_.X_; Gclbnds_.Y_;
  X_.ctyp:=tx; Y_.ctyp:=ty;
enddef;


% Use scaling command cc to rescale everything in internal graph coords so that
% if Mlog(user graph coords) is u then the internal graph coord value becomes
% 10000/128.  Assume u>=$sc+4Mten where $ is X_ or Y_, depending on whether cc
% is xscaled or yscaled.
vardef Glinsc_@#(expr u)(text cc) =
  save v, P;
  v = mexp(4Mten + (@#sc-u));
  picture P; P=nullpicture;
  for q within Gcur_: Gpconv_.P(q, origin, p cc v cc 1/128); endfor
  Gcur_ := P;
  Gcbb_ := Gcbb_ cc v cc 1/128;
  forsuffixes $=low, high:
    if known @#.$: @#.$:=@#.$*v/128; fi
  endfor
  @#sc:= Mabs u -1115.72742;  % @#sc:=Mabs u+Mlog(128)-4Mten
  Gdidsc_ := true;
enddef;


% Convert x coordinate u from Mlog(user graph coords) to ctyp=linear internal
% graph coords.  If the result would be uncomfortably large, use Glinsc_ to
% descale as needed.
vardef Gxcvlin_ primary u =
  interim warningcheck:=0;
  if unknown u: u
  elseif u>X_.sc+4Mten:
    Glinsc_.X_(u,xscaled);
    78.125
  else: Mexp(u Mdiv X_.sc)
  fi
enddef;

vardef Gycvlin_ primary u =     % same as Gxcvlin_ but u is a y coordinate
  interim warningcheck:=0;
  if unknown u: u
  elseif u>Y_.sc+4Mten:
    Glinsc_.Y_(u,yscaled);
    78.125
  else: Mexp(u Mdiv Y_.sc)
  fi
enddef;


% Set Z_.low and Z_.high to correspond to given range of user graph
% coordinates.  The text argument should be a sequence of pairs and/or strings
% with 4 components in all.
vardef setrange(text t) =
  interim warningcheck:=0;
  save r_; r_=0;
  string r_[]s;
  for x_=
      for p_=t: if pair p_: xpart p_, ypart fi p_, endfor:
    r_[incr r_] if string x_: s fi = x_;
    if r_>2:
      Gsetr_ if r_=3: X_(Gxcvlin_) else: Y_(Gycvlin_) fi(
          r_[r_-2] if unknown r_[r_-2]: s fi, x_);
    fi
    exitif r_=4;
  endfor
enddef;


% @# is X_ or Y_; $ is Gxcvlin_ or Gycvlin_; l and h are numeric or string
% It would not be OK to set (@#low,@#high) to a pair expression because $ might
% try to rescale @#low when evaluating the right-hand side for @#high.
vardef Gsetr_@#(suffix $)(expr l, h) =
  Gclbnds_@#;
  if @#ctyp>0:
    @#low = if abs @#ctyp<>log: $ fi Mlog_Str l;
    @#high = if abs @#ctyp<>log: $ fi Mlog_Str h;
  else:
    -@#high = if abs @#ctyp<>log: $ fi Mlog_Str l;
    -@#low = if abs @#ctyp<>log: $ fi Mlog_Str h;
  fi
enddef;





%%%%%%%%%%%%%%%%%%%%%%%%% Converting path coordinates %%%%%%%%%%%%%%%%%%%%%%%%%

% Find the result of scanning path p and using macros tx and ty to adjust the
% x and y parts of each coordinate pair.  Boolean paramter c tells whether to
% force the result to be polygonal.
vardef Gscan_(expr p, c)(suffix tx, ty) =
  if (str tx="") and (str ty=""):  p
  else:
    save r_; path r_;
    forever:
      Gdidsc_ := false;
      r_ := Gpp_(point 0 of p, tx, ty)
      if path p:
        for t=1 upto length p:
          if c: --
          else: ..controls Gpp_(postcontrol(t-1) of p, tx, ty)
            and Gpp_(precontrol t of p, tx, ty) ..
          fi
          Gpp_(point t of p, tx, ty)
        endfor
        if cycle p: &cycle fi
      fi;
      exitunless Gdidsc_;
    endfor
    if pair p: point 0 of fi r_
  fi
enddef;
vardef Gpp_(expr p)(suffix tx, ty) = (tx xpart p, ty ypart p) enddef;


% Convert path p from Mlog(user graph coords) to internal graph coords.
% Boolean flag f says whether to force the result to be polygonal.
vardef GMcvi_(expr f) primary p =
  Gscan_(p, f,
      if abs X_.ctyp=linear: Gxcvlin_ fi,
      if abs Y_.ctyp=linear: Gycvlin_ fi)
    if X_.ctyp<0:  xscaled -1  fi
    if Y_.ctyp<0:  yscaled -1  fi
enddef;


% Convert path p from user graph coords to internal graph coords.
vardef Gucvi_ primary p =
  if Gpaths=log:
    GMcvi_((abs X_.ctyp<>log) or (abs Y_.ctyp<>log)) p
  else:
    interim warningcheck:=0;
    save t, u;
    t=Mexp(-X_.sc); u=Mexp(-Y_.sc);
    Gscan_(p, (abs X_.ctyp<>linear) or (abs Y_.ctyp<>linear),
        if abs X_.ctyp=log: Mlog fi,
        if abs Y_.ctyp=log: Mlog fi)
      transformed  (identity
        if abs X_.ctyp=linear:  xscaled t  fi
        if abs Y_.ctyp=linear:  yscaled u  fi
        if X_.ctyp<0:  xscaled -1  fi
        if Y_.ctyp<0:  yscaled -1  fi)
  fi
enddef;


% Convert label location t_ from user graph coords to internal graph coords.
% The label location should be a pair, or two numbers/strings.  If t_ is empty
% or a single item of non-pair type, just return t_.  Unknown coordinates
% produce unknown components in the result.
vardef Gtcvi_(text t_) =
  save n_; n_=0;
  interim warningcheck:=0;
  if 0 for x_=t_: +1 if pair x_: +1 fi endfor <= 1:
    t_
  else:
    n_0 = n_1 = 0;
    point 0 of GMcvi_(true) (
      for x_=
        for y_=t_: if pair y_: xpart y_, ypart fi y_, endfor
        0, 0:
        if known x_: Mlog_Str x_
        else: hide(n_[n_]:=whatever) Mzero
        fi
        exitif incr n_=2;
      ,endfor) + (n_0,n_1)
  fi
enddef;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Reading data files %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read a line from file f, extract whitespace-separated tokens ignoring any
% initial "%", and return true if at least one token is found.  The tokens
% are stored in @#1, @#2, .. with "" in the last @#[] entry.
vardef Grdln_@#(expr f) =
  save n_, s_; string s_;
  s_ = readfrom f;
  string @#[];
  if s_<>EOF:
    @#1 := loptok s_;
    n_ = if @#1="%": 0 else: 1 fi;
    forever:
      @#[incr n_] := loptok s_;
      exitif @#[n_]="";
    endfor
    @#1<>""
  else: false
  fi
enddef;


% Execute c for each line of data read from file f, and stop at the first
% line with no data.  Commands c can use line number i and tokens $1, $2, ...
def gdata(expr f)(suffix $)(text c) =
  for i=1 upto infinity:
    exitunless Grdln_$(f);
    c
  endfor
enddef;


% Read a path from file f and return it in Mlog form.  The path is terminated
% by blank line or EOF.
vardef Mreadpath(expr f) =
  interim warningcheck:=0;
  save s;
  gdata(f, s, if i>1:--fi
      if s2="": (Mlog i, Mlog_str s1)
      else: (Mlog_str s1, Mlog_str s2) fi)
enddef;


% Append coordinates t to polygonal path @#.  The coordinates can be numerics,
% strings, or a single pair.
vardef augment@#(text t) =
  interim warningcheck := 0;
  if not path begingroup @# endgroup:
    Gerr(begingroup @# endgroup, "Cannot augment--not a path");
  else:
    def Gcma_= hide(def Gcma_=,enddef) enddef;
    if known @#:  @#:=@#--  else:  @#=  fi
    (for p=t:
       Gcma_ if string p: Mexp Mlog_str fi p
     endfor);
  fi
enddef;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Drawing and filling %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Unknown pair components are set to 0 because glabel and gdotlabel understand
% unknown coordinates as `0 in absolute units'.
vardef Gupbb_(expr p) =
  interim warningcheck:=0; % This is needed because Gupbb_ has to work with internal graph coordinates which may be in Mlog form.
  if known p: addto Gcbb_ doublepath p;
  else:
    save x,y;
    z = llcorner Gcbb_;
    if unknown xpart p: xpart p= else: x:= fi 0;
    if unknown ypart p: ypart p= else: y:= fi 0;
    addto Gcbb_ doublepath (p+z);
  fi
  Gcbb_ := image(fill llcorner Gcbb_..urcorner Gcbb_--cycle);
enddef;


% Initiate a gdraw or gfill command.  This must be done before scanning the
% argument, because that could invoke the `if known Gppic_' test in a following
% plot option .
def Gaddto_ = Gdpic_:=Gppic_:=nullpicture; addto Gdpic_ enddef;


% Handle the part of a Gdraw command that uses path or data file p.
def Gdraw_ expr p =
  if string p: GMcvi_(true) Mreadpath(p)
  elseif path p or pair p: Gucvi_ p
  else: Gerr_(p,"gdraw argument should be a data file or a path")
        origin
  fi
  withpen currentpen Gwithlist_ _op_
enddef;


% Handle the part of a Gdraw command that uses path or data file p.
def Gfill_ expr p =
  if string p: GMcvi_(true) Mreadpath(p) --cycle
  elseif cycle p: Gucvi_ p
  else: Gerr_(p,"gfill argument should be a data file or a cyclic path")
        origin..cycle
  fi Gwithlist_ _op_
enddef;

def gdraw = Gaddto_ doublepath Gdraw_ enddef;
def gfill = Gaddto_ contour Gfill_ enddef;


% This is used in Gdraw_ and Gfill_ to allow postprocessing Gdpic_
def Gwithlist_ text t_ = t_; Gpostdr_; enddef;


% Set Gppic_ so the postprocessing step will plot picture p at each path knot.
% Also select nullpen to supress stroking.
def plot expr p =
  if known Gppic_:
    withpen nullpen
    hide (Gppic_:=image(
        if bounded p: for q within p: Gdrw_ q endfor    % Save memory
        else: Gdrw_ p
        fi Gsetb_ origin..cycle))
  fi
enddef;

% This hides a semicolon that could prematurely end Gwithlist_'s text argument
def Gdrw_ primary p = addto currentpicture also p; enddef;
def Gsetb_ = setbounds currentpicture to enddef;


def gdrawarrow = Garw_:=1; gdraw enddef;
def gdrawdblarrow = Garw_:=2; gdraw enddef;


% Post-process the filled or stroked picture Gdpic_ as follows: (1) update
% the bounding box information; (2) transfer it to Gcur_ unless the pen has
% been set to nullpen to disable stroking; (3) plot Gppic at each knot.
vardef Gpostdr_ =
  save p;
  path p; p=pathpart Gdpic_;
  Gupbb_(p);
  if filled Gdpic_ or not Gisnull_(penpart Gdpic_):
    addto Gcur_ also Gdpic_;
  fi
  if length Gppic_>0:
    for i=0 upto length p if cycle p: -1 fi:
      addto Gcur_ also Gppic_ shifted point i of p;
    endfor
    picture Gppic_;
  fi
  if Garw_>0:
    Garwhd_(p, Gwithpc_(Gdpic_));
    if Garw_>1: Garwhd_(reverse p, Gwithpc_(Gdpic_)); fi
    Garw_:=0;
  fi
enddef;
vardef Gisnull_(expr p) = (urcorner p=origin) and (llcorner p=origin) enddef;


vardef Garwhd_(expr p)(text w) =        % Draw arrowhead for path p, with list w
  addto Gcur_ also
    image(filldraw arrowhead(
            Garhwext_(precontrol infinity of p, point infinity of p)) w;
        Gsetb_ point infinity of p..cycle);
enddef;

vardef Garhwext_(expr p, q) =
  if p<>q: (q - 100pt*unitvector(q-p)) -- fi
  q
enddef;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Drawing labels %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Argument c is a drawing command that needs an additonal argument p that gives
% a location in internal graph coords.  Draw in Gcur_ enclosed in a setbounds
% path.  Unknown components of p cause the setbounds path to have width or
% height 1 instead of 0.  Then Gupbb_ sets these components to 0 and Gpconv_
% supresses subsequent repositioning.
def Glab_(expr p)(suffix $)(text c) =
  save sdim_; pair sdim_;
  sdim_ := (if unknown xpart p: 1+ fi 0, if unknown ypart p: 1+ fi 0);
  Gupbb_(p);
  addto Gcur_ also
    image(c(p); Gsetb_ p--p+sdim_--cycle) _op_
enddef;


% Stash the result drawing command c in the Ggl_ table using with list w and
% an index based on angle laboff$.
vardef Gglab_(suffix $)(text c) text w =
  Ggl_[1.5+angle laboff$ /90] = image(c(origin) w);
enddef;


def Glloc_ primary p =
  if pair p: Glab_(p)
  elseif numeric p: Glab_(point p of pathpart Gdpic_)
  else: Gglab_
  fi
enddef;


% Place label p at user graph coords t using with list w. (t is a time, a pair
% or 2 numerics or strings).
vardef glabel@#(expr p)(text t) text w  =
  Glloc_ Gtcvi_(t)  (@#,label@#(p)) w; enddef;


% Place label p at user graph coords t using with list w and draw a dot there.
% (t is a time, a pair, or 2 numerics or strings).
vardef gdotlabel@#(expr p)(text t) text w =
  Glloc_ Gtcvi_(t)  (@#,dotlabel@#(p)) w; enddef;


def OUT = enddef;       % location text for outside labels



%%%%%%%%%%%%%%%%%%%%%%%%%% Grid lines, ticks, etc. %%%%%%%%%%%%%%%%%%%%%%%%%%

% Grid lines and tick marks are transformed versions of the templates below.
% In the template paths, (0,0) is on the edge of the frame and inward is to
% the right.
path Gtemplate.itick, Gtemplate.otick, Gtemplate.grid;
Gtemplate.itick = origin--(7bp,0);
Gtemplate.otick = (-7bp,0)--origin;
Gtemplate.grid = origin--(1,0);

vardef itick@#(expr f,u) text w =  Gtlab_(@#,@,false,f,u,w);  enddef;

vardef otick@#(expr f,u) text w =  Gtlab_(@#,@,false,f,u,w);  enddef;

vardef grid@#(expr f,u) text w =  Gtlab_(@#,@,true,f,u,w);  enddef;


% Produce a tick or grid mark for label suffix $, Gtemplate suffix $$,
% coordinate value u, and with list w.  Boolean c tells whether Gtemplate$$
% needs scaling by X_.gdim or Y_.gdim, and f gives a format string or a label
% picture.
def Gtlab_(suffix $,$$)(expr c, f, u)(text w) =
  Glab_(Gtcvi_(Ggpos_($,u)),,draw Ggpic_$($$,c,f,u,w) shifted)
enddef;


% Generate label positioning arguments appropriate for label suffix $ and
% coordinate u.
def Ggpos_(suffix $)(expr u) =
  if xpart laboff.$=0: u,whatever else: whatever,u fi
enddef;


% Generate a picture of a grid line labeled with coordinate value u, picture
% or format string f, and with list w.  Suffix @# is bot, top, lft, or rt,
% suffix $ identifies entries in the Gtemplate table, and boolean c tells
% whether to scale Gtemplate$.
vardef Ggpic_@#(suffix $)(expr c, f, u)(text w) =
  if unknown u: Gerr_(u,"Label coordinate should be known"); nullpicture
  else:
    save p; path p;
    interim warningcheck:=0;
    Gneedgr_:=false;
    p = Gtemplate$ zscaled -laboff@#
        if c: Gxyscale fi
        shifted (((.5 + laboff@# dotprod (.5,.5)) * laboff@#) Gxyscale);
    image(draw p w;
        label@#(if string f: format(f,u) else: f fi, point 0 of p))
  fi
enddef;
def Gxyscale = xscaled X_.gdim yscaled Y_.gdim enddef;


% Draw the frame or the part corresponding to label suffix @# using with list w.
vardef frame@# text w =
  Gneedfr_:=false;
  picture p_;
  p_ = image(draw
    if str@#<>"":  subpath round(angle laboff@#*Gfra_+Gfrb_) of  fi
    unitsquare Gxyscale  w);
  Glab_((whatever,whatever),,draw p_ shifted);
enddef;
pair Gfra_; Gfra_=(1,1)/90;     % unitsquare subpath is linear in label angle
pair Gfrb_; Gfrb_=(.75,2.25);




%%%%%%%%%%%%%%%%%%%%%%%%%% Automatic grid selection %%%%%%%%%%%%%%%%%%%%%%%%%%

string Glmarks[];       % marking options per decade for logarithmic scales
string Gumarks;         % mark spacing options per decade for linear scales
string Gemarks;         % exponent spacing options for logarithmic scales
newinternal Gmarks, Gminlog;
Gmarks := 4;            % minimum number marks generated by auto.x or auto.y
Gminlog := 3.0;         % revert to uniform marks when largest/smallest < this

def Gfor(text t) = for i=t endfor enddef;  % to shorten the mark templates below
Glmarks[1]="1,2,5";
Glmarks[2]="1,1.5,2,3,4,5,7";
Glmarks[3]="1Gfor(6upto10:,i/5)Gfor(5upto10:,i/2)Gfor(6upto9:,i)";
Glmarks[4]="1Gfor(11upto20:,i/10)Gfor(11upto25:,i/5)Gfor(11upto19:,i/2)";
Glmarks[5]="1Gfor(21upto40:,i/20)Gfor(21upto50:,i/10)Gfor(26upto49:,i/5)";
Gumarks="10,5,2";       % start with 10 and go down; a final `,1' is appended
Gemarks="20,10,5,2,1";


% Determine the X_ or Y_ bounds on the range to be covered by automatic grid
% marks.  Suffix @# is X_ or Y_.  The result is log or linear to specify the
% type of grid spacing to use.  Bounds are returned in variables local to
% begingraph..endgraph: pairs Gmll_ and Gmhh_ are upper and lower bounds in
% `modified exponential form'.  In modified exponential form, (x,y) means
% (x/1000)*10^y, where 1000<=abs x<10000.
vardef Gpick_@# =
  interim warningcheck:=0;
  save l, h;
  Gsetp_;
  if @#ctyp>0: (l,h) else: -(h,l) fi = (@#low, @#high);
  if abs @#ctyp=log:
    Gmll_ := Meform(Mabs l)+Gbias_;
    Gmhh_ := Meform(Mabs h)+Gbias_;
    if h-l >=mlog Gminlog: log else: linear fi
  else:
    Gmll_ := Meform(@#sc + Mlog l)+Gbias_;
    Gmhh_ := Meform(@#sc + Mlog h)+Gbias_;
    linear
  fi
enddef;
pair Gbias_; Gbias_=(0,3);
pair Gmll_, Gmhh_;


% Scan Glmarks[k] and evaluate tokens t for each m where l<=m<=h.
def Gmsc_(expr k, l, h)(text t) =
  for m=scantokens Glmarks[k]:
    exitif m>h;
    if m>=l: t fi
  endfor
enddef;


% Scan Gmark[k] and evaluate tokens t for each m and e where m*10^e belongs
% between l and h (inclusive), where both l and h are in modified exponent form.
def Gmscan_(expr k, l, h)(text t) =
  for e=ypart l upto ypart h:
    Gmsc_(k, if e>ypart l: 1 else: xpart l/1000 fi,
        if e<ypart h: 10 else: xpart h/1000 fi,  t)
  endfor
enddef;


% Select a k for which Gmscan_(k,...) gives enough marks.
vardef Gkpick_ =
  save k;
  k = 0;
  forever:
    exitif unknown Glmarks[k+1];
    exitif 0 Gmscan_(incr k, Gmll_, Gmhh_, +1) >= Gmarks;
  endfor
  k
enddef;


% Try to select an exponent spacing from Gemarks.  If successful, set @# and
% return true
vardef Gempick_@# =
  numeric @#;
  for e=scantokens Gemarks:
    @# = e;
    exitif floor(ypart Gmhh_/e)-floor(Gey_(Gmll_)/e) >= Gmarks;
    numeric @#;
  endfor
  known @#
enddef;

vardef Gey_(expr p) = ypart p  if xpart p=1000: -1 fi  enddef;


% Compute the mark spacing d between xpart Gmll_ and xpart Gmhh_.
vardef Gipick_ =
  interim warningcheck:=0;
  save m, n, d;
  m = Gmarks;
  n = 1 for i=1 upto mlog(xpart Gmhh_-xpart Gmll_)/Mten - mlog m/(Mten-epsilon):
        *10 endfor;
  if n<=1000:
    for x=scantokens Gumarks:
      d = n*x;
      exitif 0 Gigen_(d,+1)>=m;
      numeric d;
    endfor
  fi
  if known d: d else: n fi
enddef;


def Gigen_(expr d)(text t) =
  for m = d*ceiling(xpart Gmll_/d) step d until xpart Gmhh_:
    t
  endfor
enddef;


% Evaluate tokens t for exponents e in multiples of d in the range determined
% by Gmll_ and Gmhh_.
def Gemgen_(expr d)(text t) =
  for e = d*floor(Gey_(Gmll_)/d+1)
      step d until d*floor(ypart Gmhh_/d):  t
  endfor
enddef;


% Adjust Gmll_ and Gmhh_ so their exponent parts match and they are in true
% exponent form ((x,y) means x*10^y).  Return the new exponent.
vardef Gesame_ =
  interim warningcheck := 0;
  save e;
  e+3 = if Gmll_=Gbias_: ypart Gmhh_
        elseif Gmhh_=Gbias_: ypart Gmll_
        else: max(ypart Gmll_, ypart Gmhh_) fi;
  forsuffixes $=Gmll_, Gmhh_:
    $ := (xpart $ for i=ypart $ upto e+2: /(10) endfor, e);
  endfor
  e
enddef;


% Assume e is an integer and either m=0 or 1<=abs(m)<10000.  Find m*(10^e)
% and represent the result as a string if its absolute value would be at least
% 4096 or less than .1.  It is OK to return 0 as a string or a numeric.
vardef Gpack_(expr m, e) =
  if (e>3)or(e<-4):
    decimal m & "e" & decimal e
  elseif e>=0:
    if abs m<infinity/Ten_to[e]:
          m*Ten_to[e]
    else: decimal m & "e" & decimal e
    fi
  else:
    save x; x=m/Ten_to[-e];
    if abs x>=.1: x else: decimal m & "e" & decimal e fi
  fi
enddef;


def auto suffix $ =
  hide(def Gcma_= hide(def Gcma_=,enddef) enddef)
  if Gpick_.Gsuf_($)=log:
    if Gempick_.Gme_:  Gemgen_(Gme_, Gcma_ Gpack_(1,e))
    else: 
      Gmscan_(Gkpick_, Gmll_, Gmhh_, Gcma_ Gpack_(m,e))
    fi
  else:
    hide(Gme_:=Gesame_)
    Gigen_(Gipick_, Gcma_ Gpack_(m,Gme_))
  fi
enddef;


string Autoform; Autoform = "%g";

vardef autogrid(suffix tx, ty) text w =
  Gneedgr_:=false;
  if str tx<>"": for x=auto.x: tx(Autoform,x) w; endfor fi
  if str ty<>"": for y=auto.y: ty(Autoform,y) w; endfor fi
enddef;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% endgraph %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

def endgraph =
  if Gneedgr_: autogrid(otick.bot, otick.lft); fi
  if Gneedfr_: frame; fi
  setcoords(linear,linear);
  interim truecorners:=1;
  for b=bbox Gfin_:
    setbounds Gfin_ to b;
    for i=0 step .5 until 3.5:
      if known Ggl_[i]: addto Gfin_ also Ggl_[i] shifted point i of b; fi
    endfor
  endfor
  Gfin_
  endgroup
enddef;
