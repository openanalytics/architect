%%
%% This is file `xkveca.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% xkeyval.dtx  (with options: `xkveca')
%% 
%% ---------------------------------------
%% Copyright (C) 2004-2020 Hendri Adriaens
%% ---------------------------------------
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.
%%
%% This work has the LPPL maintenance status "maintained".
%%
%% This Current Maintainer of this work is Hendri Adriaens.
%%
%% This work consists of the file xkeyval.dtx and derived files
%% keyval.tex, xkvtxhdr.tex, xkeyval.sty, xkeyval.tex, xkvview.sty,
%% xkvltxp.sty, xkvutils.tex, pst-xkey.tex, pst-xkey.sty, xkveca.cls,
%% xkvecb.cls, xkvesa.sty, xkvesb.sty, xkvesc.sty, xkvex1.tex,
%% xkvex2.tex, xkvex3.tex and xkvex4.tex.
%%
%% The following files constitute the xkeyval bundle and must be
%% distributed as a whole: readme, xkeyval.pdf, keyval.tex,
%% pst-xkey.sty, pst-xkey.tex, xkeyval.sty, xkeyval.tex, xkvview.sty,
%% xkvltxp.sty, xkvtxhdr.tex, xkvutils.tex, pst-xkey.dtx and xkeyval.dtx.
%%
\ProvidesClass{xkveca}
\usepackage{xkeyval}
\let\keyi\@empty
\let\keyvi\@empty
\DeclareOptionX{keyi}{\def\keyi{#1}}
%% this key has a default value
\DeclareOptionX{keyvi}[{test 6}]{\def\keyvi{#1}}
%% pass option to class xkvesb.cls
\PassOptionsToClass{notitlepage}{xkvecb}
\PassOptionsToClass{keyviii={test 8}}{xkvecb}
%% pass unknown options to article
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{article}}
%% process options
\ProcessOptionsX
%% load another class
\LoadClass{xkvecb}
\endinput
%%
%% End of file `xkveca.cls'.
