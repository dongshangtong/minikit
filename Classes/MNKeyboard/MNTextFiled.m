//
//  MNTextFiled.m
//  NewEra
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MNTextFiled.h"
#import "MNPayKeyBoard.h"
#import "MNIDCardBoard.h"
#import "MNBoardToolBar.h"
@interface MNTextFiled()

@property (nonatomic ,strong)MNIDCardBoard *mini_idCardBoard;
@property (nonatomic ,strong)MNPayKeyBoard *mini_PayKeyBord;
@property (nonatomic ,strong)MNBoardToolBar *mini_toolBar;
@property (nonatomic ,copy)NSString *currentString;

@end

@implementation MNTextFiled

-(instancetype)initWithFrame:(CGRect)frame showKeyBoardType:(MNBoardType)keyBoardType
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViewWithKeyBoardType:keyBoardType];
        self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 35)];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.currentString = @"";
        
        
    }
    return self;
}

/**
 根据不同的键盘类型添加个字的键盘View
 @param keyBoardType 键盘类型
 */
-(void)addViewWithKeyBoardType:(MNBoardType)keyBoardType
{
    switch (keyBoardType) {
        case MNIDCardType:
            self.inputAccessoryView =self.mini_toolBar;
            [self MNIDCardType:keyBoardType ];
            break;
        case MNPayType:
            self.inputAccessoryView =self.mini_toolBar;
            [self MNPayBoardType:keyBoardType];
            break;
        case MNBoardTypeNone:
            
            break;
        default:
            break;
    }
    __weak typeof(self)selfWeak  =self;
    [self.mini_toolBar setMini_BoardToolBarFinishedBtnBlock:^(NSString *currentString) {
         [selfWeak resignFirstResponder];
    }];
}



/**
 身份证的键盘
 */
-(void)MNIDCardType:(MNBoardType)keyBoardType
{
    self.inputView = self.mini_idCardBoard;
    __weak typeof(self)selfWeak  =self;
    [self.mini_idCardBoard setMini_IDCardBoardStringBlock:^(NSInteger keyBoardTag) {
        [selfWeak mini_ProcessingResultingString:keyBoardTag bsyBoard:selfWeak.mini_idCardBoard];
    }];
}



/**
 我自己支付键盘
 */
-(void)MNPayBoardType:(MNBoardType)keyBoardType
{
    self.inputView = self.mini_PayKeyBord;
    __weak typeof(self)selfWeak  =self;
    [self.mini_PayKeyBord setMini_PayBoardStringBlock:^(NSInteger keyBoardTag) {
        [selfWeak mini_ProcessingResultingString:keyBoardTag bsyBoard:selfWeak.mini_PayKeyBord];
    }];
}


/**
 字符串处理
 @param keyBoardTag 当前字符串
 */
-(void)mini_ProcessingResultingString:(NSInteger)keyBoardTag bsyBoard:(UIView *)bsyBoard
{
    if (keyBoardTag == 111) {
        if (![self.currentString isEqualToString:@""]) {
            self.currentString = [self.currentString substringToIndex:self.currentString.length-1];
        }
        self.text = self.currentString;
    }else if (keyBoardTag == 112){
        [self resignFirstResponder];
    }else if (keyBoardTag == 110){
        self.currentString = [self.currentString stringByAppendingString:@"."];
        self.text = self.currentString;
    }else{
        
        NSString * keyBoardString = [NSString stringWithFormat:@"%ld",keyBoardTag -100];
        self.currentString = [self.currentString stringByAppendingString:keyBoardString];
        self.text = self.currentString;
    }
}



/**
 键盘背景颜色
 */

-(void)setShowKeyBoardBackColor:(UIColor *)showKeyBoardBackColor
{
    _showKeyBoardBackColor = showKeyBoardBackColor;
    [self.mini_idCardBoard setShowKeyBoardBackColor:showKeyBoardBackColor];
    [self.mini_PayKeyBord setShowKeyBoardBackColor:showKeyBoardBackColor];

}

/**
 按键背景颜色
 */
