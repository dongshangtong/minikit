//
//  MNFavoriteColorView.h
//  MNColorPickerView
//
//  Created by dongshangtong on 2019/10/19.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void (^PreSelectColorBlock)(UIColor *);

@interface MNFavoriteColorView : UIView

@property (nonatomic, strong) NSMutableArray<UIColor *> *preSelectColorArray;

- (void)updateSelectedColor;
- (void)preSelectColorBlock:(void(^)(UIColor *))preSelectColorBlock;


@end

NS_ASSUME_NONNULL_END
