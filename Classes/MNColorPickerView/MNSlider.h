//
//  MNSlider.h
//  MNColorPickerView
//
//  Created by dongshangtong on 2019/10/19.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^SliderValueChangeBlock)(CGFloat value, BOOL confirm);

@interface MNSlider : UIView

@property(nonatomic) CGFloat value;
@property (nonatomic, strong) UIView *vittaView;
@property (nonatomic, strong) UIButton *indicatorButton;

- (void)changeValue:(CGFloat)value animation:(BOOL)isAnimation;
- (void)sliderValueChangeBlock:(void(^)(CGFloat value, BOOL confirm))sliderValueChangeBlock;


@end

NS_ASSUME_NONNULL_END
