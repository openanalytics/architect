#!/usr/bin/bash
#
#   zipman.sh - Compress man and info pages
#
#   Copyright (c) 2011-2019 Pacman Development Team <pacman-dev@archlinux.org>
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

[[ -n "$LIBMAKEPKG_TIDY_ZIPMAN_SH" ]] && return
LIBMAKEPKG_TIDY_ZIPMAN_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/option.sh"


packaging_options+=('zipman')
tidy_modify+=('tidy_zipman')

tidy_zipman() {
	if check_option "zipman" "y" && [[ -n ${MAN_DIRS[*]} ]]; then
		msg2 "$(gettext "Compressing man and info pages...")"
		local file files inode link
		while read -rd ' ' inode; do
			IFS= read -r file
			find "${MAN_DIRS[@]}" -type l -print0 2>/dev/null |
			while IFS= read -rd '' link ; do
				if [[ "${file}" -ef "${link}" ]] ; then
					rm -f "$link" "${link}.gz"
					if [[ ${file%/*} = "${link%/*}" ]]; then
						ln -s -- "${file##*/}.gz" "${link}.gz"
					else
						ln -s -- "/${file}.gz" "${link}.gz"
					fi
				fi
			done
			if [[ -z ${files[$inode]} ]]; then
				files[$inode]=$file
				gzip -9 -n -f "$file"
			else
				rm -f "$file"
				ln "${files[$inode]}.gz" "${file}.gz"
				chmod 644 "${file}.gz"
			fi
		done < <(find "${MAN_DIRS[@]}" -type f \! -name "*.gz" \! -name "*.bz2" \
			-exec stat -c '%i %n' '{}' + 2>/dev/null)
	fi
}
