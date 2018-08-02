//
//  MNShineClickLayer.m
//  minikit
//
//  Created by dongshangtong on 2018/8/3.
//  Copyright © 2018年 dongshangtong. All rights reserved.
//

#import "MNShineClickLayer.h"

@implementation MNShineClickLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _maskLayer = [[CALayer alloc]init];
        self.mask = _maskLayer;
        _animDuration = 0.5;
        _color = [UIColor lightGrayColor];
        _fillColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    }
    return self;
}

-(instancetype)initWithLayer:(id)layer{
    
    self = [super initWithLayer:layer];
    
    if (self) {
        _maskLayer = [[CALayer alloc]init];
        self.mask = _maskLayer;
        _animDuration = 0.5;
    }
    
    return self;
}
-(void)setImage:(UIImage *)image
{
    _image = image;
    _maskLayer.contents  = image;
    
}

-(void)setClicked:(BOOL)clicked{
    _clicked = clicked;
    
    if (clicked == YES) {
        self.backgroundColor = _fillColor.CGColor;
    }else{
        self.backgroundColor = _color.CGColor;
        
    }
    
}


-(void)startAnim{
    
    CAKeyframeAnimation  *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = _animDuration;
    [anim setValues:@[@0.4, @1.0, @0.9, @1.0]];
    anim.calculationMode = kCAAnimationCubic;
    [_maskLayer addAnimation:anim forKey:@"scale"];
    
}

-(void)layoutSublayers{
    _maskLayer.frame = self.bounds;
    if (_clicked) {
        self.backgroundColor = _fillColor.CGColor;
    }else{
        self.backgroundColor = _color.CGColor;
        
    }
    _image = [UIImage imageNamed:@"smile"];
    _maskLayer.contents = CFBridgingRelease(_image.CGImage);
}



@end
