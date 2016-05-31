//
//  DZKeyboardAdjustViewController.m
//  Pods
//
//  Created by stonedong on 16/2/21.
//
//

#import "DZKeyboardAdjustViewController.h"
@interface DZKeyboardAdjustViewController () <DZKeyboardChangedProtocol, UIGestureRecognizerDelegate>

@end

@implementation DZKeyboardAdjustViewController
{

    BOOL* _firstLayout;
}
@synthesize contentView = _contentView;
- (void) dealloc
{
    [DZKeyboardShareManager removeObserver:self];
}

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) {
        return self;
    }
    _firstLayout =YES;
    return self;
}

- (UIView*) contentView
{
    if (!_contentView) {
        [self loadContentView];
    }
    return _contentView;
}
- (void) loadContentView
{
    _contentView = [UIView new];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self contentView];
    [self.view addSubview:_contentView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [DZKeyboardShareManager addObserver:self];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [DZKeyboardShareManager removeObserver:self];
}

- (void) wllResponseToKeyboardChanged:(DZKeyboardTransition)transition
{
    
}

- (void) didResponseToKeyboardChanged:(DZKeyboardTransition)transition
{
    
}
- (BOOL) transiztionUseAnimation
{
    return YES;
}
- (void) keyboardChanged:(DZKeyboardTransition)transition
{
    [self wllResponseToKeyboardChanged:transition];
    CGRect contentR;
    CGRect keyR;
    CGRect endFrame = transition.endFrame;
    endFrame = [[DZKeyboardManager shareManager] convertRect:endFrame toView:self.view];
    CGFloat height = MIN(CGRectGetHeight(self.view.frame), endFrame.origin.y);
    
    CGRectDivide(self.view.bounds, &keyR, &contentR, CGRectGetHeight(self.view.frame) - height , CGRectMaxYEdge);

    UIView* view = _contentView;
    void(^AnimationBlock)(void) = ^(void) {
        view.frame = contentR;
        [_contentView layoutSubviews];
    };
    
    void(^FinishBlock)(BOOL) = ^(BOOL finish) {
        [self didResponseToKeyboardChanged:transition];
    };
    if ([self transiztionUseAnimation]) {
        [UIView animateWithDuration:transition.animationDuration animations:AnimationBlock completion:FinishBlock];
    } else {
        AnimationBlock();
        FinishBlock(YES);
    }
}
- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (_firstLayout) {
        _contentView.frame = self.view.bounds;
        _firstLayout = NO;
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

@end
