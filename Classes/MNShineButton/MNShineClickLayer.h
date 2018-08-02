//
//  MNShineClickLayer.h
//  minikit
//
//  Created by dongshangtong on 2018/8/3.
//  Copyright © 2018年 dongshangtong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface MNShineClickLayer : CALayer

@property (nonatomic ,strong)CAShapeLayer *shapeLayer;

@property (nonatomic ,strong)UIColor   *fillColor;

@property (nonatomic ,strong)UIColor *color;

@property (nonatomic ,strong)UIImage *image;

@property (nonatomic ,assign)double animDuration;

@property (nonatomic ,assign)BOOL clicked;

@property (nonatomic,strong)CALayer  *maskLayer;


-(void)startAnim;


@end
