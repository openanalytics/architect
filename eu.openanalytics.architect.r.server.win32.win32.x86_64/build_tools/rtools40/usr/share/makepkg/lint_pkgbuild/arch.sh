#!/usr/bin/bash
#
#   arch.sh - Check the 'arch' array conforms to requirements.
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

[[ -n "$LIBMAKEPKG_LINT_PKGBUILD_ARCH_SH" ]] && return
LIBMAKEPKG_LINT_PKGBUILD_ARCH_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/pkgbuild.sh"


lint_pkgbuild_functions+=('lint_arch')


lint_arch() {
	local a name list ret=0

	if in_array "any" "${arch[@]}"; then
		if (( ${#arch[@]} == 1 )); then
			return 0;
		else
			error "$(gettext "Can not use '%s' architecture with other architectures")" "any"
			return 1;
		fi
	fi

	for a in "${arch[@]}"; do
		if [[ $a = *[![:alnum:]_]* ]]; then
			error "$(gettext "%s contains invalid characters: '%s'")" \
					'arch' "${a//[[:alnum:]_]}"
			ret=1
		fi
	done

	if (( ! IGNOREARCH )) && ! in_array "$CARCH" "${arch[@]}"; then
		error "$(gettext "%s is not available for the '%s' architecture.")" "$pkgbase" "$CARCH"
		return 1
	fi

	for name in "${pkgname[@]}"; do
		get_pkgbuild_attribute "$name" 'arch' 1 list
		if [[ $list && $list != 'any' ]] && ! in_array $CARCH "${list[@]}"; then
			if (( ! IGNOREARCH )); then
				error "$(gettext "%s is not available for the '%s' architecture.")" "$name" "$CARCH"
				ret=1
			fi
		fi
	done

	return $ret
}
