# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="Yet Another Python wrapper for GraphicsMagick"
HOMEPAGE="http://wand-py.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="amd64 x86"
LICENSE="GPL"
SLOT="0"

DEPEND="${RDEPEND}
>=media-gfx/graphicsmagick-1.3.18
>=dev-libs/boost-1.52.0-r7"
