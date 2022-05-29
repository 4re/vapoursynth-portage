# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="VapourSynth plugins meta package."
HOMEPAGE="http://www.vapoursynth.com/"

LICENSE=""
SLOT="0"
KEYWORDS="*"
IUSE="
	vapoursynth_plugins_acsuite
	vapoursynth_plugins_audiocutter
	vapoursynth_plugins_bestaudiosource
	vapoursynth_plugins_ocsuite
	vapoursynth_plugins_subtext
	vapoursynth_plugins_addgrain
	vapoursynth_plugins_adjust
	vapoursynth_plugins_arearesize
	vapoursynth_plugins_asharp
	vapoursynth_plugins_astdr
	vapoursynth_plugins_autocrop
	vapoursynth_plugins_awarpsharp2
	vapoursynth_plugins_beziercurve
	vapoursynth_plugins_bifrost
	vapoursynth_plugins_bilateral
	vapoursynth_plugins_bilateralgpu
	vapoursynth_plugins_bm3d
	vapoursynth_plugins_bm3dcuda
	vapoursynth_plugins_bwdif
	vapoursynth_plugins_cas
	vapoursynth_plugins_cmedian
	vapoursynth_plugins_cnr2
	vapoursynth_plugins_colorbars
	vapoursynth_plugins_combmask
	vapoursynth_plugins_continuityfixer
	vapoursynth_plugins_ctmf
	vapoursynth_plugins_curve
	vapoursynth_plugins_d2vsource
	vapoursynth_plugins_dctfilter
	vapoursynth_plugins_deblock
	vapoursynth_plugins_deblockpp7
	vapoursynth_plugins_decross
	vapoursynth_plugins_dedot
	vapoursynth_plugins_degrainmedian
	vapoursynth_plugins_delogo
	vapoursynth_plugins_depan
	vapoursynth_plugins_descale
	vapoursynth_plugins_dfmderainbow
	vapoursynth_plugins_dfttest
	vapoursynth_plugins_dotkill
	vapoursynth_plugins_dpid
	vapoursynth_plugins_edgefixer
	vapoursynth_plugins_edi_rpow2
	vapoursynth_plugins_eedi2
	vapoursynth_plugins_eedi3
	vapoursynth_plugins_ffmpegsource
	vapoursynth_plugins_fft3dfilter
	vapoursynth_plugins_fftspectrum
	vapoursynth_plugins_fieldhint
	vapoursynth_plugins_fillborders
	vapoursynth_plugins_finesharp
	vapoursynth_plugins_fix-telecined-fades
	vapoursynth_plugins_flash3kyuu_deband
	vapoursynth_plugins_fluxsmooth
	vapoursynth_plugins_fmtconv
	vapoursynth_plugins_fvsfunc
	vapoursynth_plugins_genericfilters
	vapoursynth_plugins_havsfunc
	vapoursynth_plugins_histogram
	vapoursynth_plugins_hqdn3d
	vapoursynth_plugins_hysteria
	vapoursynth_plugins_inpaint
	vapoursynth_plugins_it
	vapoursynth_plugins_kagefunc
	vapoursynth_plugins_knlmeanscl
	vapoursynth_plugins_l-smash-works
	vapoursynth_plugins_lghost
	vapoursynth_plugins_lvsfunc
	vapoursynth_plugins_matchhistogram
	vapoursynth_plugins_median
	vapoursynth_plugins_minideen
	vapoursynth_plugins_minsrp
	vapoursynth_plugins_miscfilters-obsolete
	vapoursynth_plugins_motionmask
	vapoursynth_plugins_msmoosh
	vapoursynth_plugins_muvsfunc
	vapoursynth_plugins_mvsfunc
	vapoursynth_plugins_mvtools
	vapoursynth_plugins_mvtools-sf
	vapoursynth_plugins_nnedi3
	vapoursynth_plugins_nnedi3_resample
	vapoursynth_plugins_nnedi3_rpow2
	vapoursynth_plugins_nnedi3cl
	vapoursynth_plugins_oyster
	vapoursynth_plugins_plum
	vapoursynth_plugins_qrcodesource
	vapoursynth_plugins_readmpls
	vapoursynth_plugins_reduceflicker
	vapoursynth_plugins_remapframes
	vapoursynth_plugins_removedirt
	vapoursynth_plugins_retinex
	vapoursynth_plugins_sangnom
	vapoursynth_plugins_scenechange
	vapoursynth_plugins_scxvid
	vapoursynth_plugins_smoothuv
	vapoursynth_plugins_ssiq
	vapoursynth_plugins_surfaceblur
	vapoursynth_plugins_tbilateral
	vapoursynth_plugins_tc2cfr
	vapoursynth_plugins_tcanny
	vapoursynth_plugins_tcomb
	vapoursynth_plugins_tdeintmod
	vapoursynth_plugins_tedgemask
	vapoursynth_plugins_templinearapproximate
	vapoursynth_plugins_temporalmedian
	vapoursynth_plugins_temporalsoften
	vapoursynth_plugins_temporalsoften2
	vapoursynth_plugins_timecube
	vapoursynth_plugins_tivtc
	vapoursynth_plugins_tnlmeans
	vapoursynth_plugins_tonemap
	vapoursynth_plugins_ttempsmooth
	vapoursynth_plugins_vaguedenoiser
	vapoursynth_plugins_vautodeint
	vapoursynth_plugins_vcm
	vapoursynth_plugins_vctrans
	vapoursynth_plugins_vfrtocrf
	vapoursynth_plugins_vfx
	vapoursynth_plugins_videoscope
	vapoursynth_plugins_vine
	vapoursynth_plugins_vmaf
	vapoursynth_plugins_vs-maskdetail
	vapoursynth_plugins_vsimagereader
	vapoursynth_plugins_vsrawsource
	vapoursynth_plugins_vstaambk
	vapoursynth_plugins_w3fdif
	vapoursynth_plugins_waifu2x-ncnn-vulkan
	vapoursynth_plugins_waifu2x-w2xc
	vapoursynth_plugins_warpsharpsupport
	vapoursynth_plugins_wwxd
	vapoursynth_plugins_xaa
	vapoursynth_plugins_yadifmod
	vapoursynth_plugins_znedi3
	vapoursynth_plugins_vivtc
	vapoursynth_plugins_vs-ccd
	vapoursynth_plugins_vs-imwri
	vapoursynth_plugins_vs-ocr
	vapoursynth_plugins_vs-placebo
	vapoursynth_plugins_vs-removegrain
	vapoursynth_plugins_vsutil
