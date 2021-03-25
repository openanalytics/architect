:# Written in 2018 by Christian Schenk
:# 
:# To the extent possible under law, the author(s) have dedicated all
:# copyright and related and neighboring rights to this file to the
:# public domain worldwide.  This file is distributed without any
:# warranty.  You should have received a copy of the CC0 Public
:# Domain Dedication along with this file.  If not, see
:# http://creativecommons.org/publicdomain/zero/1.0/.

:# This script downloads/builds Ghostscript for inclusion in the
:# MiKTeX distribution (Windows).
:# Usage:
:#    compile_for_miktex.cmd [x64]

setlocal

set ghostpdl_url=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs925/ghostpdl-9.25.tar.gz

if not exist ghostpdl-9.25 (
  if not exist ghostpdl-9.25.tar.gz (
    wget %ghostpdl_url%
  )
  echo|set /P="784531e81f144c0f703a0f079e6fd1522eabb97b3a0670a92bdd1f39bf201d99 *ghostpdl-9.25.tar.gz"> sha256sum.txt
  sha256sum --check sha256sum.txt
  if ERRORLEVEL 1 (
    echo bad download: checksum does not match
    exit /B 1
  )
  tar -xvzf ghostpdl-9.25.tar.gz
)

pushd ghostpdl-9.25

if "%1" == "x64" (
  shift
  set bitness=64
  set defines=WIN64=
) else (
  set bitness=32
)

copy psi\gsdll%bitness%.def psi\mgsdll%bitness%.def
sed -i s/GSDLL%bitness%/MGSDLL%bitness%/g psi/mgsdll%bitness%.def

sed -i s/\^<gsdll%bitness%/mgsdll%bitness%/ psi/dwdll.c
sed -i s/BUILD_SYSTEM=32/BUILD_SYSTEM=64/ psi/msvc.mak

set PLATFORM=

set MSSDK=C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0a

nmake -f psi\msvc%bitness%.mak ^
  %defines% ^
  "MSSDK=%MSSDK%" ^
  GSCONSOLE=mgs%bitness% ^
  GSDLL=mgsdll%bitness% ^
  XCFLAGS="-DMIKTEX_GS -DGS_LIB_DEFAULT=\\\"C:/MiKTeX/Installation/ghostscript/base;C:/MiKTeX/Installation/fonts\\\"  -DGS_LIB=\\\"MIKTEX_GS_LIB\\\" -DGS_OPTIONS=\\\"MIKTEX_GS_OPTIONS\\\" -DGS_PRODUCTFAMILY=\"\\\"MiKTeX GPL Ghostscript\\\"\"" MAKEDLL=1 MSVC_VERSION=15 %1 %2 %3 %4 %5 %6 %7 %8 %9

popd

:end

endlocal
