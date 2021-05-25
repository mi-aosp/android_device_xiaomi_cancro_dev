#!/sbin/sh
#
# Copyright (C) 2016 CyanogenMod Project
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

mount /system

RAW_ID=`cat /sys/devices/system/soc/soc0/raw_id`

if [ $RAW_ID == 1974 ] || [ $RAW_ID == 1972 ]; then
    # Remove NFC
    rm -rf /system/system/app/NfcNci
    rm -rf /system/system/priv-app/Tag
    rm -rf /system/system/lib/*nfc*
    rm -rf /system/system/etc/*nfc*
    rm -rf /system/system/vendor/etc/permissions/*nfc*
    rm -rf /system/system/vendor/firmware/bcm2079x-b5_firmware.ncd
    rm -rf /system/system/vendor/firmware/bcm2079x-b5_pre_firmware.ncd
    rm -rf /system/system/vendor/lib/hw/android.hardware.nfc@1.0-impl-bcm.so
    # Use Mi4 audio configs
    rm -f /system/system/etc/acdbdata/MTP/MTP_Speaker_cal.acdb
    mv /system/system/etc/acdbdata/MTP/MTP_Speaker_cal_4.acdb /system/system/etc/acdbdata/MTP/MTP_Speaker_cal.acdb
    rm -f /system/system/vendor/etc/mixer_paths.xml
    mv /system/system/vendor/etc/mixer_paths_4.xml /system/system/vendor/etc/mixer_paths.xml
    # Mi4 libdirac config
    rm -f /system/system/vendor/etc/diracmobile.config
    mv /system/system/vendor/etc/diracmobile_4.config /system/system/vendor/etc/diracmobile.config
else
    # Remove Mi4 consumerir support
    rm -rf /system/system/vendor/etc/permissions/android.hardware.consumerir.xml
    rm -rf /system/system/vendor/bin/hw/android.hardware.ir@1.0-service.cancro
    rm -rf /system/system/vendor/etc/init/android.hardware.ir@1.0-service.cancro.rc
    # Remove Mi4 audio configs
    rm -rf /system/system/etc/acdbdata/MTP/MTP_Speaker_cal_4.acdb
    rm -f /system/system/vendor/etc/mixer_paths_4.xml
    # Remove Mi4 libdirac config
    rm -f /system/system/vendor/etc/diracmobile_4.config
fi

if [ $RAW_ID == 1978 ] || [ $RAW_ID == 1972 ] || [ $RAW_ID == 1974 ]; then
    # Supported device (Mi3w - 1978 or Mi4 - 1972, 1974)
    return 0
else
    # Unsupported device
    return 1
fi

umount /system
