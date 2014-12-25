# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Python3 version of python-xlib"
HOMEPAGE="https://github.com/LiuLang/python3-xlib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="amd64 x86"
LICENSE="GPL"
SLOT="0"
IUSE=""

DEPEND="${RDEPEND}"
