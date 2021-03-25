# epstopdf
epstopdf (and epstopdf-base) package for including EPS in pdftex and luatex


## Note

`epstopdf-base.sty` is included by the pdftex and luatex options for
the core graphics package

The full package has a dependency on the following packages


    \RequirePackage{infwarerr}[2007/09/09]
    \RequirePackage{grfext}\relax
    \RequirePackage{kvoptions}[2007/10/02]
    \RequirePackage{pdftexcmds}[2007/11/11]

The epstopdf-base package, if used with no arguments, (as used by the graphics package)
does not include these packages, but does use the Lua module from pdftexcmds.

