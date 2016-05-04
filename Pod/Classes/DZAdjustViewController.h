//
//  DZAdjustViewController.h
//  Pods
//
//  Created by stonedong on 16/2/24.
//
//

#import <Foundation/Foundation.h>
#import "DZKeyboardAdjustViewController.h"
@interface DZAdjustViewController : DZKeyboardAdjustViewController
@property (nonatomic, strong, readonly) UIViewController* rootViewController;

- (instancetype) initWithRootViewController:(UIViewController*)viewController;
@end
