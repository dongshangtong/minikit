//
//  MNTextFiled.h
//  NewEra
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MNBoardTypeNone,
    MNPhoneNumberType,
    MNIDCardType,
    MNPayType,
    MNPassWordType,
    
}MNBoardType;

@interface MNTextFiled : UITextField

/**
 重写init方法
 @param frame frame
 @param keyBoardType 键盘类型
 @return 返回自己
 */
-(instancetype)initWithFrame:(CGRect)frame showKeyBoardType:(MNBoardType)keyBoardType;

/**
 键盘背景颜色
 */
@property (nonatomic ,strong)UIColor *showKeyBoardBackColor;

/**
 按键背景颜色
 */
@property (nonatomic ,strong)UIColor *keyBoardItemBackColor;

/**
 按键字体颜色
 */
@property (nonatomic ,strong)UIColor *keyBoardItemTextColor;

/**
 键盘ToolBar颜色
 */
@property (nonatomic ,strong)UIColor *showKeyBoardToolBarBackColor;
/**
 键盘ToolBar 完成字体颜色
 */
@property (nonatomic ,strong)UIColor *showKeyBoardToolBarFinshinedBtnTitleColor;

/**
 键盘ToolBar title字体颜色
 */
@property (nonatomic ,strong)UIColor *showKeyBoardToolBarTitleColor;

/**
 键盘ToolBar titleString
 */
@property (nonatomic ,copy)NSString * showKeyBoardToolBarTitleString;


/**
 确认按钮背景颜色
 */
@property (nonatomic ,copy)UIColor *keyBoardSureItemBackColor;

/**
  确认按钮按键字体颜色
 */
@property (nonatomic ,copy)UIColor *keyBoardSureItemTextColor;

// 隐藏完成按钮
@property (nonatomic ,assign)BOOL finishedBtnHidde;


@end
