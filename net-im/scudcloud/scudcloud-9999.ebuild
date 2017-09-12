# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

PYTHON_COMPAT=( python{3_5,3_6} )

inherit python-r1 distutils-r1

MY_AUTHOR="raelgc"
DESCRIPTION="A Linux client for Slack"
HOMEPAGE="https://github.com/${MY_AUTHOR}/${PN}"

inherit git-r3
EGIT_REPO_URI="https://github.com/${MY_AUTHOR}/${PN}.git"
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/PyQt5[${PYTHON_USEDEP},gui,network,webkit,widgets]
	dev-qt/qtwebkit:5"
RDEPEND="${DEPEND}"