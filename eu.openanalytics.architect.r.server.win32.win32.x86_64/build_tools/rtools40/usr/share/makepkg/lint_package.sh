#!/usr/bin/bash
#
#   lint_package.sh - functions for checking for packaging errors
#
#   Copyright (c) 2015-2019 Pacman Development Team <pacman-dev@archlinux.org>
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

[[ -n "$LIBMAKEPKG_LINT_PACKAGE_SH" ]] && return
LIBMAKEPKG_LINT_PACKAGE_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/util.sh"


declare -a lint_package_functions

for lib in "$LIBRARY/lint_package/"*.sh; do
	source "$lib"
done

readonly -a lint_package_functions


lint_package() {
	cd_safe "$pkgdir"
	msg "$(gettext "Checking for packaging issues...")"

	local ret=0
	for func in ${lint_package_functions[@]}; do
		$func || ret=1
	done
	return $ret
}
