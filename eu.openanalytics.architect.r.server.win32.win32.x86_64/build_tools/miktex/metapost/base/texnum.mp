% $Id: texnum.mp,v 1.2 2004/09/19 21:47:11 karl Exp $
% Public domain.

% Default init_numbers for use with TeX
% Don't input this directly--format.mp uses this file

verbatimtex
  \ifx\documentstyle\undefined \else
    \ifx\blackandwhite\undefined
      \documentstyle{article}
    \else \documentstyle{slides}
    \fi
    \begin{document}
  \fi
etex

init_numbers(btex$-$etex, btex$1$etex, btex${\times}10$etex,
    btex${}^-$etex, btex${}^2$etex);

Fe_base := btex $10$ etex;
