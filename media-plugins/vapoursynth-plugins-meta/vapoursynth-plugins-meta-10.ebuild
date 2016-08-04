# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="VapourSynth plugins meta package."
HOMEPAGE="http://www.vapoursynth.com/"

LICENSE=""
SLOT="0"
KEYWORDS="*"
IUSE="
	vapoursynth_plugins_addgrain
	vapoursynth_plugins_adjust
	vapoursynth_plugins_awarpsharp2
	vapoursynth_plugins_bifrost
	vapoursynth_plugins_bilateral
	vapoursynth_plugins_bm3d
	vapoursynth_plugins_cnr2
	vapoursynth_plugins_combmask
	vapoursynth_plugins_continuityfixer
	vapoursynth_plugins_ctmf
	vapoursynth_plugins_d2vsource
	vapoursynth_plugins_damb
	vapoursynth_plugins_dctfilter
	vapoursynth_plugins_deblock
	vapoursynth_plugins_delogo
	vapoursynth_plugins_depan
	vapoursynth_plugins_dfttest
	vapoursynth_plugins_eedi2
	vapoursynth_plugins_ffmpegsource
	vapoursynth_plugins_fft3dfilter
	vapoursynth_plugins_fieldhint
	vapoursynth_plugins_fillborders
	vapoursynth_plugins_finesharp
	vapoursynth_plugins_flash3kyuu_deband
	vapoursynth_plugins_fluxsmooth
	vapoursynth_plugins_fmtconv
	vapoursynth_plugins_fmtcwrap
	vapoursynth_plugins_genericfilters
	vapoursynth_plugins_havsfunc
	vapoursynth_plugins_histogram
	vapoursynth_plugins_inpaint
	vapoursynth_plugins_it
	vapoursynth_plugins_knlmeanscl
	vapoursynth_plugins_l-smash-works
	vapoursynth_plugins_minsrp
	vapoursynth_plugins_msmoosh
	vapoursynth_plugins_mvsfunc
	vapoursynth_plugins_mvtools
	vapoursynth_plugins_mvtools-sf
	vapoursynth_plugins_nnedi3
	vapoursynth_plugins_oyster
	vapoursynth_plugins_reduceflicker
	vapoursynth_plugins_removedirt
	vapoursynth_plugins_retinex
	vapoursynth_plugins_sangnommod
	vapoursynth_plugins_scenechange
	vapoursynth_plugins_scxvid
	vapoursynth_plugins_ssiq
	vapoursynth_plugins_subtitle
	vapoursynth_plugins_surfaceblur
	vapoursynth_plugins_tc2cfr
	vapoursynth_plugins_tcanny
	vapoursynth_plugins_tcomb
	vapoursynth_plugins_tdeintmod
	vapoursynth_plugins_templinearapproximate
	vapoursynth_plugins_temporalsoften
	vapoursynth_plugins_tnlmeans
	vapoursynth_plugins_vaguedenoiser
	vapoursynth_plugins_vautodeint
	vapoursynth_plugins_vcmod
	vapoursynth_plugins_vcmove
	vapoursynth_plugins_vctrans
	vapoursynth_plugins_videoscope
	vapoursynth_plugins_vs-maskdetail
	vapoursynth_plugins_vsimagereader
	vapoursynth_plugins_vsrawsource
	vapoursynth_plugins_vstaambk
	vapoursynth_plugins_w3fdif
	vapoursynth_plugins_wwxd
	vapoursynth_plugins_yadifmod
"

