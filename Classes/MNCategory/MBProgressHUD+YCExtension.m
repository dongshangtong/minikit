//
//  MBProgressHUD+YCExtension.m
//  YCPublicDemo
//
//  Created by dongshangtong on 2017/5/22.
//  Copyright © 2017年 xinhuanwangluo. All rights reserved.
//

#import "MBProgressHUD+YCExtension.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"
#import <UIKit/UIKit.h>

@implementation MBProgressHUD (YCExtension)



/**** Loading ****/

+ (instancetype)showLoading
{
    return [self showLoadingToView:nil];
}

+ (instancetype)showLoadingToView:(UIView *)view
{
    [self dismissForView:view];
    view = view ? view : [UIApplication sharedApplication].keyWindow ;
    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
   // hud.activityIndicatorColor = [UIColor whiteColor];
    hud.backgroundColor = [UIColor clearColor];
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    // 单出这个HUD ,就不能点击
    hud.userInteractionEnabled = YES;
    hud.animationType = MBProgressHUDAnimationZoom;
    [hud hideAnimated:YES afterDelay: MAXFLOAT];
    return hud;
}

+ (instancetype)showLoadingWithStatus:(NSString *)status
{
    return [self showLoadingWithStatus:status toView:nil];
}

+ (instancetype)showLoadingWithStatus:(NSString *)status toView:(UIView *)view
{
    MBProgressHUD *hud = [self showLoadingToView:view];
    hud.label.text = status;
    return hud;
}



#pragma  mark -   自定信息;
+ (void) showCustomMessage:( NSString * )message
{
    
    [self show:message view:nil ];
}



/**** Success ****/

+ (void)showSuccess
{
    [self show:@"成功" view:nil ];
}


+ (void)showSuccessWithStatus:(NSString *)status
{
    [self showSuccessWithStatus:status toView:nil];
}

+ (void)showSuccessWithStatus:(NSString *)status toView:(UIView *)view
{
    [self show:status icon:@"MBProgressHUD+HUD.bundle/success" view:view];
}

/**** Error ****/

+ (void)showError
{
    //[self showErrorWithStatus:@"失败"];
    [self show:@"失败" view:nil ];
}

+ (void)showErrorWithStatus:(NSString *)status
{
    [self showErrorWithStatus:status toView:nil];
}

+ (void)showErrorWithStatus:(NSString *)status toView:(UIView *)view
{
     [self show:status icon:@"MBProgressHUD+HUD.bundle/error" view:view];
}

/**** Info ****/

+ (void)showInfo
{
//    [self showInfoWithStatus:@"未完操作"];
    [self show:@"未完操作" view:nil ];
}

+ (void)showInfoWithStatus:(NSString *)status
{
    return [self showInfoWithStatus:status toView:nil];
}

+ (void)showInfoWithStatus:(NSString *)status toView:(UIView *)view
{
    [self show:status icon:@"MBProgressHUD+HUD.bundle/info" view:view];

}




#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
  
    hud.label.text = text;
    // 设置图片
   hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;

    //2,设置背景框的背景颜色和透明度， 设置背景颜色之后opacity属性的设置将会失效
    hud.bezelView.color = [UIColor blackColor];
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 单出这个HUD ,就不能点击
    hud.userInteractionEnabled = YES;
    hud.animationType = MBProgressHUDAnimationZoom;
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1];
}

+ (void)show:(NSString *)text  view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
   
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
     // 快速显示一个提示信息
    hud.label.text = text;
    
    hud.mode = MBProgressHUDModeText;
    
    hud.label.textColor = [UIColor whiteColor];
    //2,设置背景框的背景颜色和透明度， 设置背景颜色之后opacity属性的设置将会失效
    hud.bezelView.color = [UIColor blackColor];
    // 单出这个HUD ,就不能点击
    hud.userInteractionEnabled = YES;
    hud.animationType = MBProgressHUDAnimationZoom;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1];
    

}



+ (void)showHOM:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;

    //2,设置背景框的背景颜色和透明度， 设置背景颜色之后opacity属性的设置将会失效
    hud.bezelView.color = [UIColor blackColor];
   hud.animationType = MBProgressHUDAnimationZoom;
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:18.0f];
    hud.detailsLabel.textColor= [UIColor whiteColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 单出这个HUD ,就不能点击
    hud.userInteractionEnabled = YES;

    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:5];
}



/**** 有动画加载 ****/

+(void)showLoadingAnimationHUD{
    
    
    [self showLoadingAnimationDataHUDForicon:nil];
    
}

+(void)showLoadingAnimationDataHUDForicon:(NSString *)icon{
    
    
    [self showLoadingAnimationDataHUDForView:nil icon:icon];
    
}


+(void)showLoadingAnimationDataHUDForView:(UIView *)view  icon:(NSString *)icon
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    NSString * imgaName;
    if (icon) {
      imgaName  = icon;
    }else{
    imgaName = @"MBProgressHUD.bundle/loadinggif3.gif";
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:imgaName ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];

    UIImageView *imgView =[[UIImageView alloc]init];
    imgView.image = [UIImage sd_imageWithGIFData:data];
    imgView.frame =CGRectMake(0, 0, 100, 100);
    imgView.contentMode = UIViewContentModeScaleToFill;
    //imgView.backgroundColor = [UIColor whiteColor];
    hud.customView= imgView;
    hud.minSize= CGSizeMake(100, 100);
   // hud.dimBackground = YES; //有一点蒙版感觉
    hud.removeFromSuperViewOnHide = YES;
    // 单出这个HUD ,就不能点击
    hud.userInteractionEnabled = YES;
    //hud.backgroundColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor whiteColor];
    
}

//只显示进度条
+ (void)showProgress:(NSProgress * )uploadProgress
{
    
    
    [self showProgress:uploadProgress Text:nil];
}


//进度和文字
+ (void)showProgress:(NSProgress * )uploadProgress Text:(NSString *)text
{
    
    
    [self showProgress:uploadProgress Text:text view: nil];
}


#pragma mark 显示信息
+ (void)showProgress:(NSProgress * )uploadProgress Text:(NSString *)text view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 这里的代码会在主线程执行

    dispatch_sync(dispatch_get_main_queue(), ^(){
        
        // 快速显示一个提示信息
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        //hud.mode = MBProgressHUDModeDeterminateHorizontalBar;//长条
        hud.mode = MBProgressHUDModeAnnularDeterminate;// 圆形
        hud.label.text = text;
        hud.progress = uploadProgress.fractionCompleted ;
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        //hud.dimBackground =YES;
        
        // 1秒之后再消失
        [hud hideAnimated:NO afterDelay:0.5];
        

    });

    
}







/**** Dismiss --移除****/

+ (void)dismiss
{
    [self dismissForKeyWindow];
    
    [self dismissForView:nil];
}

+ (void)dismissForKeyWindow
{
    UIView *keyWindow = [UIApplication sharedApplication].keyWindow ;
    [self hideHUDForView:keyWindow animated:YES];
}

+ (void)dismissForView:(UIView *)view
{
    if (view) [self hideHUDForView:view animated:YES];
}

@end
