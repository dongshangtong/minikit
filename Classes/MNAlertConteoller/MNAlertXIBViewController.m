//
//  MNAlertXIBViewController.m
//  minikit
//
//  Created by dongshangtong on 2019/10/14.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "MNAlertXIBViewController.h"
#import "MNAlertAnimationController.h"
@interface MNAlertXIBViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation MNAlertXIBViewController

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
    
    UIWindow * wind = [UIApplication sharedApplication].keyWindow;
    self.view.frame = wind.bounds;
//    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
         [self.view addSubview:self.contentView];
         _contentView.backgroundColor = [UIColor whiteColor];
    
    // self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    //    [self.view addSubview:self.contentView];
    //    _contentView.centerX = self.view.centerX;
    //    _contentView.centerY  = self.view.centerY;
    //    _contentView.size = CGSizeMake(160, 100);
    //    _contentView.backgroundColor = [UIColor whiteColor];
    //    _contentView.layer.cornerRadius = 3;
    
    
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
