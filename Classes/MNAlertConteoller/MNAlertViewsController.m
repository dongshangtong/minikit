//
//  MNAlertViewController.m
//  minikit
//
//  Created by dongshangtong on 2019/10/14.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "MNAlertViewsController.h"
#import "MNAlertAnimationController.h"

@interface MNAlertViewsController ()<UIViewControllerTransitioningDelegate>

@end

@implementation MNAlertViewsController

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
    }
    return _contentView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:self.contentView];
    _contentView.mn_centerX = self.view.mn_centerX;
    _contentView.mn_centerY  = self.view.mn_centerY;
    _contentView.mn_size = CGSizeMake(200, 100);
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.cornerRadius = 3;

   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[MNAlertAnimationController alloc]init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[MNAlertAnimationController alloc]init];
    
}

@end
