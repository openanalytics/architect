# Maintainer: Jeroen Ooms <jeroen@berkeley.edu>

_realname=r-installer
pkgbase=${_realname}
pkgname="${_realname}"
pkgver=4.0.9000
pkgrel=1
pkgdesc="The R Programming Language"
arch=('any')
makedepends=("${MINGW_PACKAGE_PREFIX}-bzip2"
             "${MINGW_PACKAGE_PREFIX}-gcc"
             "${MINGW_PACKAGE_PREFIX}-gcc-fortran"
             "${MINGW_PACKAGE_PREFIX}-cairo"
             "${MINGW_PACKAGE_PREFIX}-curl"
             "${MINGW_PACKAGE_PREFIX}-icu"
             "${MINGW_PACKAGE_PREFIX}-libtiff"
             "${MINGW_PACKAGE_PREFIX}-libjpeg"
             "${MINGW_PACKAGE_PREFIX}-libpng"
             "${MINGW_PACKAGE_PREFIX}-pcre2"
             "${MINGW_PACKAGE_PREFIX}-tcl"
             "${MINGW_PACKAGE_PREFIX}-tk"
             "${MINGW_PACKAGE_PREFIX}-xz"
             "${MINGW_PACKAGE_PREFIX}-zlib"
             "texinfo"
             "texinfo-tex"
             "sed")
options=('staticlibs')
license=("GPL")
url="https://www.r-project.org/"

# Default source is R-devel (override via $rsource_url)
source=(R-source.tar.gz::"${rsource_url:-https://cran.r-project.org/src/base-prerelease/R-devel.tar.gz}"
    https://curl.se/ca/cacert.pem
    MkRules.local.in
    shortcut.diff
    create-tcltk-bundle.sh)

# Automatic untar fails due to embedded symlinks
noextract=(R-source.tar.gz)

sha256sums=('SKIP'
            'SKIP'
            'SKIP'
            'SKIP'
            'SKIP')

prepare() {
  # Verify that InnoSetup is installed
  INNOSETUP="C:/Program Files (x86)/Inno Setup 6/ISCC.exe"
  msg2 "Testing for $INNOSETUP"
  test -f "$INNOSETUP"
  "$INNOSETUP" 2>/dev/null || true

  # Put pdflatex on the path (assume Miktex 2.9)
  msg2 "Checking if pdflatex and texindex can be found..."
  export PATH="$PATH:/c/progra~1/MiKTeX/miktex/bin/x64:/c/progra~1/MiKTeX 2.9/miktex/bin/x64"
  pdflatex --version
  texindex --version

  # Extract tarball with symlink workarounds
  msg2 "Extracting R source tarball..."
  rm -rf ${srcdir}/R-source
  mkdir -p ${srcdir}/R-source
  MSYS="winsymlinks:lnk" tar -xf ${srcdir}/R-source.tar.gz -C ${srcdir}/R-source --strip-components=1
  cd "${srcdir}/R-source"

  # Ship the CA bundle
  cp "${srcdir}/cacert.pem" etc/curl-ca-bundle.crt

  # Ship the TclTk runtime bundle
  msg2 "Creating the TclTk runtime bundle"
  mkdir -p Tcl/{bin,bin64,lib,lib64}
  ${srcdir}/create-tcltk-bundle.sh  

  # Add your patches here
  patch -Np1 -i "${srcdir}/shortcut.diff"
}

build() {
  msg2 "Copying source files for 32-bit build..."
  rm -Rf ${srcdir}/build32
  MSYS="winsymlinks:lnk" cp -Rf "${srcdir}/R-source" ${srcdir}/build32

  # Build 32 bit version
  msg2 "Building 32-bit version of base R..."
  cd "${srcdir}/build32/src/gnuwin32"
  sed -e "s|@win@|32|" -e "s|@texindex@||" -e "s|@home32@||" "${srcdir}/MkRules.local.in" > MkRules.local
  #make 32-bit SHELL='sh -x'
  make 32-bit
  
  # Build 64 bit + docs and installers
  msg2 "Building 64-bit distribution"
  cd "${srcdir}/R-source/src/gnuwin32"
  TEXINDEX=$(cygpath -m $(which texindex))  
  sed -e "s|@win@|64|" -e "s|@texindex@|${TEXINDEX}|" -e "s|@home32@|${srcdir}/build32|" "${srcdir}/MkRules.local.in" > MkRules.local
  make distribution
}

check(){
  # Use cloud mirror for CRAN unit test
  #export R_CRAN_WEB="https://cran.rstudio.com"

  # Run 64 bit checks in foreground
  cd "${srcdir}/R-source/src/gnuwin32"
  echo "===== 64 bit checks ====="
  make check-all
}

package() {
  # Derive output locations
  REVISION=$((read x; echo ${x:10}) < "${srcdir}/R-source/SVN-REVISION")
  CRANDIR="${srcdir}/R-source/src/gnuwin32/cran"

  # This sets TARGET variable
  $(sed -e 's|set|export|' "${CRANDIR}/target.cmd")

  # Copy CRAN release files
  cp "${srcdir}/R-source/SVN-REVISION" "${pkgdir}/SVN-REVISION.${target}"
  cp "${CRANDIR}/NEWS.${target}.html" ${pkgdir}/
  cp "${CRANDIR}/README.${target}" ${pkgdir}/

  # Determine which webpage variant to ship from target (for example "R-3.4.1beta")
  case "$target" in
  *devel|*testing)
    cp "${CRANDIR}/rdevel.html" "${pkgdir}/"
    ;;
  *patched|*alpha|*beta|*rc)
    cp "${CRANDIR}/rpatched.html" "${pkgdir}/"
    cp "${CRANDIR}/rtest.html" "${pkgdir}/"
    ;;
  R-4*)
    cp "${CRANDIR}/index.html" "${pkgdir}/"
    cp "${CRANDIR}/md5sum.txt" "${pkgdir}/"
    cp "${CRANDIR}/rw-FAQ.html" "${pkgdir}/"
    cp "${CRANDIR}/release.html" "${pkgdir}/"
    REVISION="$target"
    ;;
  *)
    echo "Unknown release type: $target"
    exit 1
    ;;
  esac

  # Helper for appveyor script
  echo "set revision=${REVISION}" >> "${CRANDIR}/target.cmd"
  cp "${CRANDIR}/target.cmd" ${pkgdir}/
}
