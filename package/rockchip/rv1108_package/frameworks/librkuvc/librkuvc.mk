LIBRKUVC_SITE = $(TOPDIR)/../frameworks/librkuvc
LIBRKUVC_SITE_METHOD = local
LIBRKUVC_INSTALL_STAGING = YES

# add dependencies
LIBRKUVC_DEPENDENCIES = sqlite

LIBRKUVC_CONF_OPTS = -DUVC_FORMAT_FILE=$(call qstrip,$(RV_TARGET_UVC_FORMAT_FILE))
ifeq ($(RV_TARGET_YUYV_AS_RAW),y)
    LIBRKUVC_CONF_OPTS += -DYUYV_AS_RAW=1
endif
ifeq ($(RV_TARGET_CONFIG_UVC_RGA),y)
    LIBRKUVC_CONF_OPTS += -DCONFIG_UVC_RGA=1
endif
ifeq ($(RV_TARGET_USE_ADB),y)
    LIBRKUVC_CONF_OPTS += -DUSE_ADB=1
endif

LIBRKUVC_CONF_OPTS += -DISP_TO_UVC_SEQ=$(RV_TARGET_ISP_TO_UVC_SEQ)
LIBRKUVC_CONF_OPTS += -DCIF_TO_UVC_SEQ=$(RV_TARGET_CIF_TO_UVC_SEQ)

$(eval $(cmake-package))
