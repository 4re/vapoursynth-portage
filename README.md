# vapoursynth-portage
Unofficial portage tree with all vapoursynth related ebuilds

Usage
-----
To use this overlay, first clone this git repository to a place of your preference, and then update your ```/etc/portage/make.conf``` to make use of it:
```
PORTDIR_OVERLAY="/path/to/my/overlay/vapoursynth/"
```

There is a convenient set that will pull all vapoursynth plugins at once, also, you may like to use it to update everything, as most of them are 9999 git revisions only:
```
emerge @vapoursynth-plugins
```

This overlay also includes editors and a modified mpv ebuild with vapoursynth support enabled:
```
emerge vapoursyntheditor mpv
```
