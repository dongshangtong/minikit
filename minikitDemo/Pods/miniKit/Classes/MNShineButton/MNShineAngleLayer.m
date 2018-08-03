//
//  MNShineAngleLayer.m
//  minikit
//
//  Created by dongshangtong on 2018/8/3.
//  Copyright © 2018年 dongshangtong. All rights reserved.
//

#import "MNShineAngleLayer.h"
#import "MNShineParams.h"
@implementation MNShineAngleLayer



- (instancetype)initWith:(CGRect )frame withParams:(MNShineParams *)shineparams{
    
    self = [super init];
    if (self) {
        self.frame = frame ;
        _shineparams = shineparams;
        _shineLayers = [NSMutableArray array];
        _smallShineLayers = [NSMutableArray array];
        [self addShines];
    }
    
    return self;
}



-(void)startAnim{
    
    CGFloat  radius = self.frame.size.width/2 * _shineparams.shineDistanceMultiple*1.4;
    
    CGFloat startAngle = 0;
    
    CGFloat angle = M_PI *2 /_shineparams.shineCount + startAngle ;
    
    if (_shineparams.shineCount%2 != 0) {
        
        startAngle = M_PI *2 - angle/_shineparams.shineCount;
    }
    
    for (int i = 0 ; i < _shineparams.shineCount; i++) {
        
        CAShapeLayer *bigShine = _shineLayers[i];
        CABasicAnimation  *bigAnim = [self getAngleAnim:bigShine withAngle:startAngle + angle*i withRadius:radius];
        
        CAShapeLayer * smallShine = _smallShineLayers[i];
        
        CGFloat radiusSub  = self.frame.size.width *0.15 *0.66;
        
        if (_shineparams.shineSize != 0) {
            radiusSub = _shineparams.shineSize *0.66;
        }
        
        CABasicAnimation *smallAnim = [self getAngleAnim:smallShine withAngle:startAngle + angle*i -_shineparams.smallShineOffsetAngle*M_PI/180 withRadius:radius - radiusSub];
        
        [bigShine addAnimation:bigAnim forKey:@"path"];
        [smallShine addAnimation:smallAnim forKey:@"path"];
        
        if (_shineparams.enableFlashing) {
            
            CABasicAnimation *bigFlash = [self getFlashAnim];
            CABasicAnimation *smallFlash = [self getFlashAnim];
            
            [bigShine addAnimation:bigFlash forKey:@"bigFlash"];
            [smallShine addAnimation:smallFlash forKey:@"smallFlash"];
            
        }
    }
    
    CABasicAnimation  *angleAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    angleAnim.duration = _shineparams.animDuration * 0.87;
    angleAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    angleAnim.fromValue = 0;
    angleAnim.toValue =@(_shineparams.shineTurnAngle * M_PI/180);
    angleAnim.delegate = self;
    [self addAnimation:angleAnim forKey:@"rotate"];
    
    if (_shineparams.enableFlashing) {
        
        [self startFlash];
    }
    
}


-(void)startFlash{
    
    _displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(flashAction)];
    
    _displaylink.preferredFramesPerSecond = 6;
    
    [_displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}



