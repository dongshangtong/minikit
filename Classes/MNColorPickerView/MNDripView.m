//
//  MNDripView.m
//  MNColorPickerView
//
//  Created by dongshangtong on 2019/10/19.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "MNDripView.h"

@implementation MNDripView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor clearColor] set];
    UIRectFill([self bounds]);
    
    CGSize size = self.frame.size;
    CGFloat clwidth = size.width;
    CGFloat clheight = size.height;
    CGPoint clCenter = CGPointMake(clwidth * 0.5 , clheight * 0.5 + 6);
    UIBezierPath* dripPath = [UIBezierPath bezierPath];
    dripPath.lineWidth = 3.0;
    dripPath.lineCapStyle = kCGLineCapRound;
    dripPath.lineJoinStyle = kCGLineCapRound;
    [dripPath addArcWithCenter: clCenter radius: 10 startAngle:0 endAngle:2 * M_PI  clockwise:YES];
    [[UIColor whiteColor] set];
    [dripPath stroke];
}

@end
