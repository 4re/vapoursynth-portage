# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs meson

DESCRIPTION="Plugin to provide a means to embed QR codes in video"
HOMEPAGE="https://github.com/jeremypoulter/QRCodeSource"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jeremypoulter/QRCodeSource.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/jeremypoulter/QRCodeSource/archive/Release_${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
	media-libs/libpng
	media-gfx/qrencode
"
DEPEND="${RDEPEND}
"


src_prepare() {
	sed -i -e "s:LibQREncode/qrencode.h:qrencode.h:" QRCodeSource/QRCodeSource.cpp || die
	cat << EOF > meson.build
project('QRCodeSource',
        'cpp',
        default_options: ['buildtype=release', 'b_ndebug=if-release'],
        license : ['GPL-2.0'],
        version : '1')

add_project_arguments('-DIS_VAPOURSYNTH', language : 'cpp')

vs_dep = dependency('vapoursynth')

deps = [vs_dep,
        dependency('libpng'),
        dependency('libqrencode')]

src = ['QRCodeSource/QRCodeSource.cpp']

library('qrcodesource', src,
    dependencies : deps,
    install : true,
    install_dir : join_paths(vs_dep.get_pkgconfig_variable('libdir'), 'vapoursynth')
)
EOF
	default
}
