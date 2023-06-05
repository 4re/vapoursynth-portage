# vapoursynth-portage
Unofficial portage tree with all VapourSynth related ebuilds

Install
-------
The prefered way is using the eselect's repository module:
```
# emerge app-eselect/eselect-repository
# eselect repository add vapoursynth git https://github.com/4re/vapoursynth-portage
```

Usage
-----
The preferred way to manage vapoursynth plugins is through `VAPOURSYNTH_PLUGINS` variable in `/etc/portage/package.use/use`:
```
*/*::vapoursynth VAPOURSYNTH_PLUGINS: * -addgrain -ffmpegsource -morpho -ocr
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
If you want to use python-3.11 you may need to add this to your `/etc/portage/package.use/use`:
```
*/*::vapoursynth PYTHON_SINGLE_TARGET: -* python3_12
```
Be aware that not all ebuilds may be able to satisfy all dependencies.
