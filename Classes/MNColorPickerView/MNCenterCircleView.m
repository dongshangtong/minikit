//
//  MNCenterCircleView.m
//  MNColorPickerView
//
//  Created by dongshangtong on 2019/10/19.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "MNCenterCircleView.h"
#import "MNSemiCircleView.h"

@implementation MNCenterCircleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        

        self.layer.cornerRadius = self.frame.size.width/2;
        self.layer.masksToBounds = YES;
        _favoriteColorView = [[MNSemiCircleView alloc] init];
        _favoriteColorView.semiCircleColor = [UIColor orangeColor];
        [_favoriteColorView setOnTop:YES];
        [self addSubview:_favoriteColorView];

        _colorView = [[MNSemiCircleView alloc] init];
        _colorView.semiCircleColor = [UIColor grayColor];
        [_colorView setOnTop:NO];
        [self addSubview:_colorView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat radius = self.frame.size.width;
    _favoriteColorView.frame = CGRectMake(0, 0, radius , radius * 0.5);
    _colorView.frame = CGRectMake(0, 0, radius , radius * 0.5);
}

@end
