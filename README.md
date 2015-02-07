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
There is a convenient set that will pull all vapoursynth plugins at once, also, you may like to use it to update everything, as most of them are 9999 git revisions only:
```
emerge @vapoursynth-plugins
```

This overlay also includes an editor and a modified mpv ebuild with vapoursynth support enabled:
```
emerge vapoursynth-editor mpv
```
