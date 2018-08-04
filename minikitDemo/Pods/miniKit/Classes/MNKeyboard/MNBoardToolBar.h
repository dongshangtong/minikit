//
//  MNBoardToolBar.h
//  NewEra
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNBoardToolBar : UIView

@property (nonatomic ,strong)UILabel *IDCardBoardTitle;
@property (nonatomic ,strong)UIButton *finishedBtn;
@property (nonatomic ,strong)UIButton *cannalBtn;


@property (nonatomic ,copy)void(^mini_BoardToolBarFinishedBtnBlock)(NSString *currentString);
/**
 键盘ToolBar 完成字体颜色
 @param finshinedBtnTitleColor 完成字体颜色
 */
-(void)setFinshinedBtnTitleColor:(UIColor *)finshinedBtnTitleColor;

/**
 键盘ToolBar颜色
 @param showKeyBoardToolBarBackColor  键盘ToolBar颜色
 */
-(void)setShowKeyBoardToolBarBackColor:(UIColor *)showKeyBoardToolBarBackColor;

/**
 键盘ToolBar title字体颜色
 @param showKeyBoardToolBarTitleColor   title字体颜色
 */
-(void)setShowKeyBoardToolBarTitleColor:(UIColor *)showKeyBoardToolBarTitleColor;

/**
 键盘ToolBar titleString
 @param showKeyBoardToolBarTitleString   titleString
 */
-(void)setShowKeyBoardToolBarTitleString:(NSString *)showKeyBoardToolBarTitleString;


//隐藏完成按钮
-(void)setFinishedBtnHidde:(BOOL) hidde;

@end
