//
//  MyAlertViewController.m
//  minikit
//
//  Created by dongshangtong on 2019/7/31.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "MyAlertViewController.h"
#import "MNAlertView.h"
#import "Masonry.h"
@interface MyAlertViewController ()

@end

@implementation MyAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *hitBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:hitBtn1];
    
    [hitBtn1 addTarget:self action:@selector(styleOne) forControlEvents:UIControlEventTouchUpInside];
    hitBtn1.backgroundColor = [UIColor blueColor];
    [hitBtn1 setTitle:@"弹框1"forState:UIControlStateNormal];
    [hitBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(40);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(40);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    UIButton *hitBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:hitBtn2];
    
    [hitBtn2 addTarget:self action:@selector(styleTwo) forControlEvents:UIControlEventTouchUpInside];
    hitBtn2.backgroundColor = [UIColor blueColor];
    [hitBtn2 setTitle:@"弹框2"forState:UIControlStateNormal];
    [hitBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(40);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(180);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    
    UIButton *hitBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:hitBtn3];
    
    [hitBtn3 addTarget:self action:@selector(styleThree) forControlEvents:UIControlEventTouchUpInside];
    hitBtn3.backgroundColor = [UIColor blueColor];
    [hitBtn3 setTitle:@"弹框3"forState:UIControlStateNormal];
    [hitBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(120);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(40);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    
    UIButton *hitBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:hitBtn4];
    
    [hitBtn4 addTarget:self action:@selector(styleFour) forControlEvents:UIControlEventTouchUpInside];
    hitBtn4.backgroundColor = [UIColor blueColor];
    [hitBtn4 setTitle:@"弹框4"forState:UIControlStateNormal];
    [hitBtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(120);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(180);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    
    
    
    UIButton *hitBtn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:hitBtn5];
    
    [hitBtn5 addTarget:self action:@selector(styleFive) forControlEvents:UIControlEventTouchUpInside];
    hitBtn5.backgroundColor = [UIColor blueColor];
    [hitBtn5 setTitle:@"弹框5"forState:UIControlStateNormal];
    [hitBtn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(240);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(40);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    
    
    UIButton *hitBtn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:hitBtn6];
    
    [hitBtn6 addTarget:self action:@selector(styleSix) forControlEvents:UIControlEventTouchUpInside];
    hitBtn6.backgroundColor = [UIColor blueColor];
    [hitBtn6 setTitle:@"弹框6"forState:UIControlStateNormal];
    [hitBtn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(240);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(180);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    MNAlertView *alertView = [MNAlertView showActionSheetWithTitle:@"是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX"];
    
    [alertView addButtonWithTitle:@"退出" type:MNAlertViewButtonTypeCancel handler:^(MNAlertView *alertView) {
        
    }];
    
    [alertView addButtonWithTitle:@"确定" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        
    }];
    
    [alertView addButtonWithTitle:@"好的" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        
    }];
    
    [alertView show];
    
    
    [MNAlertView showAlertViewWithTitle:nil message:@"是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX是否退出XXX" cancelButtonTitle:@"取消" otherButtonTitles:@[@"好的", @"好的", @"好的"] handler:^(MNAlertView *alertView, NSInteger buttonIndex) {
        
    }];
}

- (void)styleOne {
    MNAlertView *alertView = [MNAlertView alertViewWithTitle:@"样式1" andMessage:@"~\(≧▽≦)/~啦啦啦"];
    alertView.isSupportRotating = YES;
    
    [alertView addButtonWithTitle:@"确定" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        NSLog(@"styleOne");
    }];
    
    [alertView show];
}

- (void)styleTwo {
    MNAlertView *alertView = [MNAlertView alertViewWithTitle:@"样式2" andMessage:@"~\(≧▽≦)/~啦啦啦"];
    alertView.isSupportRotating = YES;
    
    [alertView addButtonWithTitle:@"确定" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        NSLog(@"styleTwo 确定");
    }];
    
    [alertView addButtonWithTitle:@"取消" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        NSLog(@"styleTwo 取消");
    }];
    
    [alertView show];
}

