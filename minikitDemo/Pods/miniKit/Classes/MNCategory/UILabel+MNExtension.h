//
//  UILabel+MNExtension.h
//  minikit
//
//  Created by dongshangtong on 2019/7/29.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (MNExtension)

#pragma mark -  设置UILabel Range范围的字体大小

/**
 设置UILabel Range范围的字体大小
 
 @param font font
 @param range range
 */
- (void)mn_setTextFont:(UIFont *)font atRange:(NSRange)range;

#pragma mark -  设置UILabel range范围的颜色


/**
 设置UILabel range范围的颜色
 
 @param color color
 @param range range
 */
- (void)mn_setTextColor:(UIColor *)color atRange:(NSRange)range;

#pragma mark -  设置UILabel range范围的行间距


/**
 设置UILabel range范围的行间距
 
 @param space space
 @param range range
 */
- (void)mn_setTextLineSpace:(float)space atRange:(NSRange)range;
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;
#pragma mark -  设置UILabel range范围的 字体和颜色


/**
 设置UILabel range范围的 字体和颜色
 
 @param font font
 @param color color
 @param range range
 */
- (void)mn_setTextFont:(UIFont *)font color:(UIColor *)color atRange:(NSRange)range;

#pragma mark -  设置UILabel range范围的attributes


/**
 设置UILabel range范围的attributes
 
 @param attributes attributes description
 @param range range description
 */
- (void)mn_setTextAttributes:(NSDictionary *)attributes atRange:(NSRange)range;


@end

NS_ASSUME_NONNULL_END
