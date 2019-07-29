//
//  MNCycleImageView.h
//  takeCar
//
//  Created by dongshangtong on 2019/7/27.
//  Copyright © 2019 yue.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, MMovementDirectionType) {
    
    MMovementDirectionForHorizontally = 0,
    MMovementDirectionVertically,
};

@protocol MNCycleImageViewDelegate <NSObject>

@optional
- (void)didSelectItemAtIndex:(NSInteger)index;

@end

@interface MNCycleImageView : UIView

@property(nonatomic,weak)id<MNCycleImageViewDelegate> delegate;

@property(nonatomic,assign)MMovementDirectionType movementDirection;

@property(nonatomic,strong)NSArray *images;

@property(nonatomic,assign)NSTimeInterval timeInterval;

@property(nonatomic,assign)BOOL hidePageControl;

@property(nonatomic,assign)BOOL canFingersSliding;

@end

NS_ASSUME_NONNULL_END
