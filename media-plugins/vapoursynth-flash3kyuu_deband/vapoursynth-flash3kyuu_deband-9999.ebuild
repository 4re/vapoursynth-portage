# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

EGIT_REPO_URI="https://github.com/SAPikachu/flash3kyuu_deband.git"

inherit waf-utils git-2

DESCRIPTION="A deband library and filter for VapourSynth"
HOMEPAGE="https://github.com/SAPikachu/flash3kyuu_deband"

LICENSE=""
KEYWORDS="~amd64 ~x86"
IUSE="-debug"
SLOT="0"

RDEPEND+="
    media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_configure() {
	waf-utils_src_configure || die
}

src_compile() {
	waf-utils_src_compile || die
}

src_install() {
        exeinto /usr/lib/vapoursynth/
        doexe build/libf3kdb.so
}

#  * Using waf-utils.eclass without any python-r1 suite eclass is not supported
#  * and will be banned on 2015-01-24. Please make sure to configure and inherit
#  * appropriate -r1 eclass. For more information and examples, please see:
#  *     https://wiki.gentoo.org/wiki/Project:Python/waf-utils_integration
