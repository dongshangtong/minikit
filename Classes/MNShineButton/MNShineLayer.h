//
//  MNShineLayer.h
//  minikit
//
//  Created by dongshangtong on 2018/8/3.
//  Copyright © 2018年 dongshangtong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#include <UIKit/UIKit.h>
@class MNShineParams;

typedef void(^shineLayerEndAnim)(void);

@interface MNShineLayer : CALayer<CAAnimationDelegate>

@property (nonatomic ,strong)CAShapeLayer *shapeLayer;
@property (nonatomic ,strong)UIColor   *fillColor;
@property (nonatomic ,strong)CADisplayLink *displaylink;
@property (nonatomic ,strong)MNShineParams *shineParams;

@property (nonatomic ,assign)double animDuration;

@property (nonatomic ,copy)shineLayerEndAnim endAnim;

-(void)startAnim;


@end
