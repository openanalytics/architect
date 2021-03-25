#!/usr/bin/bash
#
#   emptydirs.sh - Remove empty directories from the package
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

[[ -n "$LIBMAKEPKG_TIDY_EMPTYDIRS_SH" ]] && return
LIBMAKEPKG_TIDY_EMPTYDIRS_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/option.sh"


packaging_options+=('emptydirs')
tidy_remove+=('tidy_emptydirs')

tidy_emptydirs() {
	if check_option "emptydirs" "n"; then
		msg2 "$(gettext "Removing empty directories...")"
		# we are unable to use '-empty' as it is non-POSIX and not support by all find variants
		find . -depth -type d -exec rmdir '{}' \; 2>/dev/null
	fi
}
