#import <UIKit/UIKit.h>
@interface PLPlatterView : UIView
@property(nonatomic, strong, readwrite) UIView *backgroundView;
@end

static BOOL imageAdded = NO;
static BOOL blurAdded = NO;
static BOOL isEnabled = YES;
static BOOL isBlur = NO;
static UIImage *backgroundImage;