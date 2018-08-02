//
//  MNShineParams.m
//  minikit
//
//  Created by dongshangtong on 2018/8/3.
//  Copyright © 2018年 dongshangtong. All rights reserved.
//

#import "MNShineParams.h"

@implementation MNShineParams

-(instancetype)init{
    self = [super init];
    if (self) {
        
        _allowRandomColor = YES;
        _animDuration = 1;
        _bigShineColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        _enableFlashing = NO;
        _shineCount = 7;
        _shineTurnAngle = 20;
        _shineDistanceMultiple = 1.5;
        _smallShineOffsetAngle = 20;
        _smallShineColor = [UIColor lightGrayColor];
        _shineSize = 0;
        _shineImage = [UIImage imageNamed:@"smile"];
        _colorRandom = @[
                         [UIColor colorWithRed:255/255.0 green:102/255.0 blue:153/255.0 alpha:1.0],
                         [UIColor colorWithRed:255/255.0 green:204/255.0 blue:204/255.0 alpha:1.0],
                         [UIColor colorWithRed:153/255.0 green:102/255.0 blue:153/255.0 alpha:1.0],
                         [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0],
                         [UIColor colorWithRed:255/255.0 green:255/255.0 blue:102/255.0 alpha:1.0],
                         [UIColor colorWithRed:244/255.0 green:67/255.0 blue:54/255.0 alpha:1.0],
                         [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0],
                         [UIColor colorWithRed:204/255.0 green:204/255.0 blue:0/255.0 alpha:1.0],
                         [UIColor colorWithRed:255/255.0 green:248/255.0 blue:102/255.0 alpha:1.0],
                         [UIColor colorWithRed:234/255.0 green:180/255.0 blue:86/255.0 alpha:1.0]
                         
                         ];
        
        if (@available(iOS 10.0, * )) {
            _isIOS10 = YES;
        }else{
            _isIOS10 = NO;
        }
        
    }
    
    return self;
}

@end
