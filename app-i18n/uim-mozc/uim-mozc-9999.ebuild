# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# version 0.1-r2 (furuki328, 2013.05.11)

EAPI="3"
PYTHON_DEPEND="2"
inherit elisp-common eutils multilib multiprocessing python toolchain-funcs

DESCRIPTION="The Mozc engine for uim"
HOMEPAGE="http://code.google.com/p/mozc/ http://macuim.googlecode.com/svn/trunk/Mozc/"

PROTOBUF_VER="2.4.1"
GMOCK_VER="403"
MOZC_VER="1.10.1390.102"

MOZC_URL="http://mozc.googlecode.com/files/mozc-${MOZC_VER}.tar.bz2"

PROTOBUF_URL="http://protobuf.googlecode.com/files/protobuf-${PROTOBUF_VER}.tar.bz2"

SRC_URI="${MOZC_URL} ${PROTOBUF_URL}"

LICENSE="Apache-2.0 BSD Boost-1.0 ipadic public-domain unicode"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="emacs +qt4 renderer"

RDEPEND="dev-libs/glib:2
	dev-libs/openssl
	x11-libs/libxcb
	app-i18n/uim
	emacs? ( virtual/emacs )
	renderer? ( x11-libs/gtk+:2 )
	qt4? (
		dev-qt/qtgui:4
		app-i18n/zinnia
	!app-i18n/mozc
	)"
# x11-libs/qt-gui:4 --> dev-qt/qtgui:4

DEPEND="${RDEPEND}
	dev-vcs/subversion
	virtual/pkgconfig"

BUILDTYPE="${BUILDTYPE:-Release}"

RESTRICT="test"

SITEFILE=50${PN}-gentoo.el

pkg_setup() {
	python_set_active_version 2
}

src_unpack() {
	unpack $(basename ${MOZC_URL})
	mv ${WORKDIR}/mozc-${MOZC_VER} ${WORKDIR}/${P}

	cd "${S}"/protobuf
	unpack $(basename ${PROTOBUF_URL})
	mv protobuf-${PROTOBUF_VER} files
}

src_prepare() {

	cd "${S}"
	svn export -r 320 --force https://macuim.googlecode.com/svn/trunk/Mozc Mozc || die "svn failed"
	rsync -auv --exclude=.svn "${S}/Mozc/uim" "${S}/unix/" || die "rsync failed"
	patch -p0 < "${S}/Mozc/mozc-kill-line.diff" || die "patch failed"

# 2013.05.11 add svn "-r 320" option.
}

src_configure() {
	local myconf="--channel_dev=0"
	myconf+=" --server_dir=/usr/$(get_libdir)/mozc"

	if ! use qt4 ; then
		myconf+=" --noqt"
		export GYP_DEFINES="use_libzinnia=0"
	fi

	if ! use renderer ; then
		export GYP_DEFINES="${GYP_DEFINES} enable_gtk_renderer=0"
	fi

	"$(PYTHON)" build_mozc.py gyp ${myconf} || die "gyp failed"
}

src_compile() {
	tc-export CC CXX AR AS RANLIB LD

	local my_makeopts=$(makeopts_jobs)
	# This is for a safety. -j without a number, makeopts_jobs returns 999.
	local myjobs=-j${my_makeopts/999/1}

	local mytarget="unix/uim/uim.gyp:uim-mozc server/server.gyp:mozc_server"
	use emacs && mytarget="${mytarget} unix/emacs/emacs.gyp:mozc_emacs_helper"
	use renderer && mytarget="${mytarget} renderer/renderer.gyp:mozc_renderer"
	if use qt4 ; then
		export QTDIR="${EPREFIX}/usr"
		mytarget="${mytarget} gui/gui.gyp:mozc_tool"
	fi

	"$(PYTHON)" build_mozc.py build_tools -c "${BUILDTYPE}" ${myjobs} || die
	"$(PYTHON)" build_mozc.py build -c "${BUILDTYPE}" ${mytarget} ${myjobs} || die

	if use emacs ; then
		elisp-compile unix/emacs/*.el || die
	fi
}

src_test() {
	"$(PYTHON)" build_mozc.py runtests -c "${BUILDTYPE}" || die
}

src_install() {
	if use emacs ; then
		dobin "out_linux/${BUILDTYPE}/mozc_emacs_helper" || die
		elisp-install ${PN} unix/emacs/*.{el,elc} || die
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" ${PN} || die
	fi

	exeinto "/usr/$(get_libdir)/uim/plugin" || die
	doexe "out_linux/${BUILDTYPE}/libuim-mozc.so" || die

	exeinto "/usr/$(get_libdir)/mozc" || die
	doexe "out_linux/${BUILDTYPE}/mozc_server" || die

	insinto "/usr/share/uim" || die
	doins "${S}/Mozc/scm/mozc-custom.scm" "${S}/Mozc/scm/mozc-key-custom.scm" "${S}/Mozc/scm/mozc.scm" || die

	insinto "/usr/share/uim/pixmaps/" || die
	newins "data/images/unix/ui-tool.png" "mozc_tool_uim_selector.png" || die
	newins "data/images/unix/ime_product_icon_opensource-32.png" "mozc.png" || die
	newins "data/images/unix/ui-properties.png" "mozc_tool_uim_config_dialog.png" || die
	newins "data/images/unix/ui-dictionary.png" "mozc_tool_uim_dictionary_tool.png" || die

	if use qt4 ; then
		exeinto "/usr/$(get_libdir)/mozc" || die
		doexe "out_linux/${BUILDTYPE}/mozc_tool" || die
	fi

	if use renderer ; then
		exeinto "/usr/$(get_libdir)/mozc" || die
		doexe "out_linux/${BUILDTYPE}/mozc_renderer" || die
	fi
}

pkg_postinst() {

	uim-module-manager --register mozc

	if use emacs ; then
		elisp-site-regen
		elog "You can use mozc-mode via LEIM (Library of Emacs Input Method)."
		elog "Write the following settings into your init file (~/.emacs.d/init.el"
		elog "or ~/.emacs) in order to use mozc-mode by default, or you can call"
		elog "\`set-input-method' and set \"japanese-mozc\" anytime you have loaded"
		elog "mozc.el"
		elog
		elog "  (require 'mozc)"
		elog "  (set-language-environment \"Japanese\")"
		elog "  (setq default-input-method \"japanese-mozc\")"
		elog
		elog "Having the above settings, just type C-\\ which is bound to"
		elog "\`toggle-input-method' by default."
	fi
}

pkg_postrm() {

	uim-module-manager --unregister mozc

	use emacs && elisp-site-regen

}
