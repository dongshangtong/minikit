//
//  ViewController.m
//  minikit
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 dongshangtong. All rights reserved.
//

#import "ViewController.h"
#import "miniKit.h"
#import "MNTextFiled.h"
#import "Masonry.h"
@interface ViewController ()
@property (nonatomic,strong)  MNTextFiled *textfield;


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
    
    
    MNTextFiled *textfield = [[MNTextFiled alloc]initWithFrame:CGRectZero showKeyBoardType:MNPayType];
    [self.view addSubview:textfield];
    textfield.placeholder = @"输入支付金额";
    textfield.font = [UIFont systemFontOfSize:32];
    textfield.textAlignment = NSTextAlignmentCenter;
    _textfield = textfield;
    _textfield.showKeyBoardBackColor = [UIColor lightGrayColor];
    _textfield.showKeyBoardToolBarTitleString= @"服务多安全支付";
    _textfield.showKeyBoardToolBarBackColor = [UIColor grayColor];
    _textfield.showKeyBoardToolBarTitleColor = [UIColor greenColor];
    _textfield.keyBoardSureItemBackColor = [UIColor orangeColor];
    _textfield.keyBoardSureItemTextColor = [UIColor whiteColor];
    _textfield.finishedBtnHidde = YES;
    [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(200);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.height.mas_equalTo(50);
    }];
    textfield.backgroundColor = [UIColor yellowColor];
}


-(void)action{
    
    NSLog(@"KKKKKKKKKKK");
}


@end
