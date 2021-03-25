% $Id: rboxes.mp,v 1.2 2004/09/19 21:47:11 karl Exp $
% Public domain.

% This macro package is exactly like boxes.mp except that it defines
% an additional macro rboxit<box name>(<string or picture>) that produces
% rectangular boxes with rounded corners.

\input boxes




% Rectangular boxes with rounded corners

newinternal rbox_radius;
rbox_radius := 8bp;

vardef rboxit@#(text tt) =
  beginbox_("rboxpath_","sizebox_",@#,tt);
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

def rboxpath_(suffix $) =
  save _r;
  _r = min(rbox_radius, .5*ypart($.n-$.s), .5*xpart($.e-$.w));
  $.sw+(_r,0) {right}..{right} $.se-(_r,0)
  ..$.se+(0,_r) {up}..{up} $.ne-(0,_r)
  ..$.ne-(_r,0) {left}..{left} $.nw+(_r,0)
  ..$.nw-(0,_r) {down}..{down} $.sw+(0,_r) .. cycle
enddef;


% sizebox_ and clearb_ are defined in boxes.mp
