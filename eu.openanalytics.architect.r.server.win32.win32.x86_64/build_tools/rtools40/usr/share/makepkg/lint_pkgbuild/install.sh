#!/usr/bin/bash
#
#   install.sh - Check the files in the 'install' array exist.
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

[[ -n "$LIBMAKEPKG_LINT_PKGBUILD_INSTALL_SH" ]] && return
LIBMAKEPKG_LINT_PKGBUILD_INSTALL_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/pkgbuild.sh"
source "$LIBRARY/lint_pkgbuild/util.sh"


lint_pkgbuild_functions+=('lint_install')


lint_install() {
	local list file name install_list ret=0

	install_list=("${install[@]}")
	for name in "${pkgname[@]}"; do
		extract_function_variable "package_$name" install 0 file
		install_list+=("$file")
	done

	check_files_exist 'install' "${install_list[@]}" || ret=1

	return $ret
}
