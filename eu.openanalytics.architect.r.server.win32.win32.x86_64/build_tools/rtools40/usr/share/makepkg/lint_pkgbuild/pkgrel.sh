#!/usr/bin/bash
#
#   pkgrel.sh - Check the 'pkgrel' variable conforms to requirements.
#
#   Copyright (c) 2014-2019 Pacman Development Team <pacman-dev@archlinux.org>
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

[[ -n "$LIBMAKEPKG_LINT_PKGBUILD_PKGREL_SH" ]] && return
LIBMAKEPKG_LINT_PKGBUILD_PKGREL_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"


lint_pkgbuild_functions+=('lint_pkgrel')


check_pkgrel() {
	local rel=$1 type=$2
	if [[ -z $rel ]]; then
		error "$(gettext "%s is not allowed to be empty.")" "pkgrel${type:+ in $type}"
		return 1
	fi

	if [[ $rel != +([0-9])?(.+([0-9])) ]]; then
		error "$(gettext "%s must be of the form 'integer[.integer]', not %s.")" "pkgrel${type:+ in $type}" "$rel"
		return 1
	fi
}

lint_pkgrel() {
	check_pkgrel "$pkgrel"
}
