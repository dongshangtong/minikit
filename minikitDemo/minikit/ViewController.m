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

    
}


-(void)action{
    
    NSLog(@"KKKKKKKKKKK");
}


@end
