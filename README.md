# CPH2409
CPH2409 OnePlus Nord CE 2 Lite 5G

[Device info @gsmarena](https://www.gsmarena.com/oneplus_nord_ce_2_lite_5g-11344.php)

## Unlock
NB: all the user data is wiped during this procerure
```
$ adb reboot bootloader
$ fastboot flashing unlock
```

## Root
* https://github.com/oxygen-updater/oxygen-updater/releases
* https://github.com/ssut/payload-dumper-go/releases
* https://github.com/topjohnwu/Magisk/releases

As per [here](https://forum.xda-developers.com/t/rooting-oneplus-nord-2-ce-lite.4500297/):

- On your phone, install [Oxygen Updater](https://github.com/oxygen-updater/oxygen-updater/releases) apk,
launch it, in "Settings" make sure "Update method" is "Stable (full)" and download update. It's placed as
a zip file in sdcard root directory (/sdcard/)
- Download update zip from the phone to your PC:
```
$ adb shell 'ls /sdcard/*.zip'
/sdcard/12547fdf7dc849fabe93282f5c870992.zip
$ adb pull /sdcard/12547fdf7dc849fabe93282f5c870992.zip
...
```
- Get [payload-dumper-go](https://github.com/ssut/payload-dumper-go/releases) for your platform, in my case:
```
$ curl -s https://api.github.com/repos/ssut/payload-dumper-go/releases/latest | \
    jq -r '.assets[] | select( .name|test("linux_amd64")) | .browser_download_url'
https://github.com/ssut/payload-dumper-go/releases/download/1.2.2/payload-dumper-go_1.2.2_linux_amd64.tar.gz

$ curl -LJO https://github.com/ssut/payload-dumper-go/releases/download/1.2.2/payload-dumper-go_1.2.2_linux_amd64.tar.gz

$ tar -xf payload-dumper-go_1.2.2_linux_amd64.tar.gz payload-dumper-g
```
- Extract 'boot' and 'vbmeta' partition images from the update zip:
```
$ ./payload-dumper-go -o . -p boot,vbmeta 12547fdf7dc849fabe93282f5c870992.zip
...
```
- Install [Magisk](https://github.com/topjohnwu/Magisk/releases) apk on your phone.
- Upload extracted 'boot.img' to the phone:
```
$ adb push boot.img /sdcard/Download/
```
- Launch Magisk on your phone, click Magisk "Install", in "Method", choose "Select and Patch a File",
and press "LETS'S GO".
- Download resulting patched boot image from the phone to PC:
```
$ adb shell ls /sdcard/Download/magisk_patched*
/sdcard/Download/magisk_patched-25200_oQWxs.img
$ adb pull /sdcard/Download/magisk_patched-25200_oQWxs.img
...
```
- Flash resulting patched boot and vbmeta images (don't reboot in between):
```
$ adb reboot bootloader
$ fastboot flash boot magisk_patched-25200_oQWxs.img
$ fastboot flash vbmeta vbmeta.img
$ fastboot reboot
```
