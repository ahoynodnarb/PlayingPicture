THEOS_DEVICE_IP = localhost -p 2222

INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PlayingPicture

PlayingPicture_FILES = Tweak.x
PlayingPicture_CFLAGS = -fobjc-arc
PlayingPicture_LIBRARIES = imagepicker

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += playingpictureprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
