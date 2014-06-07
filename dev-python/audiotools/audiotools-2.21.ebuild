EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="collection of audio handling programs"
HOMEPAGE="http://audiotools.sourceforge.net/"
SRC_URI="http://sourceforge.net/projects/audiotools/files/audiotools/${PV}/audiotools-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/libcdio"
RDEPEND=""

DOCS=( test.py )

src_compile() {
	distutils-r1_src_compile
}

src_test() {
	distutils-r1_src_test
}

src_install() {
	distutils-r1_src_install
}
