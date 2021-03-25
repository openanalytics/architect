The Unicode Consortium provide a range of data files detailing
the nature of code points in Unicode. These data files are
machine-readable but large. Here, a set of loaders are provided
to parse these files during a TeX run and set appropriate
parameters in an automated fashion.

File: `load-unicode-data.tex`
=============================

The loader parses a number of data files provided by the Unicode
Consortium and when used with used Unicode-capable engine sets
up a range of TeX-related parameters based on the extracted
information.

From the file `UnicodeData.txt` the following properties are set:
- `\catcode` 11 for all letters (Unicode class "L")
- `\catcode` 11 for all combining marks (Unicode class "M")
- `\sfcode` 999 for all code points of class "Lu" (upper case
  letters)
- `\lccode` for all of class "Ll" (lower case letters) to the code
  point itself, and `\uccode` to the upper case mapping (or if
  not given to the code point itself)
- `\uccode` for all of class "Lu" (upper case letters) to the code
  point itself, and `\lccode` to the lower case mapping (or if
  not given to the code point itself)
- `\lccode` and `\uccode` for all of class "Lt" (title case
  letters) to the lower and upper case mappings (or if not given
  to the code point itself)
- `\lccode` and `\uccode` for all other letter code points are
  set to the code point itself
- `\lccode` and/or `\uccode` for non-letter code points for
  which an upper or lower case mapping is given
- `\sfcode` 0 (ignored) for code points of Unicode classes "Pe"
  (closing punctuation marks) and "Pf" (final quotation marks)
- `\Umathcode` for all letters (Unicode class "L") and combining
  marks (Unicode class "M") as TeX class 7 (var)

In the above, 'letters' refers to code points with Unicode class
"L", irrespective of their TeX category code.

File: `load-unicode-math-classes.tex`
======================================

From the file `MathClass-15.txt` the following mapping between
Unicode math classes and TeX math types are set up
- "L" (large)       `\mathop`
- "B" (binary)      `\mathbin`
- "V" (vary)        `\mathbin`
- "R" (relation)    `\mathrel`
- "O" (opening)     `\mathopen`
- "C" (closing)     `\mathclose`
- "P" (punctuation) `\mathpunct`
- "A" (alphabetic)  `\mathalpha`

For each code point processed, the result is of the form

    \Umathcode <codepoint> = <type> 1 <codepoint>

File: `load-unicode-xetex-classes.tex`
======================================

From the files `EastAsianWidth.txt` and `LineBreak.txt` inter
character classes for XeTeX (`\XeTeXcharclass`) are set for the
following classes
- "ID" (ideographic)
- "CJ" (conditional Japanese starter)
- "OP" (opener)
- "CL" (closer)
- "NS" (non-starter)
- "EX" (exclamation)
- "IS" (infix separator)
- "CM" (combining marks)

All code points of classes "ID" and "CJ" are assigned to a
`\XeTeXcharclass`, but for other classes this only occurs when
they fall into east Asian width type "F", "H" or "W" (full-,
half- and wide-width).

The following mappings between Unicode and XeTeX classes occur
- "ID" and "CJ" are class 1
- "OP" is class 2
- "CL", "NS", "EX", "IS" are class 3
- "CM" is class 256 (ignored)

as standard: these may be over-ridden by defining
`\XeTeXcharclass<class>` as required. (If classes "ID" or "CL"
are explicitly set, the other members of the same groups above
will inherit these values.)

This file does _not_ activate XeTeX's inter-character token
mechanism (`\XeTeXinterchartokenstate` is not set) nor does it
install any material in the inter-character token registers.

Note that this file is separate from the main loader as the data
structure here may need more refinement at the macro level.

Data files
==========

The following data files are included here with permission of the
Unicode Consortium (see below):
- `UnicodeData.txt`
- `BidiBrackets.txt`
- `BidiMirroring.txt`
- `BidiMirroring-5-1-0.txt`
- `CaseFolding.txt`
- `EastAsianWidth.txt`
- `emoji-data.txt`
- `GraphemeBreakProperty.txt`
- `LineBreak.txt`
- `MathClass.txt`
- `PropList.txt`
- `SpecialCasing.txt`
- `Scripts.txt`
- `ScriptExtension.txt`
- `WordBreakProperty.txt`

With the exception of `MathClass.txt`, which is currently not
formally part of the Unicode Character Database, and
`BidiMirroring-5-1-0.txt`, which is a data file for Unicode 5.1.0,
all of the data files here are for Unicode 13.0.0.

