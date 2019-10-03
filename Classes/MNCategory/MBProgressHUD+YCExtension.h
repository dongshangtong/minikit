//
//  MBProgressHUD+YCExtension.h
//  YCPublicDemo
//
//  Created by dongshangtong on 2017/5/22.
//  Copyright © 2017年 xinhuanwangluo. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (YCExtension)


/**** Loading ****/
+ (instancetype)showLoading;
+ (instancetype)showLoadingToView:(UIView *)view;
+ (instancetype)showLoadingWithStatus:(NSString *)status;
+ (instancetype)showLoadingWithStatus:(NSString *)status toView:(UIView *)view;

+(void)showLoadingAnimationHUD;
+(void)showLoadingAnimationDataHUDForicon:(NSString *)icon;
+(void)showLoadingAnimationDataHUDForView:(UIView *)view  icon:(NSString *)icon;


//--------------自定义message---没有图片------
+ (void)showCustomMessage:( NSString * )message;


/**** Success ****/
+ (void)showSuccess;
+ (void)showSuccessWithStatus:(NSString *)status;
+ (void)showSuccessWithStatus:(NSString *)status toView:(UIView *)view;

/**** Error ****/

+ (void)showError;
+ (void)showErrorWithStatus:(NSString *)status;
+ (void)showErrorWithStatus:(NSString *)status toView:(UIView *)view;

/**** Info ****/
+ (void)showInfo;
//+ (void)showInfoToView:(UIView *)view;
+ (void)showInfoWithStatus:(NSString *)status;
+ (void)showInfoWithStatus:(NSString *)status toView:(UIView *)view;
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;
+ (void)showHOM:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

//只显示进度条
+ (void)showProgress:(NSProgress * )uploadProgress;
//进度和文字
+ (void)showProgress:(NSProgress * )uploadProgress Text:(NSString *)text;
+ (void)showProgress:(NSProgress * )uploadProgress Text:(NSString *)text view:(UIView *)view;


/**** Dismiss ****/
+ (void)dismiss;
+ (void)dismissForKeyWindow;
+ (void)dismissForView:(UIView *)view;


@end
