# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils unpacker

DESCRIPTION=""
HOMEPAGE="https://boostnote.io"
SRC_URI="
	amd64? ( https://github.com/BoostIO/boost-releases/releases/download/v0.11.2/boostnote_0.11.2_amd64.deb )
	"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
"

RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install(){
	insinto "/usr/share"
	doins -r "usr/share/."
	fperms +x "/usr/share/boostnote/Boostnote"
	dosym "/usr/share/boostnote/Boostnote" "/usr/bin/boostnote"
}
