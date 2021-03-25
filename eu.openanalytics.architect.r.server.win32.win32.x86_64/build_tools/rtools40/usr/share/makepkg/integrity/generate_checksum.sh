#!/usr/bin/bash
#
#   generate_checksum.sh - functions for generating source checksums
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

[[ -n "$LIBMAKEPKG_INTEGRITY_GENERATE_CHECKSUM_SH" ]] && return
LIBMAKEPKG_INTEGRITY_GENERATE_CHECKSUM_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/pkgbuild.sh"
source "$LIBRARY/util/schema.sh"

generate_one_checksum() {
	local integ=$1 arch=$2 sources numsrc indentsz idx

	if [[ $arch ]]; then
		array_build sources "source_$arch"
	else
		array_build sources 'source'
	fi

	numsrc=${#sources[*]}
	if (( numsrc == 0 )); then
		return
	fi

	if [[ $arch ]]; then
		printf "%ssums_%s=(%n" "$integ" "$arch" indentsz
	else
		printf "%ssums=(%n" "$integ" indentsz
	fi

	for (( idx = 0; idx < numsrc; ++idx )); do
		local netfile=${sources[idx]}
		local proto sum
		proto="$(get_protocol "$netfile")"

		case $proto in
			bzr|git|hg|svn)
				sum="SKIP"
				;;
			*)
				if [[ ${netfile%%::*} != *.@(sig?(n)|asc) ]]; then
					local file
					file="$(get_filepath "$netfile")" || missing_source_file "$netfile"
					sum="$("${integ}sum" "$file")"
					sum=${sum%% *}
				else
					sum="SKIP"
				fi
				;;
		esac

		# indent checksum on lines after the first
		printf "%*s%s" $(( idx ? indentsz : 0 )) '' "'$sum'"

		# print a newline on lines before the last
		(( idx < (numsrc - 1) )) && echo
	done

	echo ")"
}

generate_checksums() {
	msg "$(gettext "Generating checksums for source files...")" >&2

	local integlist
	if (( $# == 0 )); then
		IFS=$'\n' read -rd '' -a integlist < <(get_integlist)
	else
		integlist=("$@")
	fi

	local integ
	for integ in "${integlist[@]}"; do
		if ! in_array "$integ" "${known_hash_algos[@]}"; then
			error "$(gettext "Invalid integrity algorithm '%s' specified.")" "$integ"
			exit 1 # $E_CONFIG_ERROR
		fi

		generate_one_checksum "$integ"
		for a in "${arch[@]}"; do
			generate_one_checksum "$integ" "$a"
		done
	done
}
