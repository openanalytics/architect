% $Id: sarith.mp,v 1.2 2004/09/19 21:47:11 karl Exp $
% Public domain.

% Macros for arithmetic on strings that represent big numbers
% All the macros below except ordinary numeric values as well

% Scvnum <number>        % convert to an ordinary numeric
% Sabs <number>          % absolute value
% <number> Sadd <number> % add
% <number> Ssub <number> % subtract
% <number> Smul <number> % multiply
% <number> Sdiv <number> % divide
% <number> Sleq <number> % compare <=
% <number> Sneq <number> % numeric compare <>

% All other externally visible names start with `S' and end with `_'


if unknown Mzero:
  begingroup interim	% marith.mp starts with `warningcheck:=0'
  input marith
  endgroup;             % restore warningcheck; we zero it when necessary
fi


vardef Sunop_(expr x)(text o) =
  interim warningcheck:=0;
  o  if numeric x: decimal fi  x
enddef;


vardef Sbinop_@#(expr a, b)(text o) =
  interim warningcheck:=0;
  @# (Mlog_Str a  o  Mlog_Str b)
enddef;


def Ssbinop_ = Sbinop_.Mexp_str enddef;


vardef Sabs primary x = Sunop_(x, Mexp_str Mabs Mlog_str) enddef;
vardef Scvnum primary x = Sunop_(x, Mexp Mlog_str) enddef;
% The inverse of Scvnum is the `decimal' primitive.

primarydef a Smul b = Ssbinop_(a,b,Mmul) enddef;
primarydef a Sdiv b = Ssbinop_(a,b,Mdiv) enddef;
secondarydef a Sadd b = Ssbinop_(a,b,Madd) enddef;
secondarydef a Ssub b = Ssbinop_(a,b,Msub) enddef;
tertiarydef a Sleq b = Sbinop_(a,b,Mleq) enddef;
tertiarydef a Sneq b = Sbinop_(a,b,<>) enddef;
