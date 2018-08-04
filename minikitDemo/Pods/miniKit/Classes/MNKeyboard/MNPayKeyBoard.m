//
//  MNPayKeyBoard.m
//  NewEra
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MNPayKeyBoard.h"
#import "Masonry.h"
static NSString *const  defalutText = @"服务多支付安全输入";

@interface MNPayKeyBoard()
@property (nonatomic ,strong)NSMutableArray *array;
@property (nonatomic ,copy)NSString *pointString;

@property (nonatomic ,strong) UIView *rightView;

@property (nonatomic ,strong)  UIView *leftView;

@property (nonatomic ,strong)  UIView *topView;

@property (nonatomic ,strong)  UIView *bottomView;

@property (nonatomic,strong)  UIButton *sureBtn ;
@property (nonatomic,strong)  UIButton *deleteBtn ;


@end

@implementation MNPayKeyBoard


-(instancetype)initWithFrame:(CGRect)frame inputViewStyle:(UIInputViewStyle)inputViewStyle
{
    self = [super initWithFrame:frame inputViewStyle:inputViewStyle];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.pointString = @"";
        [self creatUIForMNPayBoard];
    }
    return self;
}

-(void)creatUIForMNPayBoard
{
    
    __weak typeof(self)weakSelf = self;
    //键盘间隙1；
    CGFloat W = ([UIScreen mainScreen].bounds.size.width-3)/4;
    CGFloat H = 70;
    
    
    UIView *rightView = [[UIView alloc]init];
    _rightView = rightView;
    [self addSubview:_rightView];
    [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(weakSelf);
        make.width.mas_equalTo(W);
        make.height.mas_equalTo(H*4 +3);
    }];
    _rightView.backgroundColor = [UIColor clearColor];
    
    UIButton *deleteBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [_rightView addSubview:deleteBtn];
    deleteBtn.tag = 111;
    _deleteBtn = deleteBtn;
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(weakSelf.rightView);
        make.height.mas_equalTo(2*H -20 + 2);
        make.width.mas_equalTo(W);
    }];
    deleteBtn.backgroundColor = [UIColor whiteColor];
    [deleteBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [deleteBtn  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(KeyBoardItemActionClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sureBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [_rightView addSubview:sureBtn];
    sureBtn.tag = 112;
    _sureBtn = sureBtn;
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.deleteBtn.mas_bottom).mas_offset(1);
        make.right.mas_equalTo(weakSelf.rightView.mas_right);
        make.height.mas_equalTo(2*H +20);
        make.width.mas_equalTo(W);
        make.bottom.mas_equalTo(weakSelf.rightView.mas_bottom).priority(UILayoutPriorityDefaultHigh);
    }];
    sureBtn.backgroundColor = [UIColor whiteColor];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:38];
    [sureBtn  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(KeyBoardItemActionClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *leftView = [[UIView alloc]init];
    _leftView = leftView;
    [self addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf.rightView.mas_left).mas_offset(-1);
    }];
    leftView.backgroundColor = [UIColor clearColor];
    
    
    UIView *bottomView = [[UIView alloc]init];
    _bottomView = bottomView;
    [leftView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.leftView);
        make.height.mas_equalTo(H);
    }];
    _bottomView.backgroundColor = [UIColor clearColor];
    
    
    
    // 0字符
    UIButton *zeroBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [_bottomView addSubview:zeroBtn];
    zeroBtn.tag = 100;
    [zeroBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(weakSelf.bottomView);
    }];
    zeroBtn.backgroundColor = [UIColor whiteColor];
    [zeroBtn setTitle:@"0" forState:UIControlStateNormal];
    zeroBtn.titleLabel.font = [UIFont systemFontOfSize:40];
    [zeroBtn  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zeroBtn addTarget:self action:@selector(KeyBoardItemActionClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 点号
    UIButton *dotBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [_bottomView addSubview:dotBtn];
    dotBtn.tag = 110;
    [dotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(weakSelf.bottomView);
        make.left.mas_equalTo(zeroBtn.mas_right).mas_offset(1);
        make.width.mas_equalTo(zeroBtn.mas_width);
    }];
    dotBtn.backgroundColor = [UIColor whiteColor];
    [dotBtn setTitle:@"." forState:UIControlStateNormal];
    dotBtn.titleLabel.font = [UIFont systemFontOfSize:40];
    [dotBtn  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dotBtn addTarget:self action:@selector(KeyBoardItemActionClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIView *topView = [[UIView alloc]init];
    _topView = topView;
    [_leftView addSubview:topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf.leftView);
        make.bottom.mas_equalTo(weakSelf.bottomView.mas_top).mas_offset(-1);
    }];
    _topView.backgroundColor = [UIColor clearColor];
    
    
    for (int i = 0; i  <9; i++) {
        UIButton *button  = [UIButton buttonWithType: UIButtonTypeCustom];
        [_topView addSubview:button];
        button.tag = 100+ i+ 1;
        [button setTitle:[NSString stringWithFormat:@"%d",i+ 1] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:40];
        [button  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake((W + 1) * (i%3), (H + 1) *(i/3), W, H);
        [button addTarget:self action:@selector(KeyBoardItemActionClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
}

-(void)KeyBoardItemActionClick:(UIButton *)finishedBtn
{
    
    if (self.mini_PayBoardStringBlock) {
        self.mini_PayBoardStringBlock(finishedBtn.tag);
    }
}
/**
 键盘背景颜色
 @param showKeyBoardBackColor   键盘背景颜色
 */
-(void)setShowKeyBoardBackColor:(UIColor *)showKeyBoardBackColor
{
    self.backgroundColor = showKeyBoardBackColor?showKeyBoardBackColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
}

/**
 按键背景颜色
 @param keyBoardItemBackColor    按键背景颜色
 */
-(void)setShowKeyBoardItemBackColor:(UIColor *)keyBoardItemBackColor
{
    keyBoardItemBackColor = keyBoardItemBackColor?keyBoardItemBackColor:[UIColor whiteColor];
    for (UIButton *btn in self.topView.subviews) {
        btn.backgroundColor = keyBoardItemBackColor;
        
    }
    
    for (UIButton *btn in self.rightView.subviews) {
         btn.backgroundColor = keyBoardItemBackColor;
    }
    
    for (UIButton *btn in self.bottomView.subviews) {
        btn.backgroundColor = keyBoardItemBackColor;
    }
    
}
/**
 按键字体颜色
 @param keyBoardItemTextColor    按键字体颜色
 */
-(void)setShowKeyBoardItemTextColor:(UIColor *)keyBoardItemTextColor
{
    keyBoardItemTextColor = keyBoardItemTextColor?keyBoardItemTextColor:[UIColor blackColor];
    for (UIButton *btn in self.topView.subviews) {
            [btn setTitleColor:keyBoardItemTextColor forState:UIControlStateNormal];
    }
    
    for (UIButton *btn in self.rightView.subviews) {
        [btn setTitleColor:keyBoardItemTextColor forState:UIControlStateNormal];
    }
    
    for (UIButton *btn in self.bottomView.subviews) {
        [btn setTitleColor:keyBoardItemTextColor forState:UIControlStateNormal];
    }
    
    
}

// 确认按的背景颜色
-(void)setSureBoardItemBackColor:(UIColor *)keyBoardItemBackColor{
    
    _sureBtn.backgroundColor = keyBoardItemBackColor;
}

// 确认按的字体颜色
-(void)setSureBoardItemTextColor:(UIColor *)keyBoardItemTextColor{
    
    [_sureBtn setTitleColor:keyBoardItemTextColor forState:UIControlStateNormal];
}



-(NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray arrayWithObjects:@"1",@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",  nil];
    }
    return _array;
}

@end
