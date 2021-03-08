include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = PlayingPicturePrefs

PlayingPicturePrefs_FILES = PLPFRootListController.m
PlayingPicturePrefs_INSTALL_PATH = /Library/PreferenceBundles
PlayingPicturePrefs_FRAMEWORKS = UIKit
PlayingPicturePrefs_PRIVATE_FRAMEWORKS = Preferences
PlayingPicturePrefs_CFLAGS = -fobjc-arc
PlayingPicturePrefs_LIBRARIES = imagepicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/PlayingPicturePrefs.plist$(ECHO_END)
