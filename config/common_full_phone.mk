# Inherit common stuff
$(call inherit-product, vendor/lluvia/config/common.mk)

# World APN list
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

# SIM Toolkit
PRODUCT_PACKAGES += \
    Stk
