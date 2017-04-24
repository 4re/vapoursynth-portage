# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A rewrite version of AVISynth SangNom2"
HOMEPAGE="https://bitbucket.org/James1201/vapoursynth-sangnom"

inherit mercurial
EHG_REPO_URI="https://bitbucket.org/James1201/${PN}"
EHG_REVISION="5a00bb64258d3d061ad4044caaf5447d42368b3f"
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE="doc cpu_flags_x86_sse2"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_prepare() {
	eapply_user
	fperms +x autogen.sh
	./autogen.sh
}

src_configure() {
	use doc && DOCS=( "${WORKDIR}/${P}/README.md" )
	econf --libdir="/usr/$(get_libdir)/vapoursynth/"
}
