# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A Rust's package manager"
HOMEPAGE="http://crates.io/"

LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0"
KEYWORDS=""

IUSE=""

TRIPLE="x86_64-unknown-linux-gnu"
# TRIPLE="$(/usr/bin/gcc -dumpmachine)"
SRC_URI="https://static.rust-lang.org/cargo-dist/cargo-nightly-${TRIPLE}.tar.gz"


DEPEND=">=dev-lang/rust-999-r1"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv cargo-nightly-${TRIPLE} ${PN}-${PV}
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-no-sanity-check.patch"
	:
}


src_configure() {
	:
}

src_compile(){
	:
}

src_install() {
	./install.sh --prefix=${D} --disable-verify
	into /usr
	insinto /usr
	dobin bin/cargo

	dodoc share/doc/cargo/LICENSE-MIT
	dodoc share/doc/cargo/LICENSE-THIRD-PARTY
	dodoc share/doc/cargo/README.md
	dodoc share/doc/cargo/LICENSE-APACHE

	doman share/man/man1/cargo.1

	doins share/zsh/site-functions/_cargo

	doins ./etc/bash_completion.d/cargo
}
