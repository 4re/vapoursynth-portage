# vapoursynth-portage
Unofficial portage tree with all vapoursynth related ebuilds

Install
-------
To make use of this overlay, first install layman (you need git support enabled on this ebuild):
```
# emerge app-portage/layman
```
Add layman at the end of your ```/etc/portage/make.conf```:
```
# echo "source /var/lib/layman/make.conf" >> /etc/portage/make.conf
```
Finally update layman's database and add vapoursynth's overlay to your system.
```
# layman -L
# layman -a vapoursynth
```

Usage
-----
First of all to activate default vapoursynth plugins:
```
# echo 'VAPOURSYNTH_PLUGINS="subtext eedi3 imagemagick morpho ocr removegrain vinverse vivtc"' >> /etc/portage/make.conf
```
There is a convenient set that will pull all vapoursynth plugins:
```
# emerge @vapoursynth-plugins
```
Or if you just want some plugins but not all of them:
```
# VAPOURSYNTH_PLUGINS="mvtools fmtconv" emerge vapoursynth-plugins-meta
```
If you are on stable use the provided file to keyword everything:
```
# cd /etc/portage/package.accept_keywords
# ln -s /var/lib/layman/vapoursynth/Documentation/package.accept_keywords/vapoursynth .
```
To make use of the live ebuilds:
```
# cd /etc/portage/package.accept_keywords
# ln -s /var/lib/layman/vapoursynth/Documentation/package.accept_keywords/vapoursynth-live .
```
In case you are using the live versions, you may want to utilize ```smart-live-rebuild``` to update the ebuilds as needed:
```
# emerge app-portage/smart-live-rebuild
# smart-live-rebuild
```
This overlay also includes an editor and a modified mpv ebuild with vapoursynth support enabled:
```
# emerge app-editors/vapoursynth-editor::vapoursynth media-video/mpv::vapoursynth
```

Troubleshooting
---------------
If you want to use python-3.5 you may need to add this to your `/etc/portage/package.use/use`:
```
*/*::vapoursynth python_single_target_python3_5
```
