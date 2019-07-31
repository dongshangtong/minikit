//
//  MNAlertView.h
//  minikit
//
//  Created by dongshangtong on 2019/7/31.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <UIKit/UIKit.h>


#ifdef __cplusplus
#define MN_EXTERN        extern "C" __attribute__((visibility ("default")))
#else
#define MN_EXTERN            extern __attribute__((visibility ("default")))
#endif


MN_EXTERN NSString * _Nullable const MNAlertViewWillShowNotification;
MN_EXTERN NSString * _Nullable const MNAlertViewDidShowNotification;
MN_EXTERN NSString * _Nullable const MNAlertViewWillDismissNotification;
MN_EXTERN NSString * _Nullable const MNAlertViewDidDismissNotification;

typedef NS_ENUM(NSInteger, MNAlertViewStyle) {
    MNAlertViewStyleAlert = 0,  // 默认
    MNAlertViewStyleActionSheet
};

typedef NS_ENUM(NSInteger, MNAlertViewButtonType) {
    MNAlertViewButtonTypeDefault = 0,   // 字体默认蓝色
    MNAlertViewButtonTypeDestructive,   // 字体默认红色
    MNAlertViewButtonTypeCancel         // 字体默认绿色
};

typedef NS_ENUM(NSInteger, MNAlertViewBackgroundStyle) {
    MNAlertViewBackgroundStyleSolid = 0,    // 平面的
    MNAlertViewBackgroundStyleGradient      // 聚光的
};

typedef NS_ENUM(NSInteger, MNAlertViewButtonsListStyle) {
    MNAlertViewButtonsListStyleNormal = 0,
    MNAlertViewButtonsListStyleRows // 每个按钮都是一行
};

typedef NS_ENUM(NSInteger, MNAlertViewTransitionStyle) {
    MNAlertViewTransitionStyleFade = 0,             // 渐退
    MNAlertViewTransitionStyleSlideFromTop,         // 从顶部滑入滑出
    MNAlertViewTransitionStyleSlideFromBottom,      // 从底部滑入滑出
    MNAlertViewTransitionStyleBounce,               // 弹窗效果
    MNAlertViewTransitionStyleDropDown              // 顶部滑入底部滑出
};

NS_ASSUME_NONNULL_BEGIN

@class MNAlertView;
typedef void(^MNAlertViewHandler)(MNAlertView *alertView);

@interface MNAlertView : UIView


/** 是否支持旋转 */
@property (nonatomic, assign) BOOL isSupportRotating;

/** 图标的名字 */
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *title; // ActionSheet模式最多2行
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSTextAlignment titleTextAlignment;
@property (nonatomic, assign) NSTextAlignment messageTextAlignment;


@property (nonatomic, assign) MNAlertViewStyle alertViewStyle;              // 默认是HDAlertViewStyleAlert
@property (nonatomic, assign) MNAlertViewTransitionStyle transitionStyle;   // 默认是 HDAlertViewTransitionStyleFade
@property (nonatomic, assign) MNAlertViewBackgroundStyle backgroundStyle;   // 默认是 HDAlertViewBackgroundStyleSolid
@property (nonatomic, assign) MNAlertViewButtonsListStyle buttonsListStyle; // 默认是 HDAlertViewButtonsListStyleNormal

@property (nonatomic, copy) MNAlertViewHandler willShowHandler;
@property (nonatomic, copy) MNAlertViewHandler didShowHandler;
@property (nonatomic, copy) MNAlertViewHandler willDismissHandler;
@property (nonatomic, copy) MNAlertViewHandler didDismissHandler;

@property (nonatomic, strong) UIColor *viewBackgroundColor          UI_APPEARANCE_SELECTOR; // 默认是clearColor
@property (nonatomic, strong) UIColor *titleColor                   UI_APPEARANCE_SELECTOR; // 默认是blackColor
@property (nonatomic, strong) UIColor *messageColor                 UI_APPEARANCE_SELECTOR; // 默认是darkGrayColor
@property (nonatomic, strong) UIColor *defaultButtonTitleColor      UI_APPEARANCE_SELECTOR; // 默认是blueColor
@property (nonatomic, strong) UIColor *cancelButtonTitleColor       UI_APPEARANCE_SELECTOR; // 默认是greenColor
@property (nonatomic, strong) UIColor *destructiveButtonTitleColor  UI_APPEARANCE_SELECTOR; // 默认是redColor
@property (nonatomic, strong) UIFont *titleFont                     UI_APPEARANCE_SELECTOR; // 默认是bold 18.0
@property (nonatomic, strong) UIFont *messageFont                   UI_APPEARANCE_SELECTOR; // 默认是system 16.0
@property (nonatomic, strong) UIFont *buttonFont                    UI_APPEARANCE_SELECTOR; // 默认是bold buttonFontSize
@property (nonatomic, assign) CGFloat cornerRadius                  UI_APPEARANCE_SELECTOR; // 默认是10.0


/**
 *  设置默认按钮图片和状态
 */
- (void)setDefaultButtonImage:(UIImage *)defaultButtonImage forState:(UIControlState)state  UI_APPEARANCE_SELECTOR;

/**
 *  设置取消按钮图片和状态
 */
- (void)setCancelButtonImage:(UIImage *)cancelButtonImage forState:(UIControlState)state    UI_APPEARANCE_SELECTOR;

/**
 *  设置毁灭性按钮图片和状态
 */
- (void)setDestructiveButtonImage:(UIImage *)destructiveButtonImage forState:(UIControlState)state  UI_APPEARANCE_SELECTOR;

/**
 *  初始化一个弹窗提示
 */
- (instancetype)initWithTitle:(NSString *)title andMessage:(nullable NSString *)message;
+ (instancetype)alertViewWithTitle:(NSString *)title andMessage:(nullable NSString *)message;

/**
 *  添加按钮点击时候和处理
 *
 *  @param title   按钮名字
 *  @param type    按钮类型
 *  @param handler 点击按钮处理事件
 */
- (void)addButtonWithTitle:(NSString *)title type:(MNAlertViewButtonType)type handler:(MNAlertViewHandler)handler;

/**
 *  显示弹窗提示
 */
- (void)show;

/**
 *  移除视图
 */
- (void)removeAlertView;

/**
 快速弹窗
 
 @param title 标题
 @param message 消息体
 @param cancelButtonTitle 取消按钮文字
 @param otherButtonTitles 其他按钮
 @param block 回调
 @return 返回HDAlertView对象
 */
+ (MNAlertView *)showAlertViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles handler:(void (^)(MNAlertView *alertView, NSInteger buttonIndex))block;

/**
 ActionSheet样式弹窗
 
 @param title 标题
 @return 返回HBAlertView对象
 */
+ (MNAlertView *)showActionSheetWithTitle:(nullable NSString *)title;

@end

NS_ASSUME_NONNULL_END
