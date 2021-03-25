#!/usr/bin/bash
#
#   bzr.sh - function for handling the download and "extraction" of Bazaar sources
#
#   Copyright (c) 2015-2019 Pacman Development Team <pacman-dev@archlinux.org>
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

[[ -n "$LIBMAKEPKG_SOURCE_BZR_SH" ]] && return
LIBMAKEPKG_SOURCE_BZR_SH=1


LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/pkgbuild.sh"


download_bzr() {
	# abort early if parent says not to fetch
	if declare -p get_vcs > /dev/null 2>&1; then
		(( get_vcs )) || return
	fi

	local netfile=$1

	local url=$(get_url "$netfile")
	if [[ $url != bzr+ssh* ]]; then
		url=${url#bzr+}
	fi
	url=${url%%#*}

	local repo=$(get_filename "$netfile")
	local displaylocation="$url"

	local dir=$(get_filepath "$netfile")
	[[ -z "$dir" ]] && dir="$SRCDEST/$(get_filename "$netfile")"

	if [[ ! -d "$dir" ]] || dir_is_empty "$dir" ; then
		msg2 "$(gettext "Branching %s...")" "${displaylocation}"
		if ! bzr branch "$url" "$dir" --no-tree --use-existing-dir; then
			error "$(gettext "Failure while branching %s")" "${displaylocation}"
			plain "$(gettext "Aborting...")"
			exit 1
		fi
	elif (( ! HOLDVER )); then
		msg2 "$(gettext "Pulling %s...")" "${displaylocation}"
		cd_safe "$dir"
		if ! bzr pull "$url"; then
			# only warn on failure to allow offline builds
			warning "$(gettext "Failure while pulling %s")" "${displaylocation}"
		fi
	fi
}

extract_bzr() {
	local netfile=$1

	local repo=$(get_filename "$netfile")
	local fragment=${netfile#*#}
	if [[ $fragment = "$netfile" ]]; then
		unset fragment
	fi

	rev="last:1"
	if [[ -n $fragment ]]; then
		case ${fragment%%=*} in
			revision)
				rev="${fragment#*=}"
				displaylocation="$url -r ${fragment#*=}"
				;;
			*)
				error "$(gettext "Unrecognized reference: %s")" "${fragment}"
				plain "$(gettext "Aborting...")"
				exit 1
		esac
	fi

	local dir=$(get_filepath "$netfile")
	[[ -z "$dir" ]] && dir="$SRCDEST/$(get_filename "$netfile")"

	msg2 "$(gettext "Creating working copy of %s %s repo...")" "${repo}" "bzr"
	pushd "$srcdir" &>/dev/null

	if [[ -d "${dir##*/}" ]]; then
		cd_safe "${dir##*/}"
		if ! (bzr pull "$dir" -q --overwrite -r "$rev" && bzr clean-tree -q --detritus --force); then
			error "$(gettext "Failure while updating working copy of %s %s repo")" "${repo}" "bzr"
			plain "$(gettext "Aborting...")"
			exit 1
		fi
	elif ! bzr checkout "$dir" -r "$rev"; then
		error "$(gettext "Failure while creating working copy of %s %s repo")" "${repo}" "bzr"
		plain "$(gettext "Aborting...")"
		exit 1
	fi

	popd &>/dev/null
}
