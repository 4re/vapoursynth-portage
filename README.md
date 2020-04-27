# vapoursynth-portage
Unofficial portage tree with all vapoursynth related ebuilds

Install
-------
To make use of this overlay, first install layman (you need git support enabled on this ebuild):
```
# emerge app-portage/layman
```
Update layman's database and add vapoursynth's overlay to your system.
```
# layman -L
# layman -a vapoursynth
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
If you want to use python-3.8 you may need to add this to your `/etc/portage/package.use/use`:
```
*/*::vapoursynth PYTHON_SINGLE_TARGET: -* python3_8
```
