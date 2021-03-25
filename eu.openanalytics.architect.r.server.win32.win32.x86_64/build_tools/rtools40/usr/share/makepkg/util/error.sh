#!/usr/bin/bash
#
#   error.sh.in - error variable definitions for makepkg
#
#   Copyright (c) 2006-2019 Pacman Development Team <pacman-dev@archlinux.org>
#   Copyright (c) 2002-2006 by Judd Vinet <jvinet@zeroflux.org>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

[[ -n "$LIBMAKEPKG_UTIL_ERROR_SH" ]] && return
LIBMAKEPKG_UTIL_ERROR_SH=1

E_OK=0
E_FAIL=1 # Generic error
E_CONFIG_ERROR=2
E_INVALID_OPTION=3
E_USER_FUNCTION_FAILED=4
E_PACKAGE_FAILED=5
E_MISSING_FILE=6
E_MISSING_PKGDIR=7
E_INSTALL_DEPS_FAILED=8
E_REMOVE_DEPS_FAILED=9
E_ROOT=10
E_FS_PERMISSIONS=11
E_PKGBUILD_ERROR=12
E_ALREADY_BUILT=13
E_INSTALL_FAILED=14
E_MISSING_MAKEPKG_DEPS=15
E_PRETTY_BAD_PRIVACY=16
