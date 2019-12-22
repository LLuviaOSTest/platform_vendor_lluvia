# Copyright (C) 2019 LLuvia
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

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Include LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/lluvia/overlay/dictionaries

# Common overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/lluvia/overlay/common

# Lawnchair overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/lluvia/overlay/lawnchair

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/lluvia/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/lluvia/prebuilt/common/bin/50-base.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-base.sh \
    vendor/lluvia/prebuilt/common/bin/blacklist:$(TARGET_COPY_OUT_SYSTEM)/addon.d/blacklist

# Init banner
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/init.d/00banner:$(TARGET_COPY_OUT_SYSTEM)/etc/init.d/00banner

# Copy all LLuvia specific init rc files
$(foreach f,$(wildcard vendor/lluvia/prebuilt/common/etc/init/*.rc),\

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/lluvia/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/lluvia/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Copy all LLuvia specific init rc files
$(foreach f,$(wildcard vendor/lluvia/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))


# LatinIME gesture typing
ifeq ($(TARGET_ARCH),arm64)
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/lib64/libjni_latinime.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libjni_latinime.so \
    vendor/lluvia/prebuilt/common/lib64/libjni_latinimegoogle.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/lib/libjni_latinime.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libjni_latinime.so \
    vendor/lluvia/prebuilt/common/lib/libjni_latinimegoogle.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libjni_latinimegoogle.so
endif

# Sysconfigs
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/lluvia-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/lluvia-power-whitelist.xml \
    vendor/lluvia/prebuilt/common/etc/dialer_experience.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/dialer_experience.xml

# Permissions
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/permissions/privapp-permissions-elgoog.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-elgoog.xml
    vendor/lluvia/prebuilt/common/etc/sysconfig/yodita-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/lluvia-power-whitelist.xml \
    vendor/lluvia/prebuilt/common/etc/sysconfig/dialer_experience.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/dialer_experience.xml \
    vendor/lluvia/prebuilt/common/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

PRODUCT_DEXPREOPT_SPEED_APPS += \
    Settings \
    SystemUI

# Include LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/lluvia/overlay/dictionaries

# Common overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/lluvia/overlay/common

# Packages
include vendor/lluvia/config/packages.mk

# Version
include vendor/lluvia/config/version.mk

# Props
include vendor/lluvia/config/props.mk

# Telephony
include vendor/lluvia/config/telephony.mk
