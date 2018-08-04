//
//  ViewController.m
//  minikit
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 dongshangtong. All rights reserved.
//

#import "ViewController.h"
#import "miniKit.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    MNShineParams * params = [[MNShineParams alloc]init];
    
    params.bigShineColor =  [UIColor colorWithRed:153/255.0 green:152/255.0 blue:83/255.0 alpha:1.0];
    
    params.smallShineColor =  [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    
    MNShineButton *btn = [[MNShineButton alloc]initWithFrame:CGRectMake(100, 100, 60, 60) andparams:params];
    
    btn.fillColor = [UIColor colorWithRed:153/255.0 green:152/255.0 blue:83/255.0 alpha:1.0];
    btn.color = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
    [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
    MNValidationView * vali = [[MNValidationView alloc]initWithFrame:CGRectMake(180, 150, 100, 40) andCharCount:4 andLineCount:8];
    vali.validationCodeBlock = ^(NSString *code) {

        NSLog(@"验证码是:%@",code);

    };
    [self.view addSubview:vali];

    
}


-(void)action{
    
    NSLog(@"KKKKKKKKKKK");
}


@end