"

RDEPEND+=""
DEPEND="${RDEPEND}
	vapoursynth_plugins_acsuite? ( media-plugins/acsuite )
	vapoursynth_plugins_audiocutter? ( media-plugins/audiocutter )
	vapoursynth_plugins_bestaudiosource? ( media-plugins/bestaudiosource )
	vapoursynth_plugins_ocsuite? ( media-plugins/ocsuite )
	vapoursynth_plugins_subtext? ( media-plugins/subtext )
	vapoursynth_plugins_addgrain? ( media-plugins/vapoursynth-addgrain )
	vapoursynth_plugins_adjust? ( media-plugins/vapoursynth-adjust )
	vapoursynth_plugins_arearesize? ( media-plugins/vapoursynth-arearesize )
	vapoursynth_plugins_asharp? ( media-plugins/vapoursynth-asharp )
	vapoursynth_plugins_astdr? ( media-plugins/vapoursynth-astdr )
	vapoursynth_plugins_autocrop? ( media-plugins/vapoursynth-autocrop )
	vapoursynth_plugins_awarpsharp2? ( media-plugins/vapoursynth-awarpsharp2 )
	vapoursynth_plugins_beziercurve? ( media-plugins/vapoursynth-beziercurve )
	vapoursynth_plugins_bifrost? ( media-plugins/vapoursynth-bifrost )
	vapoursynth_plugins_bilateral? ( media-plugins/vapoursynth-bilateral )
	vapoursynth_plugins_bilateralgpu? ( media-plugins/vapoursynth-bilateralgpu )
	vapoursynth_plugins_bm3d? ( media-plugins/vapoursynth-bm3d )
	vapoursynth_plugins_bm3dcuda? ( media-plugins/vapoursynth-bm3dcuda )
	vapoursynth_plugins_bwdif? ( media-plugins/vapoursynth-bwdif )
	vapoursynth_plugins_cas? ( media-plugins/vapoursynth-cas )
	vapoursynth_plugins_cmedian? ( media-plugins/vapoursynth-cmedian )
	vapoursynth_plugins_cnr2? ( media-plugins/vapoursynth-cnr2 )
	vapoursynth_plugins_colorbars? ( media-plugins/vapoursynth-colorbars )
	vapoursynth_plugins_combmask? ( media-plugins/vapoursynth-combmask )
	vapoursynth_plugins_continuityfixer? ( media-plugins/vapoursynth-continuityfixer )
	vapoursynth_plugins_ctmf? ( media-plugins/vapoursynth-ctmf )
	vapoursynth_plugins_curve? ( media-plugins/vapoursynth-curve )
	vapoursynth_plugins_d2vsource? ( media-plugins/vapoursynth-d2vsource )
	vapoursynth_plugins_dctfilter? ( media-plugins/vapoursynth-dctfilter )
	vapoursynth_plugins_deblock? ( media-plugins/vapoursynth-deblock )
	vapoursynth_plugins_deblockpp7? ( media-plugins/vapoursynth-deblockpp7 )
	vapoursynth_plugins_decross? ( media-plugins/vapoursynth-decross )
	vapoursynth_plugins_dedot? ( media-plugins/vapoursynth-dedot )
	vapoursynth_plugins_degrainmedian? ( media-plugins/vapoursynth-degrainmedian )
	vapoursynth_plugins_delogo? ( media-plugins/vapoursynth-delogo )
	vapoursynth_plugins_depan? ( media-plugins/vapoursynth-depan )
	vapoursynth_plugins_descale? ( media-plugins/vapoursynth-descale )
	vapoursynth_plugins_dfmderainbow? ( media-plugins/vapoursynth-dfmderainbow )
	vapoursynth_plugins_dfttest? ( media-plugins/vapoursynth-dfttest )
	vapoursynth_plugins_dotkill? ( media-plugins/vapoursynth-dotkill )
	vapoursynth_plugins_dpid? ( media-plugins/vapoursynth-dpid )
	vapoursynth_plugins_edgefixer? ( media-plugins/vapoursynth-edgefixer )
	vapoursynth_plugins_edi_rpow2? ( media-plugins/vapoursynth-edi_rpow2 )
	vapoursynth_plugins_eedi2? ( media-plugins/vapoursynth-eedi2 )
	vapoursynth_plugins_eedi3? ( media-plugins/vapoursynth-eedi3 )
	vapoursynth_plugins_ffmpegsource? ( media-plugins/vapoursynth-ffmpegsource )
	vapoursynth_plugins_fft3dfilter? ( media-plugins/vapoursynth-fft3dfilter )
	vapoursynth_plugins_fftspectrum? ( media-plugins/vapoursynth-fftspectrum )
	vapoursynth_plugins_fieldhint? ( media-plugins/vapoursynth-fieldhint )
	vapoursynth_plugins_fillborders? ( media-plugins/vapoursynth-fillborders )
	vapoursynth_plugins_finesharp? ( media-plugins/vapoursynth-finesharp )
	vapoursynth_plugins_fix-telecined-fades? ( media-plugins/vapoursynth-fix-telecined-fades )
	vapoursynth_plugins_flash3kyuu_deband? ( media-plugins/vapoursynth-flash3kyuu_deband )
	vapoursynth_plugins_fluxsmooth? ( media-plugins/vapoursynth-fluxsmooth )
	vapoursynth_plugins_fmtconv? ( media-plugins/vapoursynth-fmtconv )
	vapoursynth_plugins_fvsfunc? ( media-plugins/vapoursynth-fvsfunc )
	vapoursynth_plugins_genericfilters? ( media-plugins/vapoursynth-genericfilters )
	vapoursynth_plugins_havsfunc? ( media-plugins/vapoursynth-havsfunc )
	vapoursynth_plugins_histogram? ( media-plugins/vapoursynth-histogram )
	vapoursynth_plugins_hqdn3d? ( media-plugins/vapoursynth-hqdn3d )
	vapoursynth_plugins_hysteria? ( media-plugins/vapoursynth-hysteria )
	vapoursynth_plugins_inpaint? ( media-plugins/vapoursynth-inpaint )
	vapoursynth_plugins_it? ( media-plugins/vapoursynth-it )
	vapoursynth_plugins_kagefunc? ( media-plugins/vapoursynth-kagefunc )
	vapoursynth_plugins_knlmeanscl? ( media-plugins/vapoursynth-knlmeanscl )
	vapoursynth_plugins_l-smash-works? ( media-plugins/vapoursynth-l-smash-works )
	vapoursynth_plugins_lghost? ( media-plugins/vapoursynth-lghost )
	vapoursynth_plugins_lvsfunc? ( media-plugins/vapoursynth-lvsfunc )
	vapoursynth_plugins_matchhistogram? ( media-plugins/vapoursynth-matchhistogram )
	vapoursynth_plugins_median? ( media-plugins/vapoursynth-median )
	vapoursynth_plugins_minideen? ( media-plugins/vapoursynth-minideen )
	vapoursynth_plugins_minsrp? ( media-plugins/vapoursynth-minsrp )
	vapoursynth_plugins_miscfilters-obsolete? ( media-plugins/vapoursynth-miscfilters-obsolete )
	vapoursynth_plugins_motionmask? ( media-plugins/vapoursynth-motionmask )
	vapoursynth_plugins_msmoosh? ( media-plugins/vapoursynth-msmoosh )
	vapoursynth_plugins_muvsfunc? ( media-plugins/vapoursynth-muvsfunc )
	vapoursynth_plugins_mvsfunc? ( media-plugins/vapoursynth-mvsfunc )
	vapoursynth_plugins_mvtools? ( media-plugins/vapoursynth-mvtools )
	vapoursynth_plugins_mvtools-sf? ( media-plugins/vapoursynth-mvtools-sf )
	vapoursynth_plugins_nnedi3? ( media-plugins/vapoursynth-nnedi3 )
	vapoursynth_plugins_nnedi3_resample? ( media-plugins/vapoursynth-nnedi3_resample )
	vapoursynth_plugins_nnedi3_rpow2? ( media-plugins/vapoursynth-nnedi3_rpow2 )
	vapoursynth_plugins_nnedi3cl? ( media-plugins/vapoursynth-nnedi3cl )
	vapoursynth_plugins_oyster? ( media-plugins/vapoursynth-oyster )
	vapoursynth_plugins_plum? ( media-plugins/vapoursynth-plum )
	vapoursynth_plugins_qrcodesource? ( media-plugins/vapoursynth-qrcodesource )
	vapoursynth_plugins_readmpls? ( media-plugins/vapoursynth-readmpls )
	vapoursynth_plugins_reduceflicker? ( media-plugins/vapoursynth-reduceflicker )
	vapoursynth_plugins_remapframes? ( media-plugins/vapoursynth-remapframes )
	vapoursynth_plugins_removedirt? ( media-plugins/vapoursynth-removedirt )
	vapoursynth_plugins_retinex? ( media-plugins/vapoursynth-retinex )
	vapoursynth_plugins_sangnom? ( media-plugins/vapoursynth-sangnom )
	vapoursynth_plugins_scenechange? ( media-plugins/vapoursynth-scenechange )
	vapoursynth_plugins_scxvid? ( media-plugins/vapoursynth-scxvid )
	vapoursynth_plugins_smoothuv? ( media-plugins/vapoursynth-smoothuv )
	vapoursynth_plugins_ssiq? ( media-plugins/vapoursynth-ssiq )
	vapoursynth_plugins_surfaceblur? ( media-plugins/vapoursynth-surfaceblur )
	vapoursynth_plugins_tbilateral? ( media-plugins/vapoursynth-tbilateral )
	vapoursynth_plugins_tc2cfr? ( media-plugins/vapoursynth-tc2cfr )
	vapoursynth_plugins_tcanny? ( media-plugins/vapoursynth-tcanny )
	vapoursynth_plugins_tcomb? ( media-plugins/vapoursynth-tcomb )
	vapoursynth_plugins_tdeintmod? ( media-plugins/vapoursynth-tdeintmod )
	vapoursynth_plugins_tedgemask? ( media-plugins/vapoursynth-tedgemask )
	vapoursynth_plugins_templinearapproximate? ( media-plugins/vapoursynth-templinearapproximate )
	vapoursynth_plugins_temporalmedian? ( media-plugins/vapoursynth-temporalmedian )
	vapoursynth_plugins_temporalsoften? ( media-plugins/vapoursynth-temporalsoften )
	vapoursynth_plugins_temporalsoften2? ( media-plugins/vapoursynth-temporalsoften2 )
	vapoursynth_plugins_timecube? ( media-plugins/vapoursynth-timecube )
	vapoursynth_plugins_tivtc? ( media-plugins/vapoursynth-tivtc )
	vapoursynth_plugins_tnlmeans? ( media-plugins/vapoursynth-tnlmeans )
	vapoursynth_plugins_tonemap? ( media-plugins/vapoursynth-tonemap )
	vapoursynth_plugins_ttempsmooth? ( media-plugins/vapoursynth-ttempsmooth )
	vapoursynth_plugins_vaguedenoiser? ( media-plugins/vapoursynth-vaguedenoiser )
	vapoursynth_plugins_vautodeint? ( media-plugins/vapoursynth-vautodeint )
	vapoursynth_plugins_vcm? ( media-plugins/vapoursynth-vcm )
	vapoursynth_plugins_vctrans? ( media-plugins/vapoursynth-vctrans )
	vapoursynth_plugins_vfrtocrf? ( media-plugins/vapoursynth-vfrtocrf )
	vapoursynth_plugins_vfx? ( media-plugins/vapoursynth-vfx )
	vapoursynth_plugins_videoscope? ( media-plugins/vapoursynth-videoscope )
	vapoursynth_plugins_vine? ( media-plugins/vapoursynth-vine )
	vapoursynth_plugins_vmaf? ( media-plugins/vapoursynth-vmaf )
	vapoursynth_plugins_vs-maskdetail? ( media-plugins/vapoursynth-vs-maskdetail )
	vapoursynth_plugins_vsimagereader? ( media-plugins/vapoursynth-vsimagereader )
	vapoursynth_plugins_vsrawsource? ( media-plugins/vapoursynth-vsrawsource )
	vapoursynth_plugins_vstaambk? ( media-plugins/vapoursynth-vstaambk )
	vapoursynth_plugins_w3fdif? ( media-plugins/vapoursynth-w3fdif )
	vapoursynth_plugins_waifu2x-ncnn-vulkan? ( media-plugins/vapoursynth-waifu2x-ncnn-vulkan )
	vapoursynth_plugins_waifu2x-w2xc? ( media-plugins/vapoursynth-waifu2x-w2xc )
	vapoursynth_plugins_warpsharpsupport? ( media-plugins/vapoursynth-warpsharpsupport )
	vapoursynth_plugins_wwxd? ( media-plugins/vapoursynth-wwxd )
	vapoursynth_plugins_xaa? ( media-plugins/vapoursynth-xaa )
	vapoursynth_plugins_yadifmod? ( media-plugins/vapoursynth-yadifmod )
	vapoursynth_plugins_znedi3? ( media-plugins/vapoursynth-znedi3 )
	vapoursynth_plugins_vivtc? ( media-plugins/vivtc )
	vapoursynth_plugins_vs-ccd? ( media-plugins/vs-ccd )
	vapoursynth_plugins_vs-imwri? ( media-plugins/vs-imwri )
	vapoursynth_plugins_vs-ocr? ( media-plugins/vs-ocr )
	vapoursynth_plugins_vs-placebo? ( media-plugins/vs-placebo )
	vapoursynth_plugins_vs-removegrain? ( media-plugins/vs-removegrain )
	vapoursynth_plugins_vsutil? ( media-plugins/vsutil )
"
