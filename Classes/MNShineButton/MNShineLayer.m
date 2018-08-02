//
//  MNShineLayer.m
//  minikit
//
//  Created by dongshangtong on 2018/8/3.
//  Copyright © 2018年 dongshangtong. All rights reserved.
//

#import "MNShineLayer.h"
#import "MNShineParams.h"
#import "MNShineAngleLayer.h"
@implementation MNShineLayer


-(instancetype)init{
    self  = [super init];
    if (self) {
        _fillColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        //        _fillColor = [UIColor blueColor];
        //self.backgroundColor =[UIColor blueColor].CGColor;
        [self initLayers];
    }
    
    return self;
}

-(instancetype)initWithLayer:(id)layer{
    self = [super initWithLayer:layer];
    
    if (self) {
        [self initLayers];
    }
    return self;
}

-(void)initLayers{
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    _shapeLayer.strokeColor = _fillColor.CGColor;
    _shapeLayer.lineWidth = 1.5;
    [self addSublayer:_shapeLayer];
}


-(void)startAnim{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    anim.duration = _shineParams.animDuration * 0.1;
    CGSize  size = self.frame.size;
    
    UIBezierPath *fromPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/3, size.height/3) radius:1 startAngle:0 endAngle:M_PI * 2.0 clockwise:NO];
    
    UIBezierPath *toPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/2, size.height/2) radius:size.width startAngle:0 endAngle:M_PI * 2.0 clockwise:NO];
    
    anim.delegate = self;
    anim.values =@[(__bridge id) fromPath.CGPath ,(__bridge id)toPath.CGPath];
    
    anim.timingFunctions = @[ [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [_shapeLayer addAnimation:anim forKey:@"path"];
    
    if (_shineParams.enableFlashing) {
        
        [self startFlash];
    }
    
    
}

-(void)startFlash{
    _displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(flashAction)];
    
    _displaylink.preferredFramesPerSecond = 6;
    
    [_displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)flashAction{
    
    
    UIColor *strokecolor = _shineParams.colorRandom[arc4random()% _shineParams.colorRandom.count];
    
    _shapeLayer.strokeColor = strokecolor.CGColor;
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if(flag ){
        
        [_displaylink invalidate] ;
        _displaylink = nil;
        [_shapeLayer removeAllAnimations];
        MNShineAngleLayer *angleLayer =  [[MNShineAngleLayer alloc]initWith:self.frame withParams:_shineParams];
        [self addSublayer:angleLayer];
        [angleLayer startAnim];
        _endAnim();
        
    }
    
}



@end
