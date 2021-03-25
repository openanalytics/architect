#!/usr/bin/bash
#
#   pkgname.sh - Check the 'pkgname' variable conforms to requirements.
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

[[ -n "$LIBMAKEPKG_LINT_PKGBUILD_PKGNAME_SH" ]] && return
LIBMAKEPKG_LINT_PKGBUILD_PKGNAME_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"


lint_pkgbuild_functions+=('lint_pkgname')


lint_one_pkgname() {
	local type=$1 name=$2 ret=0


	if [[ -z $name ]]; then
		error "$(gettext "%s is not allowed to be empty.")" "$type"
		return 1
	fi
	if [[ ${name:0:1} = "-" ]]; then
		error "$(gettext "%s is not allowed to start with a hyphen.")" "$type"
		ret=1
	fi
	if [[ ${name:0:1} = "." ]]; then
		error "$(gettext "%s is not allowed to start with a dot.")" "$type"
		ret=1
	fi
	if [[ $name = *[![:ascii:]]* ]]; then
		error "$(gettext "%s may only contain ascii characters.")" "$type"
		return 1
	fi
	if [[ $name = *[^[:alnum:]+_.@-]* ]]; then
		error "$(gettext "%s contains invalid characters: '%s'")" \
				"$type" "${name//[[:alnum:]+_.@-]}"
		ret=1
	fi

	return $ret
}

lint_pkgname() {
	local ret=0 i

	if [[ -z ${pkgname[@]} ]]; then
		error "$(gettext "%s is not allowed to be empty.")" "pkgname"
		ret=1
	else
		for i in "${pkgname[@]}"; do
			lint_one_pkgname "pkgname" "$i" || ret=1
		done
	fi

	return $ret
}
