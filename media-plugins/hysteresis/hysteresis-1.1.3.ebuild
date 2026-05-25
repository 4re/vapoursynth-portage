# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=hatchling

CRATES="
	autocfg@1.5.0
	bon-macros@3.9.1
	bon@3.9.1
	cfg-if@1.0.4
	const-str@1.1.0
	darling@0.23.0
	darling_core@0.23.0
	darling_macro@0.23.0
	heck@0.5.0
	ident_case@1.0.1
	miette-derive@7.6.0
	miette@7.6.0
	num-derive@0.4.2
	num-traits@0.2.19
	prettyplease@0.2.37
	proc-macro2@1.0.106
	quote@1.0.45
	rustversion@1.0.22
	seq-macro@0.3.6
	strsim@0.11.1
	strum@0.28.0
	strum_macros@0.28.0
	syn@2.0.117
	thiserror-impl@2.0.18
	thiserror@2.0.18
	unicode-ident@1.0.24
	unicode-width@0.1.14
	vapours@0.2.5
"

declare -A GIT_CRATES=(
	[vapoursynth4-rs]='https://github.com/inflation/vapoursynth4-rs;5685213b75cef2c8ae3e49ed60c71cb7258bc1a5;vapoursynth4-rs-%commit%/vapoursynth4-rs'
	[vapoursynth4-sys]='https://github.com/inflation/vapoursynth4-rs;5685213b75cef2c8ae3e49ed60c71cb7258bc1a5;vapoursynth4-rs-%commit%/vapoursynth4-sys'
)

inherit git-r3 distutils-r1

DESCRIPTION="Takes two bi-level masks clips and generates another bi-level mask clip"
HOMEPAGE="https://github.com/sgt0/vapoursynth-hysteresis"

EGIT_REPO_URI="https://github.com/sgt0/vapoursynth-hysteresis"
EGIT_COMMIT="refs/tags/v${PV}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 MIT MPL-2.0 Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="network-sandbox"
