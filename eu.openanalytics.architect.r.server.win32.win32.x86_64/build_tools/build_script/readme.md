# Base R Installer [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/r-windows/r-base?branch=master)](https://ci.appveyor.com/project/jeroen/r-base)

> Building base R using rtools40

Scripts to build R for Windows using [Rtools40](https://github.com/r-windows/rtools-installer) toolchains. This version automatically gets built, checked, and deployed every day to [CRAN](https://cran.r-project.org/bin/windows/base/rdevel.html).

## Build requirements

To build R for Windows yourself, you need:

 - [rtools40](https://cran.r-project.org/bin/windows/Rtools/)
 - [InnoSetup 6](https://www.jrsoftware.org/isdl.php) (only required to build the full installer)
 - [MikTex](https://miktex.org/download)

Rtools40 provides perl and all required system libraries so we no longer need any special "extsoft" file like we did in the past.

## How to build yourself

Clone or [download](https://github.com/r-windows/r-base/archive/master.zip) this repository. Optionally edit [`MkRules.local.in`](MkRules.local.in) to adjust compiler flags. Now open any rtools msys2 shell from the Windows start menu.

![win10](https://user-images.githubusercontent.com/216319/73364595-1fe28080-42ab-11ea-9858-ac8c660757d6.png)

### Option 1: Quick development build

The  [`./quick-build.sh`](quick-build.sh) script shows how to build a local single-architecture version of R from a source tarball.

To build, run the [`./quick-build.sh`](quick-build.sh) script inside the rtools40 bash shell. This will build a complete 64-bit version of R, but not 32-bit R and also not manuals or the installer.

This is useful if you want to test a patch for base R. Obviously you can adjust the [`./quick-build.sh`](quick-build.sh) script to add patches.

### Option 2: build full installer

Alternatively run [`./full-build.sh`](full-build.sh) to build the complete installer as it appears on CRAN. This can take about 2 hours and requires you have innosetup and latex installed on your machine (in addition to rtools40). The process involves building both 32 and 64 bit R, as well as pdf manuals and finally the installer program. 
