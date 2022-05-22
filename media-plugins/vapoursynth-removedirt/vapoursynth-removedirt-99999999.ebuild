# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs multilib

DESCRIPTION="Port of RemoveDirt to VapourSynth"
HOMEPAGE="https://github.com/handaimaoh/removedirtvs"
EGIT_REPO_URI="https://github.com/handaimaoh/removedirtvs.git"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/handaimaoh/removedirtvs.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/handaimaoh/removedirtvs/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_compile() {
	for i in *.cpp; do
		echo -e "\e[1m>>> \e[21 \e[00;32m$(tc-getCXX) ${CXXFLAGS} -DVS_TARGET_CPU_X86=1 -fpermissive -shared -fPIC -I. $i -c -o $i.o\e[00m"
		$(tc-getCXX) ${CXXFLAGS} -DVS_TARGET_CPU_X86=1 -fpermissive -shared -fPIC -I. $i -c -o $i.o || die
	done
	echo -e "\e[1m>>> \e[21 \e[00;32m$(tc-getCXX) ${LDFLAGS} -shared -o libremovedirt.so *.o\e[00m"
	$(tc-getCXX) ${LDFLAGS} -shared -o libremovedirt.so *.o || die
}

src_install() {
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe libremovedirt.so
	dodoc README.md
}
