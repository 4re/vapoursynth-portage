# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit python-single-r1 git-r3

DESCRIPTION="Efficient CPU/GPU/Vulkan ML Runtimes for VapourSynth"
HOMEPAGE="https://github.com/AmusementClub/vs-mlrt"
EGIT_REPO_URI="https://github.com/AmusementClub/vs-mlrt.git"

if ver_test -eq 9999; then
	KEYWORDS=""
else
	EGIT_COMMIT="v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
# Only the NCNN backend for now.
#
# ONNX, TensorRT, and OpenVINO backends may be added later.
IUSE="+ncnn"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	ncnn? (
		media-plugins/vapoursynth-mlrt-ncnn
	)
"
DEPEND="${RDEPEND}"

src_install() {
	python_domodule scripts/vsmlrt.py
}
