#import <UIKit/UIKit.h>
@interface PLPlatterView : UIView
@property(nonatomic, strong, readwrite) UIView *backgroundView;
@end
@interface UIView ()
@property(assign, setter=_setCornerRadius:, nonatomic) double _cornerRadius;
@end
static BOOL imageAdded = NO;
static BOOL isEnabled = YES;
static BOOL isBlur = NO;
static UIImage *backgroundImage;