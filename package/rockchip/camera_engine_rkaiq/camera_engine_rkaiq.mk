################################################################################
#
# Rockchip Camera Engine RKaiq For Linux
#
################################################################################

ifeq ($(BR2_PACKAGE_CAMERA_ENGINE_RKAIQ), y)
CAMERA_ENGINE_RKAIQ_VERSION = 1.0
CAMERA_ENGINE_RKAIQ_SITE = $(TOPDIR)/../external/camera_engine_rkaiq
CAMERA_ENGINE_RKAIQ_SITE_METHOD = local
CAMERA_ENGINE_RKAIQ_INSTALL_STAGING = YES

CAMERA_ENGINE_RKAIQ_LICENSE = Apache V2.0
CAMERA_ENGINE_RKAIQ_LICENSE_FILES = NOTICE

CAMERA_ENGINE_RKAIQ_TARGET_INSTALL_DIR = $(TARGET_DIR)
CAMERA_ENGINE_RKAIQ_STAGING_INSTALL_DIR = $(STAGING_DIR)

ifeq ($(BR2_PACKAGE_RK_OEM), y)
CAMERA_ENGINE_RKAIQ_INSTALL_TARGET_OPTS = DESTDIR=$(BR2_PACKAGE_RK_OEM_INSTALL_TARGET_DIR) install/fast
CAMERA_ENGINE_RKAIQ_DEPENDENCIES += rk_oem
CAMERA_ENGINE_RKAIQ_TARGET_INSTALL_DIR = $(BR2_PACKAGE_RK_OEM_INSTALL_TARGET_DIR)
CAMERA_ENGINE_RKAIQ_STAGING_INSTALL_DIR = $(STAGING_DIR)/oem
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_CAMERA_ENGINE_RKAIQ_IQFILE)),)
CAMERA_ENGINE_RKAIQ_IQFILE = $(call qstrip,$(BR2_PACKAGE_CAMERA_ENGINE_RKAIQ_IQFILE))
else
CAMERA_ENGINE_RKAIQ_IQFILE = *.xml
endif

define CAMERA_ENGINE_RKAIQ_INSTALL_STAGING_CMDS
	mkdir -p $(CAMERA_ENGINE_RKAIQ_STAGING_INSTALL_DIR)/usr/lib
	$(INSTALL) -D -m 644 $(@D)/all_lib/Release/librkaiq.so $(CAMERA_ENGINE_RKAIQ_STAGING_INSTALL_DIR)/usr/lib/
endef

define CAMERA_ENGINE_RKAIQ_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/etc/iqfiles
	mkdir -p $(CAMERA_ENGINE_RKAIQ_TARGET_INSTALL_DIR)/usr/lib/
	mkdir -p $(CAMERA_ENGINE_RKAIQ_TARGET_INSTALL_DIR)/usr/bin/
	$(INSTALL) -D -m  644 $(@D)/all_lib/Release/librkaiq.so $(CAMERA_ENGINE_RKAIQ_TARGET_INSTALL_DIR)/usr/lib/
	$(INSTALL) -D -m  644 $(@D)/iqfiles/$(CAMERA_ENGINE_RKAIQ_IQFILE) $(TARGET_DIR)/etc/iqfiles/
endef

$(eval $(cmake-package))
endif