RDEPEND+=""
DEPEND="${RDEPEND}
	vapoursynth_plugins_addgrain? ( media-plugins/vapoursynth-addgrain )
	vapoursynth_plugins_adjust? ( media-plugins/vapoursynth-adjust )
	vapoursynth_plugins_awarpsharp2? ( media-plugins/vapoursynth-awarpsharp2 )
	vapoursynth_plugins_bifrost? ( media-plugins/vapoursynth-bifrost )
	vapoursynth_plugins_bilateral? ( media-plugins/vapoursynth-bilateral )
	vapoursynth_plugins_bm3d? ( media-plugins/vapoursynth-bm3d )
	vapoursynth_plugins_cnr2? ( media-plugins/vapoursynth-cnr2 )
	vapoursynth_plugins_combmask? ( media-plugins/vapoursynth-combmask )
	vapoursynth_plugins_continuityfixer? ( media-plugins/vapoursynth-continuityfixer )
	vapoursynth_plugins_ctmf? ( media-plugins/vapoursynth-ctmf )
	vapoursynth_plugins_d2vsource? ( media-plugins/vapoursynth-d2vsource )
	vapoursynth_plugins_damb? ( media-plugins/vapoursynth-damb )
	vapoursynth_plugins_dctfilter? ( media-plugins/vapoursynth-dctfilter )
	vapoursynth_plugins_deblock? ( media-plugins/vapoursynth-deblock )
	vapoursynth_plugins_delogo? ( media-plugins/vapoursynth-delogo )
	vapoursynth_plugins_depan? ( media-plugins/vapoursynth-depan )
	vapoursynth_plugins_dfttest? ( media-plugins/vapoursynth-dfttest )
	vapoursynth_plugins_eedi2? ( media-plugins/vapoursynth-eedi2 )
	vapoursynth_plugins_ffmpegsource? ( media-plugins/vapoursynth-ffmpegsource )
	vapoursynth_plugins_fft3dfilter? ( media-plugins/vapoursynth-fft3dfilter )
	vapoursynth_plugins_fieldhint? ( media-plugins/vapoursynth-fieldhint )
	vapoursynth_plugins_fillborders? ( media-plugins/vapoursynth-fillborders )
	vapoursynth_plugins_finesharp? ( media-plugins/vapoursynth-finesharp )
	vapoursynth_plugins_flash3kyuu_deband? ( media-plugins/vapoursynth-flash3kyuu_deband )
	vapoursynth_plugins_fluxsmooth? ( media-plugins/vapoursynth-fluxsmooth )
	vapoursynth_plugins_fmtconv? ( media-plugins/vapoursynth-fmtconv )
	vapoursynth_plugins_fmtcwrap? ( media-plugins/vapoursynth-fmtcwrap )
	vapoursynth_plugins_genericfilters? ( media-plugins/vapoursynth-genericfilters )
	vapoursynth_plugins_havsfunc? ( media-plugins/vapoursynth-havsfunc )
	vapoursynth_plugins_histogram? ( media-plugins/vapoursynth-histogram )
	vapoursynth_plugins_inpaint? ( media-plugins/vapoursynth-inpaint )
	vapoursynth_plugins_it? ( media-plugins/vapoursynth-it )
	vapoursynth_plugins_knlmeanscl? ( media-plugins/vapoursynth-knlmeanscl )
	vapoursynth_plugins_l-smash-works? ( media-plugins/vapoursynth-l-smash-works )
	vapoursynth_plugins_minsrp? ( media-plugins/vapoursynth-minsrp )
	vapoursynth_plugins_msmoosh? ( media-plugins/vapoursynth-msmoosh )
	vapoursynth_plugins_mvsfunc? ( media-plugins/vapoursynth-mvsfunc )
	vapoursynth_plugins_mvtools? ( media-plugins/vapoursynth-mvtools )
	vapoursynth_plugins_mvtools-sf? ( media-plugins/vapoursynth-mvtools-sf )
	vapoursynth_plugins_nnedi3? ( media-plugins/vapoursynth-nnedi3 )
	vapoursynth_plugins_oyster? ( media-plugins/vapoursynth-oyster )
	vapoursynth_plugins_reduceflicker? ( media-plugins/vapoursynth-reduceflicker )
	vapoursynth_plugins_removedirt? ( media-plugins/vapoursynth-removedirt )
	vapoursynth_plugins_retinex? ( media-plugins/vapoursynth-retinex )
	vapoursynth_plugins_sangnommod? ( media-plugins/vapoursynth-sangnommod )
	vapoursynth_plugins_scenechange? ( media-plugins/vapoursynth-scenechange )
	vapoursynth_plugins_scxvid? ( media-plugins/vapoursynth-scxvid )
	vapoursynth_plugins_ssiq? ( media-plugins/vapoursynth-ssiq )
	vapoursynth_plugins_subtitle? ( media-plugins/vapoursynth-subtitle )
	vapoursynth_plugins_surfaceblur? ( media-plugins/vapoursynth-surfaceblur )
	vapoursynth_plugins_tc2cfr? ( media-plugins/vapoursynth-tc2cfr )
	vapoursynth_plugins_tcanny? ( media-plugins/vapoursynth-tcanny )
	vapoursynth_plugins_tcomb? ( media-plugins/vapoursynth-tcomb )
	vapoursynth_plugins_tdeintmod? ( media-plugins/vapoursynth-tdeintmod )
	vapoursynth_plugins_templinearapproximate? ( media-plugins/vapoursynth-templinearapproximate )
	vapoursynth_plugins_temporalsoften? ( media-plugins/vapoursynth-temporalsoften )
	vapoursynth_plugins_tnlmeans? ( media-plugins/vapoursynth-tnlmeans )
	vapoursynth_plugins_vaguedenoiser? ( media-plugins/vapoursynth-vaguedenoiser )
	vapoursynth_plugins_vautodeint? ( media-plugins/vapoursynth-vautodeint )
	vapoursynth_plugins_vcmod? ( media-plugins/vapoursynth-vcmod )
	vapoursynth_plugins_vcmove? ( media-plugins/vapoursynth-vcmove )
	vapoursynth_plugins_vctrans? ( media-plugins/vapoursynth-vctrans )
	vapoursynth_plugins_videoscope? ( media-plugins/vapoursynth-videoscope )
	vapoursynth_plugins_vs-maskdetail? ( media-plugins/vapoursynth-vs-maskdetail )
	vapoursynth_plugins_vsimagereader? ( media-plugins/vapoursynth-vsimagereader )
	vapoursynth_plugins_vsrawsource? ( media-plugins/vapoursynth-vsrawsource )
	vapoursynth_plugins_vstaambk? ( media-plugins/vapoursynth-vstaambk )
	vapoursynth_plugins_w3fdif? ( media-plugins/vapoursynth-w3fdif )
	vapoursynth_plugins_wwxd? ( media-plugins/vapoursynth-wwxd )
	vapoursynth_plugins_yadifmod? ( media-plugins/vapoursynth-yadifmod )
"
