# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

CRATES="
	aho-corasick@1.1.4
	alloca@0.4.0
	anes@0.1.6
	anstyle@1.0.14
	anyhow@1.0.102
	autocfg@1.5.0
	bumpalo@3.20.2
	cast@0.3.0
	cc@1.2.61
	cfg-if@1.0.4
	ciborium-io@0.2.2
	ciborium-ll@0.2.2
	ciborium@0.2.2
	clap@4.6.1
	clap_builder@4.6.0
	clap_lex@1.1.0
	criterion-plot@0.8.2
	criterion@0.8.2
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	crunchy@0.2.4
	either@1.15.0
	find-msvc-tools@0.1.9
	futures-core@0.3.32
	futures-task@0.3.32
	futures-util@0.3.32
	half@2.7.1
	itertools@0.13.0
	itoa@1.0.18
	js-sys@0.3.97
	libc@0.2.186
	libloading@0.9.0
	memchr@2.8.0
	num-traits@0.2.19
	once_cell@1.21.4
	oorandom@11.1.5
	page_size@0.6.0
	pin-project-lite@0.2.17
	plotters-backend@0.3.7
	plotters-svg@0.3.7
	plotters@0.3.7
	proc-macro2@1.0.106
	quote@1.0.45
	rayon-core@1.13.0
	rayon@1.12.0
	regex-automata@0.4.14
	regex-syntax@0.8.10
	regex@1.12.3
	rustversion@1.0.22
	same-file@1.0.6
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.149
	shlex@1.3.0
	slab@0.4.12
	syn@2.0.117
	thiserror-impl@2.0.18
	thiserror@2.0.18
	tinytemplate@1.2.1
	unicode-ident@1.0.24
	vapoursynth-sys@0.6.0
	vapoursynth@0.5.5
	walkdir@2.5.0
	wasm-bindgen-macro-support@0.2.120
	wasm-bindgen-macro@0.2.120
	wasm-bindgen-shared@0.2.120
	wasm-bindgen@0.2.120
	web-sys@0.3.97
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.11
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-link@0.2.1
	windows-sys@0.61.2
	zerocopy-derive@0.8.48
	zerocopy@0.8.48
	zmij@1.0.21
"

inherit cargo python-single-r1

DESCRIPTION="adaptivegrain-rs"
HOMEPAGE="https://github.com/kageru/adaptivegrain"
SRC_URI="https://github.com/kageru/adaptivegrain/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"

pkg_setup() {
	rust_pkg_setup
	python-single-r1_pkg_setup
}

src_install() {
	insinto "$(vapoursynth get-plugin-dir)"
	doins target/release/libadaptivegrain_rs.so
}
