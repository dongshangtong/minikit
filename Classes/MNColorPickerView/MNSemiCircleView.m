//
//  MNSemiCircleView.m
//  MNColorPickerView
//
//  Created by dongshangtong on 2019/10/19.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "MNSemiCircleView.h"

@implementation MNSemiCircleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _semiCircleColor = [UIColor redColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSemiCircleColor:(UIColor *)semiCircleColor {
    if (semiCircleColor) {
        _semiCircleColor = semiCircleColor;
        [self setNeedsDisplay];
    }
}

- (void)setOnRight:(BOOL)onRight {
    _onRight = onRight;
    [self setNeedsDisplay];
}


-(void)setOnTop:(BOOL)onTop{
    _onTop = onTop;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGFloat width = self.frame.size.height * 0.5 - 1;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.semiCircleColor.CGColor);
    CGContextSetLineWidth(context, 0.0);
//    if (self.onRight) {
//        CGContextAddArc(context, width + 1, width + 1, width, 0 , M_PI * 2, 1);
//    } else {
//        CGContextAddArc(context, 0, width + 1, width, 0 , M_PI * 2, 0);
//    }
//
//
//    CG_EXTERN void CGContextAddArc(CGContextRef cg_nullable c, CGFloat x, CGFloat y,
//    CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
//    CG_AVAILABLE_STARTING(10.0, 2.0);
    
    if (self.onTop) {
           CGContextAddArc(context, width + 1, width + 1, width, 0 , M_PI , 1);
       } else {
           CGContextAddArc(context, width + 1 , width +1 , width, M_PI , M_PI *2 , 1);
       }
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
