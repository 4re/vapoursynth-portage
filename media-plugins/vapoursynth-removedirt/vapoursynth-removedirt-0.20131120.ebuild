# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs multilib git-r3

DESCRIPTION="Port of RemoveDirt to VapourSynth"
HOMEPAGE="https://github.com/handaimaoh/removedirtvs"

EGIT_REPO_URI="https://github.com/handaimaoh/removedirtvs.git"
EGIT_COMMIT="ddc78e55146eefa0f1c34e40c14e81625918e035"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

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
