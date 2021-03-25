#!/usr/bin/bash
#
#   hg.sh - function for handling the download and "extraction" of Mercurial sources
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

[[ -n "$LIBMAKEPKG_SOURCE_HG_SH" ]] && return
LIBMAKEPKG_SOURCE_HG_SH=1


LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/pkgbuild.sh"


download_hg() {
	# abort early if parent says not to fetch
	if declare -p get_vcs > /dev/null 2>&1; then
		(( get_vcs )) || return
	fi

	local netfile=$1

	local dir=$(get_filepath "$netfile")
	[[ -z "$dir" ]] && dir="$SRCDEST/$(get_filename "$netfile")"

	local repo=$(get_filename "$netfile")

	local url=$(get_url "$netfile")
	url=${url#hg+}
	url=${url%%#*}

	if [[ ! -d "$dir" ]] || dir_is_empty "$dir" ; then
		msg2 "$(gettext "Cloning %s %s repo...")" "${repo}" "hg"
		if ! hg clone -U "$url" "$dir"; then
			error "$(gettext "Failure while downloading %s %s repo")" "${repo}" "hg"
			plain "$(gettext "Aborting...")"
			exit 1
		fi
	elif (( ! HOLDVER )); then
		msg2 "$(gettext "Updating %s %s repo...")" "${repo}" "hg"
		cd_safe "$dir"
		if ! hg pull; then
			# only warn on failure to allow offline builds
			warning "$(gettext "Failure while updating %s %s repo")" "${repo}" "hg"
		fi
	fi
}

extract_hg() {
	local netfile=$1

	local fragment=${netfile#*#}
	if [[ $fragment = "$netfile" ]]; then
		unset fragment
	fi

	local dir=$(get_filepath "$netfile")
	[[ -z "$dir" ]] && dir="$SRCDEST/$(get_filename "$netfile")"

	local repo=${netfile##*/}
	repo=${repo%%#*}

	msg2 "$(gettext "Creating working copy of %s %s repo...")" "${repo}" "hg"
	pushd "$srcdir" &>/dev/null

	local ref=default
	# Is the repository configured to checkout some ref other than 'default'?
	if hg identify -r @ "$dir" >/dev/null 2>&1; then
		ref=@
	fi
	if [[ -n $fragment ]]; then
		case ${fragment%%=*} in
			branch|revision|tag)
				ref="${fragment##*=}"
				;;
			*)
				error "$(gettext "Unrecognized reference: %s")" "${fragment}"
				plain "$(gettext "Aborting...")"
				exit 1
		esac
	fi

	if [[ -d "${dir##*/}" ]]; then
		cd_safe "${dir##*/}"
		if ! (hg pull && hg update -C -r "$ref"); then
			error "$(gettext "Failure while updating working copy of %s %s repo")" "${repo}" "hg"
			plain "$(gettext "Aborting...")"
			exit 1
		fi
	elif ! hg clone -u "$ref" "$dir" "${dir##*/}"; then
		error "$(gettext "Failure while creating working copy of %s %s repo")" "${repo}" "hg"
		plain "$(gettext "Aborting...")"
		exit 1
	fi

	popd &>/dev/null
}
