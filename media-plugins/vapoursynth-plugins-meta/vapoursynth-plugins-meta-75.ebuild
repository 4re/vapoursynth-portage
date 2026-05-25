# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="VapourSynth plugins meta package."
HOMEPAGE="https://www.vapoursynth.com/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="*"
IUSE="
	vapoursynth_plugins_acsuite
	vapoursynth_plugins_adaptivegrain
	vapoursynth_plugins_audiocutter
	vapoursynth_plugins_bestsource
	vapoursynth_plugins_descratch
	vapoursynth_plugins_dmetrics
	vapoursynth_plugins_hysteresis
	vapoursynth_plugins_manipulate-motion-vectors
	vapoursynth_plugins_ocsuite
	vapoursynth_plugins_rawz
	vapoursynth_plugins_subtext
	vapoursynth_plugins_adjust
	vapoursynth_plugins_akarin
	vapoursynth_plugins_awarp
	vapoursynth_plugins_bifrost
	vapoursynth_plugins_bm3d
	vapoursynth_plugins_bwdif
	vapoursynth_plugins_cmedian
	vapoursynth_plugins_colorbars
	vapoursynth_plugins_d2vsource
	vapoursynth_plugins_dctfilter
	vapoursynth_plugins_deblock
	vapoursynth_plugins_dedot
	vapoursynth_plugins_descale
	vapoursynth_plugins_dotkill
	vapoursynth_plugins_edgefixer
	vapoursynth_plugins_edgemasks
	vapoursynth_plugins_eedi3
	vapoursynth_plugins_ffmpegsource
	vapoursynth_plugins_fft3dfilter
	vapoursynth_plugins_fieldhint
	vapoursynth_plugins_fillborders
	vapoursynth_plugins_finesharp
	vapoursynth_plugins_fmtconv
	vapoursynth_plugins_histogram
	vapoursynth_plugins_hysteria
	vapoursynth_plugins_iscombed
	vapoursynth_plugins_knlmeanscl
	vapoursynth_plugins_miscfilters-obsolete
	vapoursynth_plugins_mvsfunc
	vapoursynth_plugins_mvtools
	vapoursynth_plugins_readmpls
	vapoursynth_plugins_resize2
	vapoursynth_plugins_rife-ncnn-vulkan
	vapoursynth_plugins_sangnom
	vapoursynth_plugins_scxvid
	vapoursynth_plugins_sneedif
	vapoursynth_plugins_timecube
	vapoursynth_plugins_tivtc
	vapoursynth_plugins_ttempsmooth
	vapoursynth_plugins_vcm
	vapoursynth_plugins_vmaf
	vapoursynth_plugins_vs-maskdetail
	vapoursynth_plugins_warpsharpsupport
	vapoursynth_plugins_zip
	vapoursynth_plugins_znedi3
	vapoursynth_plugins_zsmooth
	vapoursynth_plugins_vivtc
	vapoursynth_plugins_vs-ccd
	vapoursynth_plugins_vs-dfttest2
	vapoursynth_plugins_vs-imwri
	vapoursynth_plugins_vs-jetpack
	vapoursynth_plugins_vs-nlm-ispc
	vapoursynth_plugins_vs-noise
	vapoursynth_plugins_vs-ocr
	vapoursynth_plugins_vs-placebo
	vapoursynth_plugins_vs-removegrain
	vapoursynth_plugins_vsfpng
	vapoursynth_plugins_vsutil
"

