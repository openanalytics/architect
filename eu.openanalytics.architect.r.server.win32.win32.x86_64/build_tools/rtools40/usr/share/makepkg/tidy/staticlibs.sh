#!/usr/bin/bash
#
#   staticlibs.sh - Remove static library files from the package
#
#   Copyright (c) 2013-2019 Pacman Development Team <pacman-dev@archlinux.org>
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

[[ -n "$LIBMAKEPKG_TIDY_STATICLIBS_SH" ]] && return
LIBMAKEPKG_TIDY_STATICLIBS_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/option.sh"


packaging_options+=('staticlibs')
tidy_remove+=('tidy_staticlibs')

tidy_staticlibs() {
	if check_option "staticlibs" "n"; then
		msg2 "$(gettext "Removing static library files...")"
		local l
		while IFS= read -rd '' l; do
			if [[ -f "${l%.a}.dll.a" || -h "${l%.a}.dll.a" ]]; then
				rm "$l"
			fi
		done < <(find . ! -type d \( -name "*.a" ! -name "*.dll.a" \) -print0)
	fi
}