-(void)setKeyBoardItemBackColor:(UIColor *)keyBoardItemBackColor
{
    _keyBoardItemBackColor = keyBoardItemBackColor;
    [self.mini_idCardBoard setShowKeyBoardItemBackColor:keyBoardItemBackColor];
    [self.mini_PayKeyBord setShowKeyBoardItemBackColor:keyBoardItemBackColor];

    
}

/**
 按键字体颜色
 */
-(void)setKeyBoardItemTextColor:(UIColor *)keyBoardItemTextColor
{
    _keyBoardItemTextColor = keyBoardItemTextColor;
    [self.mini_idCardBoard setShowKeyBoardItemTextColor:keyBoardItemTextColor];
    [self.mini_PayKeyBord setShowKeyBoardItemTextColor:keyBoardItemTextColor];
  
}
/**
 键盘ToolBar颜色
 */
-(void)setShowKeyBoardToolBarBackColor:(UIColor *)showKeyBoardToolBarBackColor
{
    _showKeyBoardToolBarBackColor = showKeyBoardToolBarBackColor;
    [self.mini_toolBar setShowKeyBoardToolBarBackColor:showKeyBoardToolBarBackColor];
}
/**
 键盘ToolBar 完成字体颜色
 */

-(void)setShowKeyBoardToolBarFinshinedBtnTitleColor:(UIColor *)showKeyBoardToolBarFinshinedBtnTitleColor
{
    _showKeyBoardToolBarFinshinedBtnTitleColor = showKeyBoardToolBarFinshinedBtnTitleColor;
    [self.mini_toolBar setFinshinedBtnTitleColor:showKeyBoardToolBarFinshinedBtnTitleColor];
}
/**
 键盘ToolBar title字体颜色
 */
-(void)setShowKeyBoardToolBarTitleColor:(UIColor *)showKeyBoardToolBarTitleColor
{
    _showKeyBoardToolBarTitleColor  =showKeyBoardToolBarTitleColor;
    [self.mini_toolBar setShowKeyBoardToolBarTitleColor:showKeyBoardToolBarTitleColor];
}

/**
 键盘ToolBar titleString
 */
-(void)setShowKeyBoardToolBarTitleString:(NSString *)showKeyBoardToolBarTitleString
{
    _showKeyBoardToolBarTitleString = showKeyBoardToolBarTitleString;
    [self.mini_toolBar setShowKeyBoardToolBarTitleString:showKeyBoardToolBarTitleString];
}


/// 确定按钮背景颜色
-(void)setKeyBoardSureItemBackColor:(UIColor *)keyBoardSureItemBackColor{
    _keyBoardSureItemBackColor = keyBoardSureItemBackColor;
    [self.mini_PayKeyBord setSureBoardItemBackColor:_keyBoardSureItemBackColor];
}

/// 确定按钮字体颜色
-(void)setKeyBoardSureItemTextColor:(UIColor *)keyBoardSureItemTextColor{
    _keyBoardSureItemTextColor = keyBoardSureItemTextColor;
    [self.mini_PayKeyBord setSureBoardItemTextColor:_keyBoardSureItemTextColor];
}


// 隐藏完成按钮

-(void)setFinishedBtnHidde:(BOOL)finishedBtnHidde{
    _finishedBtnHidde = finishedBtnHidde;
    [self.mini_toolBar setFinishedBtnHidde:_finishedBtnHidde];

}



-(MNIDCardBoard *)mini_idCardBoard{
    if (!_mini_idCardBoard) {
        _mini_idCardBoard = [[MNIDCardBoard alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 205) inputViewStyle:UIInputViewStyleDefault];
    }
    
    return _mini_idCardBoard;
}

/**
 我自己定义的键盘
 @return 返回键盘View
 */

-(MNPayKeyBoard *)mini_PayKeyBord{
    
    if (!_mini_PayKeyBord) {
        _mini_PayKeyBord = [[MNPayKeyBoard alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 283) inputViewStyle:UIInputViewStyleDefault];
    }
    return _mini_PayKeyBord;
}



/**
 创建ToolBarView
 @return 返回键盘View
 */

-(MNBoardToolBar *)mini_toolBar{
    
    if (!_mini_toolBar) {
        _mini_toolBar = [[MNBoardToolBar  alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    }
    return _mini_toolBar;
}



@end
