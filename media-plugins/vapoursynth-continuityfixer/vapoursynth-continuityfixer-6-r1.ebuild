# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs multilib

DESCRIPTION="Continuity Fixer port for Vapoursynth, can help repair damaged borders of frames"
HOMEPAGE="https://github.com/MonoS/VS-ContinuityFixer"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MonoS/VS-ContinuityFixer.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/MonoS/VS-ContinuityFixer/archive/V${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libcontinuity.so"

src_compile() {
	for i in *.cpp; do
		echo -e "\e[1m>>> \e[21 \e[00;32m$(tc-getCXX) ${CXXFLAGS} $i -fPIC $(pkg-config --cflags vapoursynth) -c -o ${i%.*}.o\e[00m"
		$(tc-getCXX) ${CXXFLAGS} $i -fPIC $(pkg-config --cflags vapoursynth) -c -o ${i%.*}.o || die
		OFILES="${OFILES} ${i%.*}.o"
	done
	echo -e "\e[1m>>> \e[21 \e[00;32m$(tc-getCXX) ${LDFLAGS} -shared ${OFILES} -o ${LIBNAME}\e[00m"
	$(tc-getCXX) ${LDFLAGS} -shared ${OFILES} -o ${LIBNAME} || die
}

src_install() {
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
	dodoc README.md
}