-(void)addShines{
    
    CGFloat startAngle = 0;
    
    CGFloat angle = M_PI*2/_shineparams.shineCount + startAngle;
    
    if (_shineparams.shineCount/2 != 2) {
        
        startAngle = M_PI * 2 - angle /_shineparams.shineCount;
    }
    
    CGFloat radius = self.frame.size.width/2 * _shineparams.shineDistanceMultiple;
    
    for (int i = 0 ; i < _shineparams.shineCount; i++ ) {
        
        CAShapeLayer * bigShine =  [CAShapeLayer layer];
        CGFloat  bigWidth = self.frame.size.width * 0.15;
        
        if (_shineparams.shineSize != 0) {
            bigWidth = _shineparams.shineSize;
        }
        
        CGPoint  center =  [self getShineCenter:startAngle + angle* i  with:radius];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:bigWidth startAngle:0 endAngle:M_PI* 2.0 clockwise:false];
        
        bigShine.path = path.CGPath;
        
        if (_shineparams.allowRandomColor) {
            
            UIColor *color = _shineparams.colorRandom[arc4random()% _shineparams.colorRandom.count];
            bigShine.fillColor = color.CGColor;
        }else{
            
            bigShine.fillColor = _shineparams.bigShineColor.CGColor;
        }
        
        [self addSublayer:bigShine];
        
        [_shineLayers addObject:bigShine];
        
        
        CAShapeLayer *smallShine = [CAShapeLayer layer];
        
        CGFloat  smallWidth = bigWidth *0.66;
        
        CGPoint  smallCenter = [self getShineCenter:startAngle  + angle * i -_shineparams.smallShineOffsetAngle*M_PI/180 with:radius - bigWidth];
        
        UIBezierPath *smallPath = [UIBezierPath bezierPathWithArcCenter:smallCenter radius:smallWidth startAngle:0 endAngle:M_PI*2 clockwise:false];
        smallShine.path = smallPath.CGPath;
        
        if (_shineparams.allowRandomColor) {
            UIColor *color = _shineparams.colorRandom[arc4random()% _shineparams.colorRandom.count];
            smallShine.fillColor = color.CGColor;
            
        }else{
            smallShine.fillColor = _shineparams.smallShineColor.CGColor;
        }
        
        [self addSublayer:smallShine];
        
        [_smallShineLayers addObject:smallShine];
        
    }
    
}

-(CABasicAnimation *)getAngleAnim:(CAShapeLayer *) shine withAngle:(CGFloat) angle  withRadius:(CGFloat)radius{
    
    CABasicAnimation  *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.duration = _shineparams.animDuration * 0.87;
    anim.fromValue = (__bridge id _Nullable)(shine.path);
    CGPoint center = [self getShineCenter:angle with:radius];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:0.1 startAngle:0 endAngle:M_PI * 2.0 clockwise:NO];
    anim.toValue = (__bridge id)path.CGPath;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    return anim;
}


-(CABasicAnimation *)getFlashAnim {
    
    CABasicAnimation  *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
    flash.fromValue = @1;
    flash.toValue = 0;
    double duration = (arc4random()%20 + 60) /1000 ;
    flash.duration = duration;
    flash.repeatCount = MAXFLOAT;
    flash.removedOnCompletion = NO;
    flash.autoreverses = YES;
    flash.fillMode = kCAFillModeForwards;
    
    return flash;
}

-(CGPoint)getShineCenter:(CGFloat )angle with:(CGFloat)radius {
    
    CGFloat cenx = CGRectGetMidX(self.frame);
    CGFloat ceny = CGRectGetMidY(self.frame);
    
    NSInteger multiple = 0 ;
    if (angle >= 0 && angle <= 90 *M_PI/180) {
        multiple = 1;
    }else if (angle <= M_PI && angle > 90 * M_PI/180 ){
        
        multiple = 2 ;
    }else if (angle > M_PI && angle <= 270 * M_PI/180){
        
        multiple = 3;
    }else {
        
        multiple = 4;
    }
    
    CGFloat   resultAngel = multiple * 90 * M_PI/180 - angle;
    
    CGFloat a = sin(resultAngel) * radius;
    
    CGFloat b = cos(resultAngel) * radius;
    
    if (multiple == 1) {
        
        return  CGPointMake(cenx + b, ceny -a);
    }else if (multiple == 2){
        
        return CGPointMake(cenx + a, ceny + b);
        
    }else if (multiple == 3){
        
        return CGPointMake(cenx - b, ceny + a);
    }else{
        
        return CGPointMake(cenx - a, ceny - b);
    }
    
    
}

-(void)flashAction{
    
    for (int i = 0 ; i < _shineparams.shineCount; i ++ ) {
        
        CAShapeLayer * bigShine = _shineLayers[i];
        CAShapeLayer * smallShine = _smallShineLayers[i];
        
        UIColor *bigcolor = _shineparams.colorRandom[arc4random()% _shineparams.colorRandom.count];
        bigShine.fillColor =bigcolor.CGColor ;
        
        UIColor *smallcolor = _shineparams.colorRandom[arc4random()% _shineparams.colorRandom.count];
        smallShine.fillColor = smallcolor.CGColor;
    }
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if (flag) {
        
        [_displaylink invalidate];
        _displaylink = nil;
        [self removeAllAnimations];
        [self removeFromSuperlayer];
    }
    
}



@end
