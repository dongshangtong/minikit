//
//  ViewController.m
//  minikit
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 dongshangtong. All rights reserved.
//

#import "ViewController.h"
#import "miniKit.h"
#import "Masonry.h"
#import "MyAlertViewController.h"
#import "TestAlertViewController.h"
#import "MNColorPickerViewController.h"
@interface ViewController ()
@property (nonatomic,strong)  MNTextFiled *textfield;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *hitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     [self.view addSubview:hitBtn];
    
    
    [hitBtn addTarget:self action:@selector(hitClick1:) forControlEvents:UIControlEventTouchUpInside];
    hitBtn.backgroundColor = [UIColor blueColor];
    [hitBtn setTitle:@"弹框k1"forState:UIControlStateNormal];
    [hitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(40);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(80);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
    }];
    
    
    
    UIButton *hitBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
     [self.view addSubview:hitBtn1];
    
    [hitBtn1 addTarget:self action:@selector(hitClick2:) forControlEvents:UIControlEventTouchUpInside];
    hitBtn1.backgroundColor = [UIColor blueColor];
    [hitBtn1 setTitle:@"弹框k2"forState:UIControlStateNormal];
    [hitBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(40);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(200);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
    }];
    
    
    UIButton *hitBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:hitBtn3];
       
       [hitBtn3 addTarget:self action:@selector(hitClick3:) forControlEvents:UIControlEventTouchUpInside];
       hitBtn3.backgroundColor = [UIColor blueColor];
       [hitBtn3 setTitle:@"圆环彩色板"forState:UIControlStateNormal];
       [hitBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.view.mas_top).mas_offset(84);
           make.left.mas_equalTo(self.view.mas_left).mas_offset(200);
           make.height.mas_equalTo(40);
           make.width.mas_equalTo(100);
       }];
    
    
    
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
    
    
    
    MNCycleImageView *cycleImageView = [[MNCycleImageView alloc]initWithFrame:CGRectMake(0, 300, UIScreen.mainScreen.bounds.size.width, 240)];
    cycleImageView.timeInterval = 2;
    cycleImageView.images = @[@"banar0",@"banar1"];
    [self.view addSubview:cycleImageView];
}


-(void)action{
    
    NSLog(@"KKKKKKKKKKK");
}


-(void)hitClick1:(UIButton *) btn {
    
    MyAlertViewController *VC = [[MyAlertViewController alloc]init];
    
    [self presentViewController:VC animated:YES completion:nil];
    
  
}

-(void)hitClick2:(UIButton *) btn {
    
    TestAlertViewController *VC = [[TestAlertViewController alloc]init];
    
    [self presentViewController:VC animated:YES completion:nil];
    
  
}


-(void)hitClick3:(UIButton *) btn {
    
    MNColorPickerViewController *VC = [[MNColorPickerViewController alloc]init];
    
    [self presentViewController:VC animated:YES completion:nil];
    
  
}


@end
