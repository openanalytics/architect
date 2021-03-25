#!/bin/sh
# Minimal example of building R for Windows.
# You must run this script inside the rtools40 shell.
# This builds and checks a single architecture (no manuals or installer)
# Used below: set this to 32 or 64 
WIN=64

# Run script safely and emit some verbose output
set -e
set -x

# Put pdflatex on the path (needed only for CMD check)
export PATH="$PATH:/c/progra~1/MiKTeX/miktex/bin/x64:/c/progra~1/MiKTeX 2.9/miktex/bin/x64"
pdflatex --version
texindex --version
make --version

pwd
sleep 10s

# get absolute paths
srcdir=$(dirname $(realpath $0))

echo $srcdir
pwd
sleep 10s

# Install system libs
pacman -Syu --noconfirm
pacman -S --needed --noconfirm mingw-w64-{i686,x86_64}-{gcc,gcc-fortran}
pacman -S --needed --noconfirm mingw-w64-{i686,x86_64}-{icu,libtiff,libjpeg,libpng,pcre2,xz,bzip2,zlib}
pacman -S --needed --noconfirm mingw-w64-{i686,x86_64}-{cairo,tk,curl}

pwd
sleep 10s

# Download R-devel and extract (tarball contains recursive symlinks)
rm -Rf R-devel
curl -OL https://cran.r-project.org/src/base-prerelease/R-devel.tar.gz
MSYS="winsymlinks:lnk" tar -xf R-devel.tar.gz
cd R-devel

# Download a certificate bunle
curl https://curl.se/ca/cacert.pem > etc/curl-ca-bundle.crt

# Create the TCL bundle required by tcltk package
mkdir -p Tcl/{bin,bin64,lib,lib64}
${srcdir}/create-tcltk-bundle.sh

# Add custom patches here:
# patch -Np1 -i "${srcdir}/myfix.patch" 

# Build just the core pieces (no manuals or installer)
cd "src/gnuwin32"
sed -e "s|@win@|${WIN}|" -e "s|@texindex@||" -e "s|@home32@||" "${srcdir}/MkRules.local.in" > MkRules.local
make all cairodevices recommended

# Optional: run checks
# make check-all

# Start RGUI to test
../../bin/x64/Rgui.exe &
