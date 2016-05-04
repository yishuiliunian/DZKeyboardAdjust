//
//  DZKeyboardAdjustViewController.h
//  Pods
//
//  Created by stonedong on 16/2/21.
//
//

#import <UIKit/UIKit.h>

@interface DZKeyboardAdjustViewController : UIViewController
@property (nonatomic, strong) UIView* contentView;
@property (nonatomic, assign) BOOL pullDownToHiddenEnable;
- (void) loadContentView;
@end
