//
//  MNMoveButton.m
//  NewEra
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MNMoveButton.h"

@interface MNMoveButton()
//是否移动
@property (nonatomic,assign) BOOL isMoved;

@end


@implementation MNMoveButton


-(instancetype)init{
    
    if (self=[super init]) {
        
        self.backgroundColor=[UIColor whiteColor];
        
    }
    
    
    return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];
    
    UITouch * touch = [touches anyObject];
    
    //本次触摸点
    CGPoint current = [touch locationInView:self];
    
    //上次触摸点
    CGPoint previous = [touch previousLocationInView:self];
    
    CGPoint center = self.center;
    
    //中心点移动触摸移动的距离
    center.x += current.x - previous.x;
    center.y += current.y - previous.y;
    
    //限制移动范围
    CGFloat screenWidth  = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat xMin = self.frame.size.width  * 0.5f;
    CGFloat xMax = screenWidth  - xMin;
    
    CGFloat yMin = self.frame.size.height * 0.5f+64;
    CGFloat yMax = screenHeight - self.frame.size.height * 0.5f - 49;
    
    if (center.x > xMax) center.x = xMax;
    if (center.x < xMin) center.x = xMin;
    
    if (center.y > yMax) center.y = yMax;
    if (center.y < yMin) center.y = yMin;
    
    self.center = center;
    
    //移动距离大于0.5才判断为移动了(提高容错性)
    if (current.x-previous.x>=0.5 || current.y - previous.y>=0.5) {
        
        self.isMoved = YES;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!self.isMoved) {
        //如果没有移动，则调用父类方法，触发button的点击事件
        [super touchesEnded:touches withEvent:event];
    }
    self.isMoved = NO;
        
    //关闭高亮状态
    [self setHighlighted:NO];
}


@end
