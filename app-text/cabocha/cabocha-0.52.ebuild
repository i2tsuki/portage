# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cabocha/Attic/cabocha-0.52.ebuild,v 1.3 2006/11/02 19:12:01 usata dead $

inherit eutils

DESCRIPTION="Yet Another Japanese Dependency Structure Analyzer"
HOMEPAGE="http://code.google.com/p/cabocha/"
SRC_URI="http://cabocha.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
# KEYWORDS="~x86"

IUSE=""
#IUSE="perl python ruby"

DEPEND="app-text/yamcha
	|| ( app-text/chasen app-text/mecab )"
#RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	# http://cl.it.okayama-u.ac.jp/study/installmemo.html
	epatch ${FILESDIR}/${P}-amd64.patch
}

src_test() {
	make check || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS README TODO
}
