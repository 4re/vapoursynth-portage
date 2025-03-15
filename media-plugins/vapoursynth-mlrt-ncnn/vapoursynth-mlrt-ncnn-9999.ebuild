# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="NCNN-based GPU (Vulkan) backend for vs-mlrt"
HOMEPAGE="https://github.com/AmusementClub/vs-mlrt#vsncnn-ncnn-based-gpu-vulkan-runtime"

if ver_test -eq 9999; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AmusementClub/vs-mlrt.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/AmusementClub/vs-mlrt/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth
	dev-libs/ncnn
	dev-libs/protobuf:=
	sci-ml/onnx:=
"
DEPEND="${RDEPEND}"
PATCHES="${FILESDIR}/0001-vsncnn-Include-mutex.patch"

if ver_test -eq 9999; then
	S="${S}/vsncnn"
else
	S="${WORKDIR}/vs-mlrt-${PV}/vsncnn"
fi

src_prepare() {
	sed -i "s|find_package(protobuf REQUIRED CONFIG)|find_package(Protobuf REQUIRED)|" \
		"${S}/CMakeLists.txt" || die

	cmake_src_prepare
}

src_configure() {
	append-flags "-DONNX_ML=1"
	append-flags "-DONNX_NAMESPACE=onnx"
	local mycmakeargs=(
		-DVAPOURSYNTH_INCLUDE_DIRECTORY="/usr/include/vapoursynth"
	)
	cmake_src_configure
}

src_install() {
	insinto "/usr/$(get_libdir)/vapoursynth"
	doins "${BUILD_DIR}/libvsncnn.so"
}
