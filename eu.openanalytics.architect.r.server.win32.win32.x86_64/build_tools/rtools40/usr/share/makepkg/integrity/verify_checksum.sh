#!/usr/bin/bash
#
#   verify_checksum.sh - functions for checking source checksums
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

[[ -n "$LIBMAKEPKG_INTEGRITY_VERIFY_CHECKSUM_SH" ]] && return
LIBMAKEPKG_INTEGRITY_CHECKSUM_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/pkgbuild.sh"
source "$LIBRARY/util/schema.sh"

check_checksums() {
	local integ a
	declare -A correlation
	(( SKIPCHECKSUMS )) && return 0

	# Initialize a map which we'll use to verify that every source array has at
	# least some kind of checksum array associated with it.
	(( ${#source[*]} )) && correlation['source']=1
	case $1 in
		all)
			for a in "${arch[@]}"; do
				array_build _ source_"$a" && correlation["source_$a"]=1
			done
			;;
		*)
			array_build _ source_"$CARCH" && correlation["source_$CARCH"]=1
			;;
	esac

	for integ in "${known_hash_algos[@]}"; do
		verify_integrity_sums "$integ" && unset "correlation[source]"

		case $1 in
			all)
				for a in "${arch[@]}"; do
					verify_integrity_sums "$integ" "$a" && unset "correlation[source_$a]"
				done
				;;
			*)
				verify_integrity_sums "$integ" "$CARCH" && unset "correlation[source_$CARCH]"
				;;
		esac
	done

	if (( ${#correlation[*]} )); then
		error "$(gettext "Integrity checks are missing for: %s")" "${!correlation[*]}"
		exit 1 # TODO: error code
	fi
}

verify_integrity_one() {
	local source_name=$1 integ=$2 expectedsum=$3

	local file="$(get_filename "$source_name")"
	printf '    %s ... ' "$file" >&2

	if [[ $expectedsum = 'SKIP' ]]; then
		printf '%s\n' "$(gettext "Skipped")" >&2
		return
	fi

	if ! file="$(get_filepath "$file")"; then
		printf '%s\n' "$(gettext "NOT FOUND")" >&2
		return 1
	fi

	local realsum="$("${integ}sum" "$file")"
	realsum="${realsum%% *}"
	if [[ ${expectedsum,,} = "$realsum" ]]; then
		printf '%s\n' "$(gettext "Passed")" >&2
	else
		printf '%s\n' "$(gettext "FAILED")" >&2
		return 1
	fi

	return 0
}

verify_integrity_sums() {
	local integ=$1 arch=$2 integrity_sums=() sources=() srcname

	if [[ $arch ]]; then
		array_build integrity_sums "${integ}sums_$arch"
		srcname=source_$arch
	else
		array_build integrity_sums "${integ}sums"
		srcname=source
	fi

	array_build sources "$srcname"
	if (( ${#integrity_sums[@]} == 0 && ${#sources[@]} == 0 )); then
		return 1
	fi

	if (( ${#integrity_sums[@]} == ${#sources[@]} )); then
		msg "$(gettext "Validating %s files with %s...")" "$srcname" "${integ}sums"
		local idx errors=0
		for (( idx = 0; idx < ${#sources[*]}; idx++ )); do
			verify_integrity_one "${sources[idx]}" "$integ" "${integrity_sums[idx]}" || errors=1
		done

		if (( errors )); then
			error "$(gettext "One or more files did not pass the validity check!")"
			exit 1 # TODO: error code
		fi
	elif (( ${#integrity_sums[@]} )); then
		error "$(gettext "Integrity checks (%s) differ in size from the source array.")" "$integ"
		exit 1 # TODO: error code
	else
		return 1
	fi
}
