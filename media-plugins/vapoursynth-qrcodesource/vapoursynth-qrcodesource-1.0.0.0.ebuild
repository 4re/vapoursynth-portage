# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Plugin to provide a means to embed QR codes in video"
HOMEPAGE="https://github.com/jeremypoulter/QRCodeSource"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jeremypoulter/QRCodeSource.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/jeremypoulter/QRCodeSource/archive/Release_${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/fukuchi/libqrencode/archive/ca465caa9f497beab26dd17dc45cd08c76634820.zip -> LibQREncode-2014.09.23.zip"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
	media-libs/libpng
"
DEPEND="${RDEPEND}
"

if [[ ${PV} != *9999* ]]; then
	S="${WORKDIR}/QRCodeSource-Release_${PV}"
fi

src_unpack() {
	if [[ ${PV} != *9999* ]]; then
		unpack ${P}.tar.gz
		unpack LibQREncode-2014.09.23.zip
		mv libqrencode-ca465caa9f497beab26dd17dc45cd08c76634820/* "QRCodeSource-Release_${PV}/QRCodeSource/LibQREncode" || die
	else
		git-r3_src_unpack
	fi
}

src_prepare() {
	eapply_user
	./autogen.sh
}

src_configure() {
	econf --libdir="/usr/$(get_libdir)/vapoursynth/"
}
