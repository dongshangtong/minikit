//
//  MNColorPickerView.h
//  MNColorPickerView
//
//  Created by dongshangtong on 2019/10/19.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MNMenuView;
@class MNCenterCircleView;
@class MNColorCicle;
@class MNSlider;
@class MNFavoriteColorView;
@class MNMenuView;
@class MNDripView;


NS_ASSUME_NONNULL_BEGIN

typedef void(^ColorSelectedBlock)(UIColor *, BOOL);

@interface MNColorPickerView : UIView

@property (nonatomic, strong) UIColor *preColor;

- (void)saveSelectedColorsToArchiver;
+ (void)cleanSelectedColorsInArchiver;

- (void)colorSelectedBlock:(void(^)(UIColor *color, BOOL isConfirm))colorSelectedBlock;

@end

NS_ASSUME_NONNULL_END
