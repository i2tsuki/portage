# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cabocha/Attic/cabocha-0.53.ebuild,v 1.4 2010/12/29 12:24:15 tove dead $

EAPI="5"

DESCRIPTION="Kurohashi and Nagao Japanese Dependency Parser"
HOMEPAGE="http://nlp.ist.i.kyoto-u.ac.jp/"
SRC_URI="http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/knp/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="debug"

DEPEND=">=app-text/juman-7.0"

src_configure() {
	local myargs=""

	if use debug; then
		myargs="${myargs} --enable-debug"
	fi

	econf ${myargs}
}

src_compile() {
	emake
}

src_test() {
	make check || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS README TODO
}
