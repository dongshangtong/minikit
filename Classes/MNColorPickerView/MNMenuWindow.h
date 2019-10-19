//
//  MNMenuWindow.h
//  MNColorPickerView
//
//  Created by dongshangtong on 2019/10/19.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MNMenuView;




NS_ASSUME_NONNULL_BEGIN

@interface MNMenuWindow : UIWindow

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) MNMenuView *menuView;

+ (instancetype)shareMenuWindow;

- (void)updateWithFrame:(CGRect)frame;

+ (void)animationToShowMenu;
+ (void)animationToHiddenMenu;

@end

NS_ASSUME_NONNULL_END
