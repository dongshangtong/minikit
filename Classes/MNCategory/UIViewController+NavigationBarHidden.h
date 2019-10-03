//
//  UIViewController+NavigationBarHidden.h
//  CarNav
//
//  Created by dongshangtong on 2019/9/20.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (NavigationBarHidden)
/// 是否隐藏导航栏。默认NO。
@property (nonatomic , assign) BOOL shouldNavigationBarHidden;

@end



NS_ASSUME_NONNULL_END
