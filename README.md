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

As per [here](https://forum.xda-developers.com/t/rooting-oneplus-nord-2-ce-lite.4500297/)
```
$ fastboot flash boot magisk_boot.img
$ fastboot flash --disable-verity --disable-verification vbmeta vbmeta.img
$ fastboot reboot
```
