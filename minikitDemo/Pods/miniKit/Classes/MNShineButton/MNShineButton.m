//
//  MNShineButton.m
//  minikit
//
//  Created by dongshangtong on 2018/8/3.
//  Copyright © 2018年 dongshangtong. All rights reserved.
//

#import "MNShineButton.h"

#import "MNShineLayer.h"
#import "MNShineClickLayer.h"
#import "MNShineParams.h"

@implementation MNShineButton


- (instancetype)initWithFrame:(CGRect)frame andparams:(MNShineParams *)shineParams
{
    self = [super initWithFrame:frame];
    if (self) {
        _shineParams = shineParams;
        [self initLayers];
    }
    return self;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesEnded:touches withEvent:event];
    
    __weak typeof(&*self) weekSelf = self;
    if (_clickLayer.clicked == NO) {
        
        _shineLayer.endAnim = ^{
            weekSelf.clickLayer.clicked  = !(weekSelf.clickLayer.clicked? :NO);
            [weekSelf.clickLayer startAnim];
        };
        [_shineLayer startAnim];
    }else{
        
        _clickLayer.clicked = !_clickLayer.clicked;
    }
    
}
-(void)initLayers{
    
    _clickLayer = [[MNShineClickLayer alloc]init];
    _clickLayer.frame = self.bounds;
    
    _clickLayer.image = _shineParams.shineImage;
    _clickLayer.animDuration = _shineParams.animDuration/3;
    [self.layer addSublayer:_clickLayer];
    
    _shineLayer = [[MNShineLayer alloc]init];
    _shineLayer.frame = self.bounds;
    _shineLayer.shineParams = _shineParams;
    [self.layer addSublayer:_shineLayer];
    
}


@end
