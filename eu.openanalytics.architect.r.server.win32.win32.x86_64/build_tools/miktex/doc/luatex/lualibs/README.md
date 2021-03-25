# The Lualibs Package

VERSION: 2.73

DATE: 2020-12-30

FONTLOADERDATE: 2020-12-30

Lualibs is a collection of Lua modules useful for general programming.

This work is based on Lua modules shipped with ConTeXt, to make them available
for use independent of ConTeXt.

This package has been developed by the LuaLaTeX development team on
<https://github.com/lualatex/lualibs>. 

The current version has been build by the LaTeX3 Project Team on
<https://github.com/latex3/lualibs/>. The fontloader date equals the date of the context files. 

See the 'NEWS' file for version history.



## Installation


1. If you are using TeX Live 2010 or later use 'tlmgr install lualibs'. 
   With miktex, use the miktex console. 
   Alternatively, use your (TeX or Linux) distribution's package management
   system.

2. 
    1. Grab lualibs.tds.zip on CTAN.
    2. Unzip it at the root of one or your TDS trees.
    3. You may need to update some filename database after this, see your TeX
      distribution's manual for details.


## Manifest

### Source files:

|            file                    |           TDS location
|------------------------------------|-----------------------------------
|    lualibs.dtx                     |source/luatex/lualibs/lualibs.dtx
|    lualibs-boolean.lua             |tex/luatex/lualibs/lualibs-boolean.lua
|    lualibs-compat.lua              |tex/luatex/lualibs/lualibs-compat.lua
|    lualibs-dir.lua                 |tex/luatex/lualibs/lualibs-dir.lua
|    lualibs-file.lua                | tex/luatex/lualibs/lualibs-file.lua
|    lualibs-gzip.lua                | tex/luatex/lualibs/lualibs-gzip.lua
|    lualibs-function.lua            | tex/luatex/lualibs/lualibs-function.lua
|    lualibs-io.lua                  | tex/luatex/lualibs/lualibs-io.lua
|    lualibs-lpeg.lua                | tex/luatex/lualibs/lualibs-lpeg.lua
|    lualibs-lua.lua                 | tex/luatex/lualibs/lualibs-lua.lua
|    lualibs-math.lua                | tex/luatex/lualibs/lualibs-math.lua
|    lualibs-md5.lua                 | tex/luatex/lualibs/lualibs-md5.lua
|    lualibs-number.lua              | tex/luatex/lualibs/lualibs-number.lua
|    lualibs-os.lua                  | tex/luatex/lualibs/lualibs-os.lua
|    lualibs-package.lua             | tex/luatex/lualibs/lualibs-package.lua
|    lualibs-set.lua                 | tex/luatex/lualibs/lualibs-set.lua
|    lualibs-string.lua              | tex/luatex/lualibs/lualibs-string.lua
|    lualibs-table.lua               | tex/luatex/lualibs/lualibs-table.lua
|    lualibs-trac-inf.lua            | tex/luatex/lualibs/lualibs-trac-inf.lua
|    lualibs-unicode.lua\*           | tex/luatex/lualibs/lualibs-unicode.lua
|    lualibs-url.lua                 | tex/luatex/lualibs/lualibs-url.lua
|    lualibs-util-deb.lua            | tex/luatex/lualibs/lualibs-util-deb.lua
|    lualibs-util-dim.lua            | tex/luatex/lualibs/lualibs-util-dim.lua
|    lualibs-util-jsn.lua            | tex/luatex/lualibs/lualibs-util-jsn.lua
|    lualibs-util-lua.lua            | tex/luatex/lualibs/lualibs-util-lua.lua
|    lualibs-util-prs.lua            | tex/luatex/lualibs/lualibs-util-prs.lua
|    lualibs-util-sta.lua            | tex/luatex/lualibs/lualibs-util-sta.lua
|    lualibs-util-sto.lua            | tex/luatex/lualibs/lualibs-util-sto.lua
|    lualibs-util-str.lua            | tex/luatex/lualibs/lualibs-util-str.lua
|    lualibs-util-tab.lua            | tex/luatex/lualibs/lualibs-util-tab.lua
|    lualibs-util-tpl.lua            | tex/luatex/lualibs/lualibs-util-tpl.lua
|    LICENSE                         | doc/luatex/lualibs/LICENSE
|    NEWS                            | doc/luatex/lualibs/NEWS
|    README                          | doc/luatex/lualibs/README
    
\* the file has been modified to enable the unicode library again    

### Derived files:

|            file                    |           TDS location
|------------------------------------|-----------------------------------
|    lualibs.lua                     | tex/luatex/lualibs/lualibs.lua
|    lualibs-basic.lua               | tex/luatex/lualibs/lualibs-basic.lua
|    lualibs-basic-merged.lua        | tex/luatex/lualibs/lualibs-basic-merged.lua
|    lualibs-extended.lua            | tex/luatex/lualibs/lualibs-extended.lua
|    lualibs-extended-merged.lua     | tex/luatex/lualibs/lualibs-extended-merged.lua
|    lualibs.pdf                     | doc/luatex/lualibs/lualibs.pdf

## License and Copyright

As a derived work of Context, this work and the derived files are under the
GNU GPL v.2.0 license.
The full text of the license is included in the file LICENSE.

The files taken from Context (lualibs-*.lua) are copyright PRAGMA ADE / ConTeXt
Development Team.

