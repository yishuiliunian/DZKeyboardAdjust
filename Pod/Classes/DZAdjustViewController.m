//
//  DZAdjustViewController.m
//  Pods
//
//  Created by stonedong on 16/2/24.
//
//

#import "DZAdjustViewController.h"

@implementation DZAdjustViewController

- (instancetype) initWithRootViewController:(UIViewController *)viewController
{
    self = [self initWithNibName:nil bundle:nil];
    if (!self) {
        return self;
    }
    _rootViewController = viewController;
    return self;
}

- (void) loadContentView
{
    [_rootViewController willMoveToParentViewController:self];
    [self addChildViewController:_rootViewController];
    self.contentView = _rootViewController.view;
    [_rootViewController didMoveToParentViewController:self];
}

@end
