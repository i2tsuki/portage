# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="2"
PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="GFeedLine is a social networking client. "
HOMEPAGE="https://code.google.com/p/gfeedline/‎"
SRC_URI="http://gfeedline.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_install() {
	distutils_src_install
}
