//
//  MNBoardToolBar.m
//  NewEra
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MNBoardToolBar.h"

@interface MNBoardToolBar()

@end

@implementation MNBoardToolBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        [self addSubview:self.IDCardBoardTitle];
        [self addSubview:self.finishedBtn];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1)];
        line.backgroundColor  =[UIColor colorWithRed:153 green:153 blue:153 alpha:1];
        [self addSubview:line];
        [self.finishedBtn addTarget:self action:@selector(finishedBtnActionClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/**
 键盘ToolBar 完成字体颜色
 @param finshinedBtnTitleColor 完成字体颜色
 */
-(void)setFinshinedBtnTitleColor:(UIColor *)finshinedBtnTitleColor
{
    
    finshinedBtnTitleColor = finshinedBtnTitleColor?finshinedBtnTitleColor:[UIColor whiteColor];
    [self.finishedBtn setTitleColor:finshinedBtnTitleColor forState:UIControlStateNormal];
}

/**
 键盘ToolBar颜色
 @param showKeyBoardToolBarBackColor  键盘ToolBar颜色
 */
-(void)setShowKeyBoardToolBarBackColor:(UIColor *)showKeyBoardToolBarBackColor
{
    showKeyBoardToolBarBackColor = showKeyBoardToolBarBackColor?showKeyBoardToolBarBackColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    self.backgroundColor = showKeyBoardToolBarBackColor;
    
}

/**
 键盘ToolBar title字体颜色
 @param showKeyBoardToolBarTitleColor   title字体颜色
 */
-(void)setShowKeyBoardToolBarTitleColor:(UIColor *)showKeyBoardToolBarTitleColor
{
    showKeyBoardToolBarTitleColor = showKeyBoardToolBarTitleColor?showKeyBoardToolBarTitleColor:[UIColor grayColor];
    self.IDCardBoardTitle.textColor = showKeyBoardToolBarTitleColor;
}

/**
 键盘ToolBar titleString
 @param showKeyBoardToolBarTitleString   titleString
 */
-(void)setShowKeyBoardToolBarTitleString:(NSString *)showKeyBoardToolBarTitleString
{
    showKeyBoardToolBarTitleString = showKeyBoardToolBarTitleString?showKeyBoardToolBarTitleString:@"mini安全输入";
    self.IDCardBoardTitle.text = showKeyBoardToolBarTitleString;
}


-(void)setFinishedBtnHidde:(BOOL) hidde {
    
    _finishedBtn.hidden = hidde;
}



-(void)finishedBtnActionClick
{
    if (self.mini_BoardToolBarFinishedBtnBlock) {
        self.mini_BoardToolBarFinishedBtnBlock(self.finishedBtn.currentTitle);
    }
}
-(UILabel *)IDCardBoardTitle
{
    if (!_IDCardBoardTitle) {
        _IDCardBoardTitle = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-200)/2.0, 0, 200, 44.0)];
        _IDCardBoardTitle.textAlignment = NSTextAlignmentCenter;
        _IDCardBoardTitle.font = [UIFont systemFontOfSize:15];
        _IDCardBoardTitle.text =@"mini安全输入";
        _IDCardBoardTitle.textColor  =[UIColor lightTextColor];
        _IDCardBoardTitle.backgroundColor = [UIColor clearColor];
    }
    return _IDCardBoardTitle;
}

-(UIButton *)finishedBtn
{
    if (!_finishedBtn) {
        CGFloat FontSize = ([self isiPad]==YES)?20:18;
        _finishedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishedBtn.frame  =CGRectMake([UIScreen mainScreen].bounds.size.width-60, 0, 60, 44.0);
        _finishedBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize];
        [_finishedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishedBtn.backgroundColor = [UIColor clearColor];
        [_finishedBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    return _finishedBtn;
}

/**
 判断是iPad还是iPhone
 */
-(BOOL)isiPad
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        return YES;
    }else{
        return NO;
    }
}

@end
