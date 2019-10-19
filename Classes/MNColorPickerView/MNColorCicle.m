//
//  MNColorCicle.m
//  MNColorPickerView
//
//  Created by dongshangtong on 2019/10/19.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "MNColorCicle.h"

@implementation MNColorCicle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = frame.size.width * 0.5;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.frame.size.width * 0.5;
}

- (void)drawRect:(CGRect)rect
{
    CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CGFloat radiur = self.frame.size.width;
    for (int hue = 0; hue <= 360; hue++) {
        CGFloat secA = (hue) / 180.0 * M_PI + M_PI;
        CGFloat a = radiur * sin(secA);
        CGFloat b = radiur * cos(secA);
        CGPoint toPoint = CGPointMake(b + center.x, a + center.y);
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineWidth = 3;
        [path moveToPoint:center];
        [path addLineToPoint:toPoint];
        [path stroke];
        [[UIColor colorWithHue:(1.0 * hue / 360) saturation:1.0 brightness:1.0 alpha:1.0] set];
    }
}

@end
