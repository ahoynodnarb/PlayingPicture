#import "PlayingPicture.h"

static void refreshPrefs() {
	NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"com.popsicletreehouse.playingpictureprefs"];
	isEnabled = [bundleDefaults objectForKey:@"isEnabled"] ? [[bundleDefaults objectForKey:@"isEnabled"]boolValue] : YES;
	backgroundImage = [[UIImage alloc] initWithData:[bundleDefaults valueForKey:@"backgroundImage"]];
	isBlur = [bundleDefaults objectForKey:@"isBlur"] ? [[bundleDefaults objectForKey:@"isBlur"]boolValue] : NO;
}

static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    refreshPrefs();
}

%hook PLPlatterView
-(void)didMoveToWindow {
	%orig;
	if(isEnabled) {
		UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
		backgroundImageView.frame = self.backgroundView.bounds;
		[backgroundImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
		[backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
		[backgroundImageView setClipsToBounds:YES];
		[self.backgroundView addSubview: backgroundImageView];
		if(isBlur) {
			UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
			UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
			blurEffectView.frame = self.backgroundView.bounds;
			blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			blurEffectView.alpha = 0.93f;
			[self.backgroundView addSubview:blurEffectView];
		}
	}
}
%end

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR("com.popsicletreehouse.playingpicture.prefschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	refreshPrefs();
}