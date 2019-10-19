//
//  MNMenuView.m
//  MNColorPickerView
//
//  Created by dongshangtong on 2019/10/19.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "MNMenuView.h"

@implementation MNMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGSize size = self.frame.size;
    float fw = size.width;
    float fh = size.height * 7 / 9;
    CGSize triangleSize = CGSizeMake(size.width, size.height - fh);
    
    [[UIColor clearColor] set];
    UIRectFill([self bounds]);
    
    // draw rounded rectangle
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context,   fw, fh - 10);                  // right
    CGContextAddArcToPoint(context, fw, fh, fw - 5, fh    , 10);   // right bottom
    CGContextAddArcToPoint(context, 0 , fh, 0     , fh - 5, 10);   // left bottom
    CGContextAddArcToPoint(context, 0 , 0 , fw - 5, 0     , 10);   // left top
    CGContextAddArcToPoint(context, fw, 0 , fw    , fh - 5, 10);   // right top
    CGContextClosePath(context);
    [[UIColor colorWithWhite:0.1 alpha:0.9] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // draw triangle
    CGContextBeginPath(context);
    CGContextMoveToPoint(context,    triangleSize.width * 0.35, fh);
    CGContextAddLineToPoint(context, triangleSize.width * 0.50, CGRectGetMaxY(self.frame));
    CGContextAddLineToPoint(context, triangleSize.width * 0.65, fh);
    CGContextClosePath(context);
    [[UIColor colorWithWhite:0.1 alpha:0.9] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}


@end
