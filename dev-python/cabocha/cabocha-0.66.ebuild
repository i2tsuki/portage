# Cpyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public Lisence v2
# $ $Header: /var/cvsroot/gentoo-x86/dev-python/mecab-python/mecab-python-0.996.ebuild,v 1.4 2013/09/05 18:46:40 mgorny Esp

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python binding for CaboCha"
HOMEPAGE="http://code.google.com/p/cabocha/"
SRC_URI="http://cabocha.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 amd64-linux x86-linux ~x64-macos ~x86-macos"

DEPEND="~app-text/cabocha-${PV}"
RDEPEND="${DEPEND}"

DOCS=( test.py )

src_compile() {
	cd python/
	distutils-r1_src_compile
}

src_test() {
	cd python/
	distutils-r1_src_test
}

src_install() {
	cd python/
	distutils-r1_src_install
}
