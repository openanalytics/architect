# iftex

## TeX Engine Detection

This iftex package provides a suite of commands for detecting
different TeX variants.

For each supported engine, tests are provided of the form

 \ifpdftex which is true if PDFTeX is in use and \RequirePDFTeX
 which stops the run with an error message if PDFTeX is not being used.

The package (which works with plain TeX as well as LaTeX) has tests
for:

eTeX, PDFTeX, XeTeX, LuaTeX, LuaHBTeX, pTeX, upTeX, pTeX-ng, VTeX, Aleph.


In addition, an \iftutex test is true for XeTeX and LuaTeX, and
an \ifpdf test is provided to test the PDF or DVI output mode.

## Compatibility Packages

In addition to the main iftex.sty package, small wrapper packages are
provided

ifetex.sty  ifluatex.sty  ifvtex.sty  ifxetex.sty ifpdf.sty

These include iftex and in some cases emulate some additional
commands to allow these packages to replace the original packages in TeX
distributions. It is recommended that new documents do not use these
packages, but instead load iftex.sty directly.

This package may be used on any format (it may be loaded into initex)
it does not assume LaTeX.


----

This is a merger and simplification of several packages
Based on a suggestion of Norbert Preining

https://github.com/bidi-tex/iftex/issues/1


 * ifetex: Martin Scharrer
 * ifxetex: Will Robertson
 * iftex:  Persian TeX Group / Vafa Khalighi
 * ifluatex, ifvtex: Heiko Oberdiek
 * ifptex: Takayuki Yato
 * ifpdf: Heiko Oberdiek and LaTeX3 Project


The existing  if(u)ptex packages do far more extensive testing to
distinguish different variants which are not copied here.

A document specifically for Japanese texts may need the finer grained
tests of the ifptex package which has tests for particular versions
of the pTeX (Japanese TeX) variant in use, and for the mode that is
active.

This generic package only has coarser tests for the tex variant in
use, so is sufficient for example to distinguish upTeX from pTeX, and
to distinguish both of those from LuaTeX.