`BidiMirroring-5-1-0.txt` will never be updated and is included for
OpenType font support: While `BidiMirroring.txt` lists all mirror
pairs in the current Unicode version, only the pairs from Unicode 5.1.0
are handled directly by the OpenType rendering system. All newer pairs
have to be handled through font features.

Requests to include additional Unicode data files in this bundle are
welcome. Ideally this bundle will act as a single location for all
Unicode data for use by TeX systems.

Issues and improvements
=======================

The home page for this bundle is
https://github.com/latex3/unicode-data, and issues may be
reported there.

Changes
=======

- v1.0  (2015-12-01)
  - First public release
- v1.1  (2016-01-04)
  - Allow setting of XeTeX character class slot numbers
- v1.1a (2016-01-06)
  - Correctly assign XeTeX character class for code points in
    ranges
  - Fix issue which meant `EastAsianWidth.txt` was not read
- v1.1b (2016-01-08)
  - Avoid save stack issue when loading `EastAsianWidth.txt`
  - Fix application of settings to ranges of Unicode characters
  - Correct setting of space factor for ending punctuation
- v1.2 (2016-02-02)
  - Drop use of Unicode math data at present: undesired effect on
    output if Unicode fonts are not loaded (classical OT1
    situation)
- v1.2a (2016-02-05)
  - Correct split between base and supplementary plane when
    setting math codes
- v1.3 (2016-02-06)
  - New `load-unicode-math-classes.tex` loader
  - Set all letters as math type 7 (var) in
    `load-unicode-data.tex`
- v1.3a (2016-02-06)
  - Add definition of `\loop` to `load-unicode-math-classes.tex`
- v1.4 (2016-02-16)
  - Treat "CJ" chars like "ID" chars for setting XeTeX character
    class
- v1.4a (2016-02-21)
  - Inherit XeTeX classes for "CJ" from "ID" and for  "NS", "EX"
    and "IS" from "CL" if appropriate
- v1.5 (2016-06-22)
  - Update data files to Unicode release 9.0.0
- v1.6 (2017-06-27)
  - Update data files to Unicode release 10.0.0
- v1.7 (2018-08-09)
  - Update data files to Unicode release 11.0.0
- v1.8 (2019-03-09)
  - Update data files to Unicode release 12.0.0
- v1.9 (2019-08-13)
  - Update data files to Unicode release 12.1.0
  - Add  `BidiBrackets.txt`, `Scripts.txt` and `ScriptExtension.txt`
- v1.10 (2019-08-21)
  - Add `PropList.txt`
- v1.11 (2019-11-28)
  - Add `BidiMirroring.txt` and `BidiMirroring-5-1-0.txt`
- v1.12 (2020-03-11)
  - Update data files to Unicode release 13.0.0
- v1.13 (2020-04-15)
  - Add `emoji-data.txt` and `GraphemeBreakProperty.txt`
- v1.14 (2020-10-24)
  - Add `WordBreakProperty.txt`

License and permission
======================

This bundle is copyright (C) 2015-2020 The LaTeX3 Project

It may be distributed and/or modified under the conditions of
the LaTeX Project Public License (LPPL), either version 1.3c of
this license or (at your option) any later version. The latest
version of this license is in the file
http://www.latex-project.org/lppl.txt.

The source data (`.txt` files) are supplied by the Unicode
Consortium and the following notice applies.

COPYRIGHT AND PERMISSION NOTICE


Copyright © 1991-2020 Unicode, Inc. All rights reserved.
Distributed under the Terms of Use in http://www.unicode.org/copyright.html.

Permission is hereby granted, free of charge, to any person obtaining
a copy of the Unicode data files and any associated documentation
(the "Data Files") or Unicode software and any associated documentation
(the "Software") to deal in the Data Files or Software
without restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, and/or sell copies of
the Data Files or Software, and to permit persons to whom the Data Files
or Software are furnished to do so, provided that either
(a) this copyright and permission notice appear with all copies
of the Data Files or Software, or
(b) this copyright and permission notice appear in associated
Documentation.

THE DATA FILES AND SOFTWARE ARE PROVIDED "AS IS", WITHOUT WARRANTY OF
ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT OF THIRD PARTY RIGHTS.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR HOLDERS INCLUDED IN THIS
NOTICE BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL
DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THE DATA FILES OR SOFTWARE.

Except as contained in this notice, the name of a copyright holder
shall not be used in advertising or otherwise to promote the sale,
use or other dealings in these Data Files or Software without prior
written authorization of the copyright holder.
