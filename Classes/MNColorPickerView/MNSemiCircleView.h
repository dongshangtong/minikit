//
//  MNSemiCircleView.h
//  MNColorPickerView
//
//  Created by dongshangtong on 2019/10/19.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MNSemiCircleView : UIView

@property (nonatomic) BOOL onRight;

@property (nonatomic) BOOL onTop;

@property (nonatomic, strong) UIColor *semiCircleColor;

@end

NS_ASSUME_NONNULL_END
