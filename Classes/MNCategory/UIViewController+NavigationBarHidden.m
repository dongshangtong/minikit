//
//  UIViewController+NavigationBarHidden.m
//  CarNav
//
//  Created by dongshangtong on 2019/9/20.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "UIViewController+NavigationBarHidden.h"

#import <objc/runtime.h>

@implementation UIViewController (NavigationBarHidden)

- (BOOL)shouldNavigationBarHidden{
    return [objc_getAssociatedObject(self, @selector(shouldNavigationBarHidden)) boolValue];
}

- (void)setShouldNavigationBarHidden:(BOOL)shouldNavigationBarHidden{
    objc_setAssociatedObject(self, @selector(shouldNavigationBarHidden), @(shouldNavigationBarHidden), OBJC_ASSOCIATION_ASSIGN);
}

@end
