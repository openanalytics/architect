@echo off
Rem  htxelatex.bat (2020-10-25-17:53), generated from tex4ht-mkht.tex
Rem  Copyright 2009-2020 TeX Users Group
Rem  Copyright 2003-2009 Eitan M. Gurari
Rem 
Rem  This work may be distributed and/or modified under the
Rem  conditions of the LaTeX Project Public License, either
Rem  version 1.3 of this license or (at your option) any
Rem  later version. The latest version of this license is in
Rem    http://www.latex-project.org/lppl.txt
Rem  and version 1.3 or later is part of all distributions
Rem  of LaTeX version 2003/12/01 or later.
Rem 
Rem  This work has the LPPL maintenance status "maintained".
Rem 
Rem  The Current Maintainer of this work
Rem  is the TeX4ht Project <https://tug.org/tex4ht>.
Rem 
Rem  If you modify this file, changing the
Rem  version identification be appreciated.

xelatex -no-pdf %5 \makeatletter\def\HCode{\futurelet\HCode\HChar}\def\HChar{\ifx"\HCode\def\HCode"##1"{\Link##1}\expandafter\HCode\else\expandafter\Link\fi}\def\Link#1.a.b.c.{\g@addto@macro\@documentclasshook{\RequirePackage[#1,html]{tex4ht}}\let\HCode\documentstyle\def\documentstyle{\let\documentstyle\HCode\expandafter\def\csname tex4ht\endcsname{#1,html}\def\HCode####1{\documentstyle[tex4ht,}\@ifnextchar[{\HCode}{\documentstyle[tex4ht]}}}\makeatother\HCode %2.a.b.c.\input  %1
        xelatex -no-pdf %5 \makeatletter\def\HCode{\futurelet\HCode\HChar}\def\HChar{\ifx"\HCode\def\HCode"##1"{\Link##1}\expandafter\HCode\else\expandafter\Link\fi}\def\Link#1.a.b.c.{\g@addto@macro\@documentclasshook{\RequirePackage[#1,html]{tex4ht}}\let\HCode\documentstyle\def\documentstyle{\let\documentstyle\HCode\expandafter\def\csname tex4ht\endcsname{#1,html}\def\HCode####1{\documentstyle[tex4ht,}\@ifnextchar[{\HCode}{\documentstyle[tex4ht]}}}\makeatother\HCode %2.a.b.c.\input  %1
        xelatex -no-pdf %5 \makeatletter\def\HCode{\futurelet\HCode\HChar}\def\HChar{\ifx"\HCode\def\HCode"##1"{\Link##1}\expandafter\HCode\else\expandafter\Link\fi}\def\Link#1.a.b.c.{\g@addto@macro\@documentclasshook{\RequirePackage[#1,html]{tex4ht}}\let\HCode\documentstyle\def\documentstyle{\let\documentstyle\HCode\expandafter\def\csname tex4ht\endcsname{#1,html}\def\HCode####1{\documentstyle[tex4ht,}\@ifnextchar[{\HCode}{\documentstyle[tex4ht]}}}\makeatother\HCode %2.a.b.c.\input  %1
        tex4ht -.xdv %1  -i/tex4ht/ht-fonts/%3 -ewin32/tex4ht.env
        t4ht -.xdv %1 %4 -ewin32/tex4ht.env 



