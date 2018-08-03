//
//  MNShineAngleLayer.h
//  minikit
//
//  Created by dongshangtong on 2018/8/3.
//  Copyright © 2018年 dongshangtong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@class MNShineParams ;
@interface MNShineAngleLayer : CALayer<CAAnimationDelegate>

@property (nonatomic ,strong) MNShineParams * shineparams;

@property (nonatomic ,strong)NSMutableArray *shineLayers;

@property (nonatomic ,strong)NSMutableArray *smallShineLayers;

@property (nonatomic ,strong)CADisplayLink *displaylink;

- (instancetype)initWith:(CGRect )frame withParams:(MNShineParams *)shineparams;

-(void)startAnim;

@end
