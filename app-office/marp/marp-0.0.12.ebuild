# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils unpacker

DESCRIPTION=""
HOMEPAGE="https://yhatt.github.io/marp/"
SRC_URI="
	amd64? ( https://github.com/yhatt/marp/releases/download/v0.0.12/0.0.12-Marp-linux-x64.tar.gz )
	"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
"

RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install(){
	insinto "/usr/share/Marp"
	doins -r "."
	fperms +x "/usr/share/Marp/Marp"
	dosym "/usr/share/Marp/Marp" "/usr/bin/Marp"
}
