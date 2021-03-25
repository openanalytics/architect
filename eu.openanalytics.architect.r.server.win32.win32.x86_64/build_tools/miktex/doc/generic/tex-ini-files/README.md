# Model TeX format creation files

This bundle provides a collection of model `.ini` files for
creating TeX formats. These files are commonly used to introduced
distribution-dependent variations in formats. They are also used
to allow existing format source files to be used with newer
engines, for example to adapt the plain e-TeX source file to
work with XeTeX and LuaTeX.

## Shared configuration

The file `pdftexconfig.tex` contains common settings for pdfTeX
and LuaTeX, most of which are concerned with direct PDF output.
This file is designed to be loaded directly by pdfTeX and can
be parsed by the `luatexconfig.tex` to allow the same settings
to be used by LuaTeX directly. The format of the file
`pdftexconfig.tex` is strictly

    <pdfTeX primitive> = <value>

for all non-comment non-blank lines. 

The LuaTeX loader recognise the marker control sequence `\dvimode`.
If this is defined, the loaders will set the format to produce
DVI file, and otherwise will select direct PDF output. The loader
will then undefine `\dvimode`.

## History

The use of `.ini` files for building formats has developed over
some time. The initial versions of the files collected here were
taken from TeX Live 2015, and thus carry forward long-standing
behaviours from this system. Initial modifications were made
to allow for significant changes in LuaTeX primitive support
between TeX Live 2015 and TeX Live 2016.

The files provided here are designed to work with other support
files and engines available from late 2015 onward, in particular:
- pdfTeX v1.40+
- LuaTeX v0.80+
- XeTeX  v0.99992+
- LaTeX2e 2015-01-01 onward
- unicode-data v1.0+

Major changes:
- 2016-02-27 First version of bundle
- 2016-04-14 Do not assume e-TeX availability in `pdftexconfig.tex`
- 2016-04-15 New approach to loading shared pdfTeX/LuaTeX data

A full history of this bundle is available from
https://github.com/josephwright/tex-ini-files

## Legal

The files provided here were originally written by various
authors and are all marked as public domain.
