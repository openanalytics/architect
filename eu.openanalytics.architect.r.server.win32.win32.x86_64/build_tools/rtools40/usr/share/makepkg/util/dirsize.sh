#!/usr/bin/bash
#
#   dirsize.sh - calculate size of all files in a directory
#
#   Copyright (c) 2019 Pacman Development Team <pacman-dev@archlinux.org>
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

[[ -n "$LIBMAKEPKG_UTIL_DIRSIZE_SH" ]] && return
LIBMAKEPKG_UTIL_DIRSIZE_SH=1


# find the total filesize of all files in the current directory while only
# counting multiply hardlinked files once
dirsize() {
	local file inode
	declare -A files

	{
		find . -type f -links 1 -exec cat {} + 2>/dev/null
		while read -rd ' ' inode; do
			IFS= read -r file
			if [[ -z ${files[$inode]} ]]; then
				files[$inode]=found
				cat "$file"
			fi
		done < <(find . -type f -links +1 -exec stat -c '%i %n' {} + 2>/dev/null)
	} | wc -c
}