RDEPEND="
	vapoursynth_plugins_acsuite? ( media-plugins/acsuite )
	vapoursynth_plugins_adaptivegrain? ( media-plugins/adaptivegrain )
	vapoursynth_plugins_audiocutter? ( media-plugins/audiocutter )
	vapoursynth_plugins_bestsource? ( media-plugins/bestsource )
	vapoursynth_plugins_descratch? ( media-plugins/descratch )
	vapoursynth_plugins_dmetrics? ( media-plugins/dmetrics )
	vapoursynth_plugins_hysteresis? ( media-plugins/hysteresis )
	vapoursynth_plugins_manipulate-motion-vectors? ( media-plugins/manipulate-motion-vectors )
	vapoursynth_plugins_ocsuite? ( media-plugins/ocsuite )
	vapoursynth_plugins_rawz? ( media-plugins/rawz )
	vapoursynth_plugins_subtext? ( media-plugins/subtext )
	vapoursynth_plugins_adjust? ( media-plugins/vapoursynth-adjust )
	vapoursynth_plugins_akarin? ( media-plugins/vapoursynth-akarin )
	vapoursynth_plugins_awarp? ( media-plugins/vapoursynth-awarp )
	vapoursynth_plugins_bifrost? ( media-plugins/vapoursynth-bifrost )
	vapoursynth_plugins_bm3d? ( media-plugins/vapoursynth-bm3d )
	vapoursynth_plugins_bwdif? ( media-plugins/vapoursynth-bwdif )
	vapoursynth_plugins_cmedian? ( media-plugins/vapoursynth-cmedian )
	vapoursynth_plugins_colorbars? ( media-plugins/vapoursynth-colorbars )
	vapoursynth_plugins_d2vsource? ( media-plugins/vapoursynth-d2vsource )
	vapoursynth_plugins_dctfilter? ( media-plugins/vapoursynth-dctfilter )
	vapoursynth_plugins_deblock? ( media-plugins/vapoursynth-deblock )
	vapoursynth_plugins_dedot? ( media-plugins/vapoursynth-dedot )
	vapoursynth_plugins_descale? ( media-plugins/vapoursynth-descale )
	vapoursynth_plugins_dotkill? ( media-plugins/vapoursynth-dotkill )
	vapoursynth_plugins_edgefixer? ( media-plugins/vapoursynth-edgefixer )
	vapoursynth_plugins_edgemasks? ( media-plugins/vapoursynth-edgemasks )
	vapoursynth_plugins_eedi3? ( media-plugins/vapoursynth-eedi3 )
	vapoursynth_plugins_ffmpegsource? ( media-plugins/vapoursynth-ffmpegsource )
	vapoursynth_plugins_fft3dfilter? ( media-plugins/vapoursynth-fft3dfilter )
	vapoursynth_plugins_fieldhint? ( media-plugins/vapoursynth-fieldhint )
	vapoursynth_plugins_fillborders? ( media-plugins/vapoursynth-fillborders )
	vapoursynth_plugins_finesharp? ( media-plugins/vapoursynth-finesharp )
	vapoursynth_plugins_fmtconv? ( media-plugins/vapoursynth-fmtconv )
	vapoursynth_plugins_histogram? ( media-plugins/vapoursynth-histogram )
	vapoursynth_plugins_hysteria? ( media-plugins/vapoursynth-hysteria )
	vapoursynth_plugins_iscombed? ( media-plugins/vapoursynth-iscombed )
	vapoursynth_plugins_knlmeanscl? ( media-plugins/vapoursynth-knlmeanscl )
	vapoursynth_plugins_miscfilters-obsolete? ( media-plugins/vapoursynth-miscfilters-obsolete )
	vapoursynth_plugins_mvsfunc? ( media-plugins/vapoursynth-mvsfunc )
	vapoursynth_plugins_mvtools? ( media-plugins/vapoursynth-mvtools )
	vapoursynth_plugins_readmpls? ( media-plugins/vapoursynth-readmpls )
	vapoursynth_plugins_resize2? ( media-plugins/vapoursynth-resize2 )
	vapoursynth_plugins_rife-ncnn-vulkan? ( media-plugins/vapoursynth-rife-ncnn-vulkan )
	vapoursynth_plugins_sangnom? ( media-plugins/vapoursynth-sangnom )
	vapoursynth_plugins_scxvid? ( media-plugins/vapoursynth-scxvid )
	vapoursynth_plugins_sneedif? ( media-plugins/vapoursynth-sneedif )
	vapoursynth_plugins_timecube? ( media-plugins/vapoursynth-timecube )
	vapoursynth_plugins_tivtc? ( media-plugins/vapoursynth-tivtc )
	vapoursynth_plugins_ttempsmooth? ( media-plugins/vapoursynth-ttempsmooth )
	vapoursynth_plugins_vcm? ( media-plugins/vapoursynth-vcm )
	vapoursynth_plugins_vmaf? ( media-plugins/vapoursynth-vmaf )
	vapoursynth_plugins_vs-maskdetail? ( media-plugins/vapoursynth-vs-maskdetail )
	vapoursynth_plugins_warpsharpsupport? ( media-plugins/vapoursynth-warpsharpsupport )
	vapoursynth_plugins_zip? ( media-plugins/vapoursynth-zip )
	vapoursynth_plugins_znedi3? ( media-plugins/vapoursynth-znedi3 )
	vapoursynth_plugins_zsmooth? ( media-plugins/vapoursynth-zsmooth )
	vapoursynth_plugins_vivtc? ( media-plugins/vivtc )
	vapoursynth_plugins_vs-ccd? ( media-plugins/vs-ccd )
	vapoursynth_plugins_vs-dfttest2? ( media-plugins/vs-dfttest2 )
	vapoursynth_plugins_vs-imwri? ( media-plugins/vs-imwri )
	vapoursynth_plugins_vs-jetpack? ( media-plugins/vs-jetpack )
	vapoursynth_plugins_vs-nlm-ispc? ( media-plugins/vs-nlm-ispc )
	vapoursynth_plugins_vs-noise? ( media-plugins/vs-noise )
	vapoursynth_plugins_vs-ocr? ( media-plugins/vs-ocr )
	vapoursynth_plugins_vs-placebo? ( media-plugins/vs-placebo )
	vapoursynth_plugins_vs-removegrain? ( media-plugins/vs-removegrain )
	vapoursynth_plugins_vsfpng? ( media-plugins/vsfpng )
	vapoursynth_plugins_vsutil? ( media-plugins/vsutil )
"
