//
//  MNMenuWindow.m
//  MNColorPickerView
//
//  Created by dongshangtong on 2019/10/19.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "MNMenuWindow.h"
#import "MNMenuView.h"

CGFloat const kMNColorPickerAnimationDuration = 1.0;
CGFloat const kMNColorPickerMenuAnimationDuration = 0.25;

@implementation MNMenuWindow

+ (instancetype)shareMenuWindow {
    static MNMenuWindow *menuWindow;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        menuWindow = [[MNMenuWindow alloc] initWithFrame:CGRectMake(0, 0, 70, 45)];
        menuWindow.windowLevel = UIWindowLevelAlert;
        menuWindow.hidden = YES;
        [menuWindow makeKeyAndVisible];
    });
    return menuWindow;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIViewController *rootVC = [[UIViewController alloc] init];
        rootVC.view.frame = self.bounds;
        rootVC.view.layer.anchorPoint = CGPointMake(0.5, 1.0);
        rootVC.view.backgroundColor = [UIColor clearColor];
        
        _menuView = [[MNMenuView alloc] init];
        [rootVC.view addSubview:_menuView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor whiteColor];
        [rootVC.view addSubview:_titleLabel];
        
        self.rootViewController = rootVC;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _menuView.frame = self.bounds;
    _titleLabel.frame = CGRectMake(0, 0, _menuView.frame.size.width, _menuView.frame.size.height * 7 / 9);
}

#pragma mark - getter

- (CGRect)frame {
    return self.rootViewController.view.frame;
}

#pragma mark -

- (void)updateWithFrame:(CGRect)frame {
    self.rootViewController.view.frame = frame;
}

+ (void)animationToShowMenu {
    [MNMenuWindow shareMenuWindow].hidden = NO;
    
    // animation to show
    CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
    scaleAnimation.keyPath = @"transform.scale";
    scaleAnimation.duration = kMNColorPickerMenuAnimationDuration;
    scaleAnimation.fromValue = @(0.0);
    scaleAnimation.toValue = @(1.0);
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    [[MNMenuWindow shareMenuWindow].rootViewController.view.layer addAnimation:scaleAnimation forKey:@"menuWindowScaleToShow"];
}

+ (void)animationToHiddenMenu {
    // animation to hidden
    CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
    scaleAnimation.keyPath = @"transform.scale";
    scaleAnimation.duration = kMNColorPickerMenuAnimationDuration;
    scaleAnimation.toValue = @(0.0);
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    [[MNMenuWindow shareMenuWindow].rootViewController.view.layer addAnimation:scaleAnimation forKey:@"menuWindowScaleToHidden"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kMNColorPickerMenuAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MNMenuWindow shareMenuWindow].hidden = YES;
    });
}

@end
