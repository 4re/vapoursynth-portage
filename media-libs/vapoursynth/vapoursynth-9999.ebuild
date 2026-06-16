# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
PYTHON_REQ_USE="threads(+)"
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=meson-python

inherit distutils-r1 xdg-utils

DESCRIPTION="VapourSynth is a library for video manipulation."
HOMEPAGE="http://www.vapoursynth.com/"
LICENSE="LGPL-2.1 OFL-1.1"
SLOT="0/4"

IUSE="lto +legacy -debug -guard cpu_flags_x86_sse2"
RESTRICT="mirror"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vapoursynth/vapoursynth.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/vapoursynth/vapoursynth/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	>=media-libs/zimg-3.0.6
"
DEPEND="${RDEPEND}
	$(python_gen_cond_dep 'dev-python/cython[${PYTHON_USEDEP}]')
	virtual/pkgconfig
"

python_configure_all() {
	DISTUTILS_ARGS=(
		$(meson_use debug)
		$(meson_use guard enable_guard_pattern)
		$(meson_use cpu_flags_x86_sse2 enable_x86_asm)
		-Db_lto=$(usex lto true false)
		-Db_ndebug=$(usex debug false true)
	)
}

src_install() {
	distutils-r1_src_install

	if use legacy; then
		insinto "$(python_get_sitedir)/vapoursynth/include/"
		doins include/VSHelper.h include/VapourSynth.h
	fi

	dosym -r "$(python_get_sitedir)/vapoursynth/pkgconfig/vapoursynth.pc" \
		"/usr/$(get_libdir)/pkgconfig/vapoursynth.pc" || die

    local vsscript_path="$(python_get_sitedir)/vapoursynth/libvsscript.so"
    echo "VSSCRIPT_PATH=\"${vsscript_path}\"" > "${T}/99vapoursynth" || die
    doenvd "${T}/99vapoursynth"

	insinto "/usr/share/mime/packages"
	doins "${FILESDIR}/vapoursynth.xml" || die
}

pkg_postinst() {
	xdg_mimeinfo_database_update

	elog "For backward compatibility, add this to your environment files if needed:"
	elog "  VAPOURSYNTH_EXTRA_PLUGIN_PATH=\"/usr/$(get_libdir)/vapoursynth\""
	elog "This allows plugins installed there to be auto-loaded."
	elog " "
	elog "The 99vapoursynth env file also sets VSSCRIPT_PATH, so 'vapoursynth config'"
	elog "and 'vapoursynth register-install' are normally unnecessary."
	elog "If needed, run those commands as the user who will use VapourSynth."
	elog " "
	elog "See: https://www.vapoursynth.com/doc/installation.html#general-installation"
	elog " "
	elog "After installation, re-login or run: source /etc/profile"
}

pkg_postrm() {
	xdg_mimeinfo_database_update
}
