# Cpyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public Lisence v2

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Microblogging Client Written in Python"
HOMEPAGE="http://turpial.org.ve/"
SRC_URI="http://files.turpial.org.ve/sources/development/${P}-a1.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

src_compile() {
	distutils-r1_src_compile
}

src_install() {
	distutils-r1_src_install
}
