# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.12.1
	atty@0.2.14
	autocfg@1.0.0
	backtrace@0.3.48
	bitflags@1.2.1
	bstr@0.2.13
	bumpalo@3.3.0
	byteorder@1.3.4
	cast@0.2.3
	cfg-if@0.1.10
	clap@2.33.1
	criterion@0.3.2
	criterion-plot@0.4.2
	crossbeam-deque@0.7.3
	crossbeam-epoch@0.8.2
	crossbeam-queue@0.2.1
	crossbeam-utils@0.7.2
	csv@1.1.3
	csv-core@0.1.10
	either@1.5.3
	failure@0.1.8
	failure_derive@0.1.8
	gimli@0.21.0
	hermit-abi@0.1.13
	itertools@0.9.0
	itoa@0.4.5
	js-sys@0.3.39
	lazy_static@1.4.0
	libc@0.2.70
	log@0.4.8
	maybe-uninit@2.0.0
	memchr@2.3.3
	memoffset@0.5.4
	num-traits@0.2.11
	num_cpus@1.13.0
	object@0.19.0
	oorandom@11.1.1
	plotters@0.2.14
	proc-macro2@1.0.17
	quote@1.0.6
	rayon@1.3.0
	rayon-core@1.7.0
	regex@1.3.7
	regex-automata@0.1.9
	regex-syntax@0.6.17
	rustc-demangle@0.1.16
	rustc_version@0.2.3
	ryu@1.0.4
	same-file@1.0.6
	scopeguard@1.1.0
	semver@0.9.0
	semver-parser@0.7.0
	serde@1.0.110
	serde_derive@1.0.110
	serde_json@1.0.53
	syn@1.0.23
	synstructure@0.12.3
	textwrap@0.11.0
	tinytemplate@1.0.4
	unicode-width@0.1.7
	unicode-xid@0.2.0
	vapoursynth@0.3.0
	vapoursynth-sys@0.3.0
	walkdir@2.3.1
	wasm-bindgen@0.2.62
	wasm-bindgen-backend@0.2.62
	wasm-bindgen-macro@0.2.62
	wasm-bindgen-macro-support@0.2.62
	wasm-bindgen-shared@0.2.62
	web-sys@0.3.39
	winapi@0.3.8
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
"

inherit cargo

DESCRIPTION="adaptivegrain-rs"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/adaptivegrain"
SRC_URI="https://github.com/Irrational-Encoding-Wizardry/adaptivegrain/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}
	media-libs/vapoursynth
"

src_install() {
	insinto "/usr/$(get_libdir)/vapoursynth/"
	doins ./*/*/libadaptivegrain_rs.so
}
