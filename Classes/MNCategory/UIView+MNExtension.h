//
//  UIView+MNExtension.h
//  minikit
//
//  Created by dongshangtong on 2019/7/31.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MNAnimationType) {
    MNAnimationOpen, // 动画开启
    MNAnimationClose // 动画关闭
};


NS_ASSUME_NONNULL_BEGIN

@interface UIView (MNExtension)

#pragma mark - 快速设置控件的frame
@property (nonatomic, assign) CGFloat mn_x;
@property (nonatomic, assign) CGFloat mn_y;
@property (nonatomic, assign) CGFloat mn_centerX;
@property (nonatomic, assign) CGFloat mn_centerY;
@property (nonatomic, assign) CGFloat mn_width;
@property (nonatomic, assign) CGFloat mn_height;
@property (nonatomic, assign) CGPoint mn_origin;
@property (nonatomic, assign) CGSize  mn_size;
@property (nonatomic, assign) CGFloat mn_right;
@property (nonatomic, assign) CGFloat mn_bottom;


#pragma mark - 视图相关
/**
 *  移除全部的子视图
 */
- (void)mn_removeAllSubviews;

#pragma mark - 动画相关
/**
 *  在某个点添加动画
 *
 *  @param point 动画开始的点
 */
- (instancetype)mn_addAnimationAtPoint:(CGPoint)point;

/**
 *  在某个点添加动画
 *
 *  @param point 动画开始的点
 *  @param type  动画的类型
 *  @param animationColor 动画的颜色
 */
- (instancetype)mn_addAnimationAtPoint:(CGPoint)point WithType:(MNAnimationType)type withColor:(UIColor *)animationColor;

/**
 *  在某个点添加动画
 *
 *  @param point 动画开始的点
 *  @param type  动画的类型
 *  @param animationColor 动画的颜色
 *  @param completion 动画结束后的代码快
 */
- (instancetype)mn_addAnimationAtPoint:(CGPoint)point WithType:(MNAnimationType)type withColor:(UIColor *)animationColor completion:(void (^)(BOOL finished))completion;

/**
 *  在某个点添加动画
 *
 *  @param point      动画开始的点
 *  @param duration   动画时间
 *  @param type       动画的类型
 *  @param animationColor 动画的颜色
 *  @param completion 动画结束后的代码快
 */
- (instancetype)mn_addAnimationAtPoint:(CGPoint)point WithDuration:(NSTimeInterval)duration WithType:(MNAnimationType) type withColor:(UIColor *)animationColor completion:(void (^)(BOOL finished))completion;


#pragma UIView变成UIImage
/**
 视图转成图片
 
 @return 返回图片
 */
- (UIImage *)mn_convertViewToImage;

/**
 视图裁剪成图片
 
 @return 返回图片
 */
- (UIImage *)mn_snapsHotView;

/**
 视图转成图片
 
 @param view 视图
 @return 返回图片
 */
+ (UIImage *)mn_convertViewToImage:(UIView *)view;

/**
 视图裁剪成图片
 
 @param view 视图
 @return 返回图片
 */
+ (UIImage *)mn_snapsHotView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
