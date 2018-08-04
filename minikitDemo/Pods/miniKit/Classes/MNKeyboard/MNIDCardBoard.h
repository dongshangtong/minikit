//
//  MNIDCardBoard.h
//  NewEra
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNIDCardBoard : UIInputView

@property (nonatomic ,copy)void(^mini_IDCardBoardStringBlock)(NSInteger keyBoardTag);

/**
 键盘背景颜色
 @param showKeyBoardBackColor   键盘背景颜色
 */
-(void)setShowKeyBoardBackColor:(UIColor *)showKeyBoardBackColor;

/**
 按键背景颜色
 @param keyBoardItemBackColor    按键背景颜色
 */
-(void)setShowKeyBoardItemBackColor:(UIColor *)keyBoardItemBackColor;


/**
 按键字体颜色
 @param keyBoardItemTextColor    按键字体颜色
 */
-(void)setShowKeyBoardItemTextColor:(UIColor *)keyBoardItemTextColor;
@end
