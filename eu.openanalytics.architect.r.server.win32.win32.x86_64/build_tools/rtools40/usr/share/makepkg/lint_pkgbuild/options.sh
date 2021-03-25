#!/usr/bin/bash
#
#   options.sh - Check the 'options' array conforms to requirements.
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

[[ -n "$LIBMAKEPKG_LINT_PKGBUILD_OPTIONS_SH" ]] && return
LIBMAKEPKG_LINT_PKGBUILD_OPTIONS_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/pkgbuild.sh"


lint_pkgbuild_functions+=('lint_options')


lint_options() {
	local ret=0 list name kopt options_list

	options_list=("${options[@]}")
	for name in "${pkgname[@]}"; do
		if extract_function_variable "package_$name" options 1 list; then
			options_list+=("${list[@]}")
		fi
	done

	for i in "${options_list[@]}"; do
		# check if option matches a known option or its inverse
		for kopt in "${packaging_options[@]}" "${build_options[@]}"; do
			if [[ $i = "$kopt" || $i = "!$kopt" ]]; then
				# continue to the next $i
				continue 2
			fi
		done

		error "$(gettext "%s array contains unknown option '%s'")" "options" "$i"
		ret=1
	done

	return $ret
}
