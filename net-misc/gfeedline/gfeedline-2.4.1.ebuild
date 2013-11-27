# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="5"
PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="GFeedLine is a social networking client. "
HOMEPAGE="https://code.google.com/p/gfeedline/‎"
SRC_URI="http://gfeedline.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gnome"

RDEPEND=">=gnome-base/gsettings-desktop-schemas-3.6.1
		 >=dev-python/twisted-web-11.0.0
		 >=dev-python/beautifulsoup-3.2.0:python-2
		 >=dev-python/oauth-1.0.1
		 >=dev-python/python-dateutil-2.1
		 >=dev-python/pyxdg-0.25
		 gnome? ( >=net-libs/libproxy-0.4.10-r1 )"

src_install() {
	distutils_src_install
	cp ./share/com.googlecode.gfeedline.gschema.xml.in /usr/share/glib-2.0/schemas/com.googlecode.gfeedline.gschema.xml
	glib-compile-schemas /usr/share/glib-2.0/schemas
}

pkg_preinst() {
	cp ./share/com.googlecode.gfeedline.gschema.xml.in /usr/share/glib-2.0/schemas/com.googlecode.gfeedline.gschema.xml
	glib-compile-schemas /usr/share/glib-2.0/schemas
}
