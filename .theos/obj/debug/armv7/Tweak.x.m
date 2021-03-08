#line 1 "Tweak.x"
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


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class PLPlatterView; 
static void (*_logos_orig$_ungrouped$PLPlatterView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL PLPlatterView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$PLPlatterView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL PLPlatterView* _LOGOS_SELF_CONST, SEL); 

#line 15 "Tweak.x"

static void _logos_method$_ungrouped$PLPlatterView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL PLPlatterView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	_logos_orig$_ungrouped$PLPlatterView$layoutSubviews(self, _cmd);
	
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


static __attribute__((constructor)) void _logosLocalCtor_0f530806(int __unused argc, char __unused **argv, char __unused **envp) {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR("com.popsicletreehouse.playingpicture.prefschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	refreshPrefs();
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$PLPlatterView = objc_getClass("PLPlatterView"); { MSHookMessageEx(_logos_class$_ungrouped$PLPlatterView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$PLPlatterView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$PLPlatterView$layoutSubviews);}} }
#line 45 "Tweak.x"
