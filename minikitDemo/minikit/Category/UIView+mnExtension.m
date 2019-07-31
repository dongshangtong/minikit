//
//  UIView+MNExtension.m
//  minikit
//
//  Created by dongshangtong on 2019/7/31.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "UIView+MNExtension.h"

@implementation UIView (MNExtension)
#pragma mark - 快速设置控件的frame
-(void)setMn_x:(CGFloat)mn_x{
    CGRect frame = self.frame;
    frame.origin.x = mn_x;
    self.frame = frame;
}

-(CGFloat)mn_x{
    
    return self.frame.origin.x;
}

-(void)setMn_y:(CGFloat)mn_y{
    CGRect frame = self.frame;
    frame.origin.y = mn_y;
    self.frame = frame;
    
}
- (CGFloat)mn_y{
    
    return self.frame.origin.y;
}

- (void)setMn_centerX:(CGFloat)mn_centerX{
    CGPoint center = self.center;
    center.x = mn_centerX;
    self.center = center;
}

- (CGFloat)mn_centerX{
    return self.center.x;
}

-(void)setMn_centerY:(CGFloat)mn_centerY{
    CGPoint center = self.center;
    center.y = mn_centerY;
    self.center = center;
}

-(CGFloat)mn_centerY{
    
    return self.center.y;
}

-(void)setMn_width:(CGFloat)mn_width{
    
    CGRect frame = self.frame;
    frame.size.width = mn_width;
    self.frame = frame;
}

- (CGFloat)mn_width{
    return self.frame.size.width;
}

- (void)setMn_height:(CGFloat)mn_height{
    CGRect frame = self.frame;
    frame.size.height = mn_height;
    self.frame = frame;
}

-(CGFloat)mn_height{
   return self.frame.size.height;
}


-(void)setMn_size:(CGSize)mn_size{
    CGRect frame = self.frame;
    frame.size = mn_size;
    self.frame = frame;
}

-(CGSize)mn_size{
    
    return self.frame.size;
}

- (void)setMn_origin:(CGPoint)mn_origin{
    CGRect frame = self.frame;
    frame.origin = mn_origin;
    self.frame = frame;
}

-(CGPoint)mn_origin{
    return self.frame.origin;
}


-(void)setMn_right:(CGFloat)mn_right{
    CGRect frame = self.frame;
    frame.origin.x = mn_right - frame.size.width;
    self.frame = frame;
}

-(CGFloat)mn_right{
  
     return self.frame.origin.x + self.frame.size.width;
}

-(void)setMn_bottom:(CGFloat)mn_bottom{
    CGRect frame = self.frame;
    frame.origin.y = mn_bottom - frame.size.height;
    self.frame = frame;
}

-(CGFloat)mn_bottom{
   return self.frame.origin.y + self.frame.size.height;
}




#pragma mark - 视图相关
- (void)mn_removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}


#pragma mark - 动画相关
- (instancetype)mn_addAnimationAtPoint:(CGPoint)point; {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGFloat diameter = [self mn_mdShapeDiameterForPoint:point];
    shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0.0, diameter, diameter)].CGPath;
    [self.layer addSublayer:shapeLayer];
    shapeLayer.fillColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0].CGColor;
    // animate
    CGFloat scale = 100.0 / shapeLayer.frame.size.width;
    NSString *timingFunctionName = kCAMediaTimingFunctionDefault; //inflating ? kCAMediaTimingFunctionDefault : kCAMediaTimingFunctionDefault;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
    animation.removedOnCompletion = YES;
    animation.duration = 3.0;
    shapeLayer.transform = [animation.toValue CATransform3DValue];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
    }];
    [shapeLayer addAnimation:animation forKey:@"shapeBackgroundAnimation"];
    [CATransaction commit];
    
    return self;
}

