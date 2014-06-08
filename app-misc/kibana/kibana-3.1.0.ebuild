# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Visualize logs and time-stamped data"
HOMEPAGE="http://www.elasticsearch.org/"
SRC_URI="http://download.elasticsearch.org/${PN}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="virtual/jre"

src_install() {
	insinto /usr/
	doins .
}
