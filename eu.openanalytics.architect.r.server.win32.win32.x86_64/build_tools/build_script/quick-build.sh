#!/bin/bash
# Minimal example of building R for Windows.
# You must run this script inside the rtools40 shell.
# This builds and checks a single architecture (no manuals or installer)
# Used below: set this to 32 or 64 
WIN=64
R_VERSION=R-4.0.4

# Run script safely and emit some verbose output
set -e
set -x

# Get project base path
projectBaseDir=$(realpath .)

# Set Base Tool Dir
baseToolDir=$projectBaseDir/build_tools

# Set build path
buildDir=$projectBaseDir/target/build

# Put pdflatex on the path (needed only for CMD check)
export PATH="$PATH:$baseToolDir/miktex/bin/x64"
#pdflatex --version
texindex --version
make --version

# 'Install system libs'
pacman -Syu --noconfirm
pacman -S --needed --noconfirm mingw-w64-{i686,x86_64}-{gcc,gcc-fortran}
pacman -S --needed --noconfirm mingw-w64-{i686,x86_64}-{icu,libtiff,libjpeg,libpng,pcre2,xz,bzip2,zlib}
pacman -S --needed --noconfirm mingw-w64-{i686,x86_64}-{cairo,tk,curl}

# 'Copy R-version and extract (tarball contains recursive symlinks)'
rm -r --force target/build
mkdir target/build
cp $baseToolDir/R/$R_VERSION.tar.gz $buildDir/$R_VERSION.tar.gz
cd $buildDir
MSYS="winsymlinks:lnk" tar -xf $R_VERSION.tar.gz
cd $buildDir/$R_VERSION

# 'Download a certificate bunle'
curl https://curl.se/ca/cacert.pem > etc/curl-ca-bundle.crt

# 'Create the TCL bundle required by tcltk package'
mkdir -p Tcl/{bin,bin64,lib,lib64}
$baseToolDir/build_script/create-tcltk-bundle.sh

# 'Build just the core pieces (no manuals or installer)'
cd $buildDir/$R_VERSION/src/gnuwin32
sed -e "s|@win@|${WIN}|" -e "s|@texindex@||" -e "s|@home32@||" "$baseToolDir/build_script/MkRules.local.in" > MkRules.local
make all cairodevices recommended

# Start RGUI to test
# ../../bin/x64/Rgui.exe &
rm -r --force $projectBaseDir/R/*
cp -RL $buildDir/$R_VERSION/. $projectBaseDir/R