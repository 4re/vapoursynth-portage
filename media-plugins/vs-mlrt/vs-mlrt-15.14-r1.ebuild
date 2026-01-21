# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit python-single-r1 git-r3 unpacker

# Default bundled models
MODEL_URIS="
	https://github.com/AmusementClub/vs-mlrt/releases/download/model-20211209/waifu2x_v3.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/model-20211209/RealESRGANv3_v1.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/model-20211209/RealESRGANv2_v1.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/model-20211209/dpir_v3.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/model-20211209/cugan_v2.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/model-20211209/cugan-pro_v3.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/model-20220923/rife_v8.7z
"

# Rife external models (4.11 to 4.26)
RIFE_MODEL_URIS="
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.11.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.12.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.13.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.14.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.15.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.17.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.18.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.19.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.20.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.21.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.22.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.23.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.24.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.25.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.26.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.12_lite.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.13_lite.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.14_lite.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.15_lite.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.16_lite.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.17_lite.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.22_lite.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.25_lite.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.25_heavy.7z
	https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/rife_v4.26_heavy.7z
"

DESCRIPTION="Efficient CPU/GPU/Vulkan ML Runtimes for VapourSynth"
HOMEPAGE="https://github.com/AmusementClub/vs-mlrt"
EGIT_REPO_URI="https://github.com/AmusementClub/vs-mlrt.git"

SRC_URI="
	models? (
		${MODEL_URIS}
	)
	model-waifu2x-swin-unet? (
		https://github.com/AmusementClub/vs-mlrt/releases/download/external-models/waifu2x_swin_unet_v5.7z
	)
	model-rife? (
		${RIFE_MODEL_URIS}
	)
"

if ver_test -eq 9999; then
	KEYWORDS=""
else
	EGIT_COMMIT="v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

# Only the NCNN backend for now.
# ONNX, TensorRT, and OpenVINO backends may be added later.
IUSE="+ncnn +models model-rife model-waifu2x-swin-unet"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="$(unpacker_src_uri_depends)"
RDEPEND+="
	${PYTHON_DEPS}
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	ncnn? (
		~media-plugins/vapoursynth-mlrt-ncnn-${PV}
	)
"
DEPEND="${RDEPEND}"

src_unpack() {
	git-r3_src_unpack

	mkdir "${S}/models"
	pushd "${S}/models"
	unpacker_src_unpack
	popd
}

src_install() {
	python_domodule scripts/vsmlrt.py

	insinto /usr/$(get_libdir)/vapoursynth/
	doins -r models
}
