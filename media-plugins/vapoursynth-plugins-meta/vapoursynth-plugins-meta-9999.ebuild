# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit multilib-build

DESCRIPTION="Meta ebuild to pull in vapoursynth plugins"
HOMEPAGE="http://www.gentoo.org"

LICENSE="metapackage"
SLOT=""
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
    media-libs/zimg
    media-plugins/vapoursynth-L-SMASH-Works
    media-plugins/vapoursynth-addgrain
    media-plugins/vapoursynth-bifrost
    media-plugins/vapoursynth-bilateral
    media-plugins/vapoursynth-combmask
    media-plugins/vapoursynth-ctmf
    media-plugins/vapoursynth-d2vsource
    media-plugins/vapoursynth-damb
    media-plugins/vapoursynth-dctfilter
    media-plugins/vapoursynth-deblock
    media-plugins/vapoursynth-delogo
    media-plugins/vapoursynth-dfttest
    media-plugins/vapoursynth-eedi2
    media-plugins/vapoursynth-ffmpegsource
    media-plugins/vapoursynth-fieldhint
    media-plugins/vapoursynth-fillborders
    media-plugins/vapoursynth-flash3kyuu_deband
    media-plugins/vapoursynth-fluxsmooth
    media-plugins/vapoursynth-fmtconv
    media-plugins/vapoursynth-fmtcwrap
    media-plugins/vapoursynth-genericfilters
    media-plugins/vapoursynth-havsfunc
    media-plugins/vapoursynth-histogram
    media-plugins/vapoursynth-it
    media-plugins/vapoursynth-msmoosh
    media-plugins/vapoursynth-mvtools
    media-plugins/vapoursynth-nnedi3
    media-plugins/vapoursynth-plugins-meta
    media-plugins/vapoursynth-removedirt
    media-plugins/vapoursynth-retinex
    media-plugins/vapoursynth-sangnommod
    media-plugins/vapoursynth-scenechange
    media-plugins/vapoursynth-scxvid
    media-plugins/vapoursynth-ssiq
    media-plugins/vapoursynth-tcomb
    media-plugins/vapoursynth-tdeintmod
    media-plugins/vapoursynth-templinearapproximate
    media-plugins/vapoursynth-temporalsoften
    media-plugins/vapoursynth-vautodeint
    media-plugins/vapoursynth-videoscope
    media-plugins/vapoursynth-vs-maskdetail
    media-plugins/vapoursynth-vsimagereader
    media-plugins/vapoursynth-vsrawsource
    media-plugins/vapoursynth-wwxd
    media-plugins/vapoursynth-yadifmod
"

# Usage note:
# The idea is that apps depend on this for optional gstreamer plugins.  Then,
# when USE flags change, no app gets rebuilt, and all apps that can make use of
# the new plugin automatically do.

# When adding deps here, make sure the keywords on the vapoursynth-plugin are valid.
