#!/usr/bin/bash
#
#   provides.sh - Check the 'provides' array conforms to requirements.
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

[[ -n "$LIBMAKEPKG_LINT_PKGBUILD_PROVIDES_SH" ]] && return
LIBMAKEPKG_LINT_PKGBUILD_PROVIDES_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/lint_pkgbuild/fullpkgver.sh"
source "$LIBRARY/lint_pkgbuild/pkgname.sh"
source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/pkgbuild.sh"


lint_pkgbuild_functions+=('lint_provides')


lint_provides() {
	local provides_list provide name ver ret=0

	get_pkgbuild_all_split_attributes provides provides_list

	# this function requires extglob - save current status to restore later
	local shellopts=$(shopt -p extglob)
	shopt -s extglob

	for provide in "${provides_list[@]}"; do
		if [[ $provide == *['<>']* ]]; then
			error "$(gettext "%s array cannot contain comparison (< or >) operators.")" "provides"
			ret=1
			continue
		fi
		name=${provide%=*}
		lint_one_pkgname provides "$name" || ret=1
		if [[ $name != "$provide" ]]; then
			ver=${provide##$name=}
			check_fullpkgver "$ver" provides || ret=1
		fi
	done

	eval "$shellopts"

	return $ret
}
