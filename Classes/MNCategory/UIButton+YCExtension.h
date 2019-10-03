//
//  UIButton+YCExtension.h
//  YCPublicDemo
//
//  Created by zhangji on 2017/5/23.
//  Copyright © 2017年 xinhuanwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};
@interface UIButton (YCExtension)

#pragma mark - 设置button的titleLabel和imageView的布局样式，及间距

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;


//快速创建按钮
+ (instancetype)yc_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor;
+ (instancetype)yc_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor backgroundImageName:(NSString *)backgroundImageName;
+ (instancetype)yc_imageButton:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName;

@end


@interface UIButton (YCEnlargeTouchArea)

#pragma mark -  扩大UIButton的点击范围


/**
 扩大UIButton的点击范围
 

 @param top left description
 @param left left description
 @param bottom bottom description
 @param right right description
 */
- (void)yc_enlargeEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;

@end


typedef void(^TouchBlock)(NSInteger tag);

@interface UIButton (YCActionHandler)

#pragma mark -  给UIButton增加点击事件，(UIControlEventTouchUpInside)模仿BlocksKit的写法，将点击事件封装进block中


/**
 给UIButton增加点击事件，(UIControlEventTouchUpInside)模仿BlocksKit的写法，将点击事件封装进block中
 
 @param controlEvent UIControlEvents
 @param touchHandler touchHandler description
 */
- (void)yc_addActionForControlEvent:(UIControlEvents)controlEvent Handler:(TouchBlock)touchHandler;


@end



//  防止Button被重复多次点击的几种方法


@interface UIButton (More)



//点击间隔
@property (nonatomic, assign) NSTimeInterval timeInterval;
//用于设置单个按钮不需要被hook (设为yes说明可以重复点击)
@property (nonatomic, assign) BOOL isIgnore;


@end