- (void)styleThree {
    MNAlertView *alertView = [MNAlertView alertViewWithTitle:@"样式3" andMessage:@"~\(≧▽≦)/~啦啦啦"];
    alertView.buttonsListStyle = MNAlertViewButtonsListStyleRows;
    alertView.isSupportRotating = YES;
    
    [alertView addButtonWithTitle:@"确定" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        NSLog(@"styleThree 确定");
    }];
    
    [alertView addButtonWithTitle:@"取消" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        NSLog(@"styleThree 取消");
    }];
    
    [alertView show];
}

- (void)styleFour {
    MNAlertView *alertView = [MNAlertView alertViewWithTitle:@"样式4" andMessage:@"~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦"];
    alertView.isSupportRotating = YES;
    
    [alertView addButtonWithTitle:@"确定" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        NSLog(@"styleFour 确定");
    }];
    
    [alertView addButtonWithTitle:@"取消" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        NSLog(@"styleFour 取消");
    }];
    
    [alertView addButtonWithTitle:@"来呀" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        NSLog(@"styleFour 来呀");
    }];
    
    [alertView addButtonWithTitle:@"互相" type:MNAlertViewButtonTypeCancel handler:^(MNAlertView *alertView) {
        NSLog(@"styleFour 互相");
    }];
    
    [alertView addButtonWithTitle:@"伤害" type:MNAlertViewButtonTypeDestructive handler:^(MNAlertView *alertView) {
        NSLog(@"styleFour 伤害");
    }];
    
    [alertView show];
}

- (void)styleFive {
    MNAlertView *alertView = [MNAlertView alertViewWithTitle:@"样式5" andMessage:@"其他的自己写着玩吧~~~"];
    alertView.transitionStyle = MNAlertViewTransitionStyleDropDown;
    alertView.backgroundStyle = MNAlertViewBackgroundStyleGradient;
    alertView.isSupportRotating = YES;
    
    [alertView addButtonWithTitle:@"确定" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        NSLog(@"styleFive");
    }];
    
    [alertView show];
}

/**
 *  宝宝们, 别乱玩...
 */
- (void)styleSix {
    MNAlertView *alertView = [MNAlertView alertViewWithTitle:@"真的没了" andMessage:@"不骗你, 真的最后一个了"];
    alertView.transitionStyle = MNAlertViewTransitionStyleFade;
    alertView.isSupportRotating = YES;
    
    [alertView addButtonWithTitle:@"确定" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        NSLog(@"styleSix 1");
    }];
    
    [alertView show];
    
    
    MNAlertView *alertView1 = [MNAlertView alertViewWithTitle:@"最后一个" andMessage:@"点了就没了"];
    alertView1.transitionStyle = MNAlertViewTransitionStyleSlideFromTop;
    alertView1.isSupportRotating = YES;
    
    [alertView1 addButtonWithTitle:@"确定" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        NSLog(@"styleSix 2");
    }];
    
    [alertView1 show];
    
    
    MNAlertView *alertView2 = [MNAlertView alertViewWithTitle:@"没有惊喜" andMessage:@"哈哈, 骗你的, 没有惊喜"];
    alertView2.transitionStyle = MNAlertViewTransitionStyleSlideFromBottom;
    alertView2.isSupportRotating = YES;
    
    [alertView2 addButtonWithTitle:@"确定" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        NSLog(@"styleSix 3");
    }];
    
    [alertView2 show];
    
    
    MNAlertView *alertView3 = [MNAlertView alertViewWithTitle:@"惊喜往往在后面" andMessage:@"再次点击就告诉你"];
    alertView3.isSupportRotating = YES;
    alertView3.transitionStyle = MNAlertViewTransitionStyleBounce;
    alertView3.backgroundStyle = MNAlertViewBackgroundStyleGradient;
    
    [alertView3 addButtonWithTitle:@"确定" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        NSLog(@"styleSix 4");
    }];
    
    [alertView3 show];
    
    
    MNAlertView *alertView4 = [MNAlertView alertViewWithTitle:@"有个秘密告诉你" andMessage:@"确定之后会有意外惊喜"];
    alertView4.transitionStyle = MNAlertViewTransitionStyleDropDown;
    alertView4.backgroundStyle = MNAlertViewBackgroundStyleGradient;
    alertView4.isSupportRotating = YES;
    
    [alertView4 addButtonWithTitle:@"确定" type:MNAlertViewButtonTypeDefault handler:^(MNAlertView *alertView) {
        NSLog(@"styleSix 5");
    }];
    
    [alertView4 show];
}

@end