- (instancetype)mn_addAnimationAtPoint:(CGPoint)point WithType:(MNAnimationType)type withColor:(UIColor *)animationColor completion:(void (^)(BOOL))completion {
    [self mn_addAnimationAtPoint:point WithDuration:1.0 WithType:type withColor:animationColor  completion:completion];
    
    return self;
}

- (instancetype)mn_addAnimationAtPoint:(CGPoint)point WithDuration:(NSTimeInterval)duration WithType:(MNAnimationType)type withColor:(UIColor *)animationColor completion:(void (^)(BOOL finished))completion {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGFloat diameter = [self mn_mdShapeDiameterForPoint:point];
    shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0.0, diameter, diameter)].CGPath;
    
    shapeLayer.fillColor = animationColor.CGColor;
    // animate
    CGFloat scale = 1.0 / shapeLayer.frame.size.width;
    NSString *timingFunctionName = kCAMediaTimingFunctionDefault; //inflating ? kCAMediaTimingFunctionDefault : kCAMediaTimingFunctionDefault;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    switch (type) {
            case MNAnimationOpen:
        {
            [self.layer addSublayer:shapeLayer];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            break;
        }
            case MNAnimationClose:
        {
            [self.layer insertSublayer:shapeLayer atIndex:0];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            break;
        }
        default:
            break;
    }
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
    animation.removedOnCompletion = YES;
    animation.duration = duration;
    shapeLayer.transform = [animation.toValue CATransform3DValue];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
        completion(true);
    }];
    [shapeLayer addAnimation:animation forKey:@"shapeBackgroundAnimation"];
    [CATransaction commit];
    
    return self;
}

- (instancetype)mn_addAnimationAtPoint:(CGPoint)point WithType:(MNAnimationType)type withColor:(UIColor *)animationColor; {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGFloat diameter = [self mn_mdShapeDiameterForPoint:point];
    shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0.0, diameter, diameter)].CGPath;
    
    shapeLayer.fillColor = animationColor.CGColor;
    // animate
    CGFloat scale = 100.0 / shapeLayer.frame.size.width;
    NSString *timingFunctionName = kCAMediaTimingFunctionDefault; //inflating ? kCAMediaTimingFunctionDefault : kCAMediaTimingFunctionDefault;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    switch (type) {
            case MNAnimationOpen:
        {
            [self.layer addSublayer:shapeLayer];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            break;
        }
            case MNAnimationClose:
        {
            [self.layer insertSublayer:shapeLayer atIndex:0];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            break;
        }
        default:
            break;
    }
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
    animation.removedOnCompletion = YES;
    animation.duration = 3.0;
    shapeLayer.transform = [animation.toValue CATransform3DValue];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
    }];
    [shapeLayer addAnimation:animation forKey:@"shapeBackgroundAnimation"];
    [CATransaction commit];
    
    return self;
}

// 计算离屏幕的边框最大的距离
- (CGFloat)mn_mdShapeDiameterForPoint:(CGPoint)point {
    CGPoint cornerPoints[] = {
        {0.0, 0.0},
        {0.0, self.bounds.size.height},
        {self.bounds.size.width, self.bounds.size.height},
        {self.bounds.size.width, 0.0}
    };
    
    CGFloat radius = 0.0;
    for (int i = 0; i < 4; i++) {
        CGPoint p = cornerPoints[i];
        CGFloat d = sqrt( pow(p.x - point.x, 2.0) + pow(p.y - point.y, 2.0));
        if (d > radius) {
            radius = d;
        }
    }
    
    return radius * 2.0;
}


#pragma UIView变成UIImage
#pragma UIView变成UIImage
+ (UIImage *)mn_convertViewToImage:(UIView *)view {
    // 第二个参数表示是否非透明。如果需要显示半透明效果，需传NO，否则YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)mn_snapsHotView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)mn_convertViewToImage {
    return [UIView mn_convertViewToImage:self];
}

- (UIImage *)mn_snapsHotView {
    return [UIView mn_snapsHotView:self];
}




@end
