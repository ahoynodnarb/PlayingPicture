#import "PlayingPicture.h"

static void refreshPrefs() {
	NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"com.popsicletreehouse.playingpictureprefs"];
	isEnabled = [[bundleDefaults objectForKey:@"isEnabled"]boolValue];
	NSLog(@"playingpicture enabled: %d", isEnabled);
	backgroundImage = [[UIImage alloc] initWithData:[bundleDefaults valueForKey:@"backgroundImage"]];
	isBlur = [[bundleDefaults objectForKey:@"isBlur"]boolValue];
}

static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    refreshPrefs();
}

%hook PLPlatterView
-(void)layoutSubviews {
	%orig;
	//NSLog(@"playingpicture enabled: %d", isEnabled);
	if(isEnabled && !imageAdded) {
		UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
		backgroundImageView.frame = self.backgroundView.bounds;
		[backgroundImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
		[backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
		[backgroundImageView setClipsToBounds:YES];
		NSLog(@"playingpicture isDescendant: %d", [backgroundImageView isDescendantOfView:self.backgroundView]);
		[self.backgroundView addSubview: backgroundImageView];
		imageAdded = YES;
	}
	if(isBlur && !blurAdded) {
		UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
		UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
		blurEffectView.frame = self.backgroundView.bounds;
		blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		blurEffectView.alpha = 0.93f;
		[self.backgroundView addSubview:blurEffectView];
		blurAdded = YES;
	}
}
%end

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR("com.popsicletreehouse.playingpicture.prefschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	refreshPrefs();
}