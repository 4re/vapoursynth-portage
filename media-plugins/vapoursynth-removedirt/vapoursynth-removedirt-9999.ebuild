# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 eutils

DESCRIPTION="Port of RemoveDirt to VapourSynth"
HOMEPAGE="https://github.com/handaimaoh/removedirtvs"
EGIT_REPO_URI="https://github.com/handaimaoh/removedirtvs.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_compile() {
# 	$(tc-getCC) \
# 	${CXXFLAGS} \
# 	-DVS_TARGET_CPU_X86=1 \
# 	-shared -fPIC -fpermissive \
# 	-o libremovedirt.so *.cpp -I. || die

#	echo -e "\e[1m>>> \e[21 \e[00;32m$(tc-getCXX) ${CXXFLAGS} ${LDFLAGS} -DVS_TARGET_CPU_X86=1 -shared -fPIC -fpermissive -o libremovedirt.so *.cpp -I. \e[00m"
#	$(tc-getCXX) \
#	${CXXFLAGS} ${LDFLAGS} \
#	-DVS_TARGET_CPU_X86=1 \
#	-shared -fPIC -fpermissive \
#	-Wl,-Bsymbolic -Wl,-z,noexecstack -Wl,-Bstatic -Wl,-Bdynamic -lvapoursynth \
#	-o libremovedirt.so *.cpp -Ishared.h -I/usr/include/vapoursynth || die

 	for i in *.cpp; do
 		echo -e "\e[1m>>> \e[21 \e[00;32m$(tc-getCXX) ${CXXFLAGS} -DVS_TARGET_CPU_X86=1 -fpermissive -shared -fPIC -I. $i -c -o $i.o\e[00m"
 		$(tc-getCXX) ${CXXFLAGS} -DVS_TARGET_CPU_X86=1 -fpermissive -shared -fPIC -I. $i -c -o $i.o || die
 	done
 	echo -e "\e[1m>>> \e[21 \e[00;32m$(tc-getLD) ${LDFLAGS} -shared -fPIC -Wl,-Bsymbolic -Wl,-z,noexecstack -o libremovedirt.so *.o -Wl,-Bstatic -Wl,-Bdynamic\e[00m"
	$(tc-getLD) -O1 --as-needed -shared -pie -Bsymbolic -z,noexecstack -o libremovedirt.so *.o || die
}

src_install() {
	exeinto /usr/lib/vapoursynth/
	doexe libremovedirt.so
	dodoc README.md
}
