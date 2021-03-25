#!/usr/bin/bash
#
#   pacman.sh - Confirm presence of pacman binary
#
#   Copyright (c) 2012-2019 Pacman Development Team <pacman-dev@archlinux.org>
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

[[ -n "$LIBMAKEPKG_EXECUTABLE_PACMAN_SH" ]] && return
LIBMAKEPKG_EXECUTABLE_PACMAN_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"

executable_functions+=('executable_pacman')

executable_pacman() {
    if (( ! NODEPS || DEP_BIN || RMDEPS || INSTALL )); then
		if [[ -z $PACMAN_PATH ]]; then
			error "$(gettext "Cannot find the %s binary required for dependency operations.")" "$PACMAN"
			return 1
		fi
	fi
}
