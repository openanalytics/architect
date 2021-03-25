#!/usr/bin/bash
#
#   vcs.sh - Confirm presence of binaries for VCS operations
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

[[ -n "$LIBMAKEPKG_EXECUTABLE_VCS_SH" ]] && return
LIBMAKEPKG_EXECUTABLE_VCS_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/error.sh"
source "$LIBRARY/util/message.sh"

executable_functions+=('executable_vcs')

get_vcsclient() {
	local proto=${1%%+*}

	local i
	for i in "${VCSCLIENTS[@]}"; do
		local handler="${i%%::*}"
		if [[ $proto = "$handler" ]]; then
			local client="${i##*::}"
			break
		fi
	done

	# if we didn't find an client, return an error
	if [[ -z $client ]]; then
		error "$(gettext "Unknown download protocol: %s")" "$proto"
		plain "$(gettext "Aborting...")"
		exit $E_CONFIG_ERROR
	fi

	printf "%s\n" "$client"
}

executable_vcs() {
	local netfile all_sources all_deps deps ret=0

	if (( SOURCEONLY == 1 )); then
		# we will not download VCS sources
		return $ret
	fi

	if [[ -z $PACMAN_PATH ]]; then
		warning "$(gettext "Cannot find the %s binary needed to check VCS source requirements.")" "$PACMAN"
		return $ret
	fi

	# we currently only use global depends/makedepends arrays for --syncdeps
	for attr in depends makedepends; do
		get_pkgbuild_attribute "$pkg" "$attr" 1 'deps'
		all_deps+=("${deps[@]}")

		get_pkgbuild_attribute "$pkg" "${attr}_$CARCH" 1 'deps'
		all_deps+=("${deps[@]}")
	done

	get_all_sources_for_arch 'all_sources'
	for netfile in ${all_sources[@]}; do
		local proto=$(get_protocol "$netfile")

		case $proto in
			bzr*|git*|hg*|svn*)
				if ! type -p ${proto%%+*} > /dev/null; then
					local client
					client=$(get_vcsclient "$proto") || exit $?
					# ensure specified program is installed
					local uninstalled
					uninstalled=$(check_deps "$client") || exit $E_INSTALL_DEPS_FAILED
					# if not installed, check presence in depends or makedepends
					if [[ -n "$uninstalled" ]] && (( ! NODEPS || ( VERIFYSOURCE && !DEP_BIN ) )); then
						if ! in_array "$client" ${all_deps[@]}; then
							error "$(gettext "Cannot find the %s package needed to handle %s sources.")" \
									"$client" "${proto%%+*}"
							ret=1
						fi
					fi
				fi
				;;
			*)
				# non VCS source
				;;
		esac
	done

	return $ret
}
