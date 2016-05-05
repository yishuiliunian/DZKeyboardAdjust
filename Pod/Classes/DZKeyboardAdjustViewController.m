//
//  DZKeyboardAdjustViewController.m
//  Pods
//
//  Created by stonedong on 16/2/21.
//
//

#import "DZKeyboardAdjustViewController.h"
#import "DZKeyboardManager.h"
@interface DZKeyboardAdjustViewController () <DZKeyboardChangedProtocol, UIGestureRecognizerDelegate>

@end

@implementation DZKeyboardAdjustViewController
{

    UISwipeGestureRecognizer* _swipeDown;
    UIView* _maskView;
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
    _pullDownToHiddenEnable = YES;
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
    
    UISwipeGestureRecognizer* panG = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(pullDownHanle:)];
    panG.direction = UISwipeGestureRecognizerDirectionDown;

    
    [_contentView addGestureRecognizer:panG];
    panG.enabled = _pullDownToHiddenEnable;
    _swipeDown = panG;
    _swipeDown.delegate = self;
    _maskView.userInteractionEnabled = YES;
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}
- (void) setPullDownToHiddenEnable:(BOOL)pullDownToHiddenEnable
{
    _pullDownToHiddenEnable = pullDownToHiddenEnable;
    _swipeDown.enabled = _pullDownToHiddenEnable;
}

- (void) pullDownHanle:(UIPanGestureRecognizer*)pan
{
    if (pan.state == UIGestureRecognizerStateRecognized) {
        for (UIView* sv  in _contentView.subviews) {
            [sv resignFirstResponder];
        }
    }
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


- (void) keyboardChanged:(DZKeyboardTransition)transition
{
    CGRect contentR;
    CGRect keyR;
    CGRect endFrame = transition.endFrame;
    endFrame = [[DZKeyboardManager shareManager] convertRect:endFrame toView:self.view];
    CGFloat height = MIN(CGRectGetHeight(self.view.frame), endFrame.origin.y);
    
    CGRectDivide(self.view.bounds, &keyR, &contentR, CGRectGetHeight(self.view.frame) - height , CGRectMaxYEdge);

    UIView* view = _contentView;
    [UIView animateWithDuration:transition.animationDuration animations:^{
        view.frame = contentR;
        [_contentView layoutSubviews];
    }];
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
