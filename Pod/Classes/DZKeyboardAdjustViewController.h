//
//  DZKeyboardAdjustViewController.h
//  Pods
//
//  Created by stonedong on 16/2/21.
//
//

#import <UIKit/UIKit.h>
#import <DZKeyboardManager/DZKeyboardManager.h>

@interface DZKeyboardAdjustViewController : UIViewController
@property (nonatomic, strong) UIView* contentView;
- (void) loadContentView;
- (BOOL) transiztionUseAnimation;
- (void) wllResponseToKeyboardChanged:(DZKeyboardTransition)transition;
- (void) didResponseToKeyboardChanged:(DZKeyboardTransition)transition;
@end
