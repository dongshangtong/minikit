//
//  MNUtils.m
//  minikit
//
//  Created by dongshangtong on 2019/10/3.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "MNUtils.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation MNUtils

+ (UIViewController*)topViewController {
    return (UIViewController*)[MNUtils topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}
+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* nav = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

@end
