//
//  MNCycleImageViewPageControl.m
//  takeCar
//
//  Created by dongshangtong on 2019/7/27.
//  Copyright © 2019 yue.com. All rights reserved.
//


#define dotW     20
#define dotH     3
#define magrin   5

#import "MNCycleImageViewPageControl.h"

@implementation MNCycleImageViewPageControl

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat marginX = dotW + magrin;
    CGFloat newW = (self.subviews.count - 1) * marginX;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    
    CGPoint center = self.center;
    center.x = self.superview.center.x;
    self.center = center;
    
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotH)];
        
        dot.layer.masksToBounds = YES;
        dot.layer.cornerRadius = dotH/2;
    }
}

@end
