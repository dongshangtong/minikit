//
//  MNShineButton.h
//  minikit
//
//  Created by dongshangtong on 2018/8/3.
//  Copyright © 2018年 dongshangtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MNShineLayer;
@class MNShineClickLayer;
@class MNShineParams;
@interface MNShineButton : UIControl

@property (nonatomic ,strong) UIColor *color;

@property (nonatomic ,strong) UIColor *fillColor;

@property (nonatomic ,strong) UIColor *image;

@property (nonatomic ,strong) MNShineParams *shineParams;

@property (nonatomic ,strong)MNShineClickLayer *clickLayer;

@property (nonatomic ,strong)MNShineLayer *shineLayer;

- (instancetype)initWithFrame:(CGRect)frame andparams:(MNShineParams *)shineParams;

@end
