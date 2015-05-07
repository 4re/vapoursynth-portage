# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs multilib

DESCRIPTION="A format-conversion plug-in for the Vapoursynth video processing engine"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166504"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vapoursynth/fmtconv.git"
else
	inherit vcs-snapshot
	SRC_URI="http://ldesoras.free.fr/src/vs/fmtconv-r${PV}.zip -> ${PN}-${PV}.zip"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+doc"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/${P}/src"
LIBNAME="libfmtconv.so"

src_prepare() {
	rm -fr VapourSynth.h || die
	SOURCEFILES=$(echo AvstpWrapper.cpp; echo main.cpp; ls fmtc/*.cpp; ls fmtcl/*.cpp; ls fstb/*.cpp; ls vsutl/*.cpp)
}

src_compile() {
	for i in ${SOURCEFILES}; do
		if [[ ${i,,} == *"avx.cpp" ]] || [[ ${i,,} == *"avx2.cpp" ]]; then
			EXTRAFLAGS="-mavx2"
		else
			EXTRAFLAGS="-msse2"
		fi
		echo -e "\e[1m>>> \e[21 \e[00;32m$(tc-getCXX) ${CFLAGS} ${EXTRAFLAGS} -fPIC -std=c++11 -I. $(pkg-config --cflags vapoursynth) ${i} -c -o ${i%.*}.o\e[00m"
		$(tc-getCXX) ${CFLAGS} ${EXTRAFLAGS} -fPIC -std=c++11 -I. $(pkg-config --cflags vapoursynth) ${i} -c -o ${i%.*}.o || die "compile failed"
	done

	echo -e "\e[1m>>> \e[21 \e[00;32m$(tc-getCXX) ${CFLAGS} ${LDFLAGS} -shared -fPIC -o ${LIBNAME} *.o */*.o\e[00m"
	$(tc-getCXX) ${CFLAGS} ${LDFLAGS} -shared -fPIC -o ${LIBNAME} *.o */*.o || die "linking failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME} || die
	if use doc; then
		dohtml -r ../doc/* || die
	fi
}
