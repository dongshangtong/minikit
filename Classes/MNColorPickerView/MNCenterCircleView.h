//
//  MNCenterCircleView.h
//  MNColorPickerView
//
//  Created by dongshangtong on 2019/10/19.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  MNSemiCircleView;

NS_ASSUME_NONNULL_BEGIN

@interface MNCenterCircleView : UIView

@property (nonatomic, strong) MNSemiCircleView *favoriteColorView;
@property (nonatomic, strong) MNSemiCircleView *colorView;

@end

NS_ASSUME_NONNULL_END
