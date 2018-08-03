//
//  MNShineParams.h
//  minikit
//
//  Created by dongshangtong on 2018/8/3.
//  Copyright © 2018年 dongshangtong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MNShineImageHeart,
    MNShineImageLike,
    MNShineImageSmile,
    MNShineImageStar,
    MNShineImageCustom,
} MNShineImage;


@interface MNShineParams : NSObject

@property (nonatomic ,assign)BOOL allowRandomColor;

@property (nonatomic ,assign)double animDuration;

@property (nonatomic ,strong)UIColor *bigShineColor;

@property (nonatomic ,assign)BOOL enableFlashing;

@property (nonatomic ,assign)NSInteger shineCount;

@property (nonatomic ,assign)float shineTurnAngle;

@property (nonatomic ,assign)float shineDistanceMultiple;

@property (nonatomic ,assign)float smallShineOffsetAngle;

@property (nonatomic ,strong)UIColor *smallShineColor;

@property (nonatomic ,assign)float shineSize;

@property (nonatomic ,strong)NSArray *colorRandom;

@property (nonatomic ,assign)MNShineImage  shineType;

@property (nonatomic ,strong)UIImage *shineImage;

@property (nonatomic ,assign)BOOL isIOS10;

@end
