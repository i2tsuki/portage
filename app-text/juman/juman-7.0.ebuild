# Copyright 2012-2013 kdkk-
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="Rule-based Japanese Morphological Analyzer"
HOMEPAGE="http://nlp.ist.i.kyoto-u.ac.jp/"
SRC_URI="http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/juman/${P}.tar.bz2"


LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="unicode"

DEPEND=""

src_configure() {
	local myargs=""
	if use unicode; then
		myargs="${myargs} --with-charset=utf8"
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

	dodoc AUTHORS README doc/manual.pdf
}
