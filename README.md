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
* https://oxygenos.oneplus.net/OPLocalUpdate_For_Android13.apk

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

$ tar -xf payload-dumper-go_1.2.2_linux_amd64.tar.gz payload-dumper-go
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
- Flash patched 'boot' image and then original 'vbmeta' image (don't reboot in between):
```
$ adb reboot bootloader
$ fastboot flash boot magisk_patched-25200_oQWxs.img
$ fastboot flash vbmeta vbmeta.img
$ fastboot reboot
```

### Surviving OTA update
If you perform automatic OTA update, you will loose your root permissions. You can allways regain ones repeating
the procedure above with the new update download. To prevent loosing root permissions during OTA update:
- Don't use automatic update
- Download full update zip with Oxygen Updater as per above.
- Instal [OP LocalUpdate](https://oxygenos.oneplus.net/OPLocalUpdate_For_Android13.apk) apk from OnePlus, it will apper
in "All Apps" as "System Update". Launch it, press gear, and select downloaded update zip file. Press "Install Now" to proceed.
- After it finishes - don't reboot yet.
- Launch Magisk, click Magisk "Install", in "Method", choose "Install to inactive Slot (After OTA)",
and press "LETS'S GO".
- Press "Reboot" in Magisk

