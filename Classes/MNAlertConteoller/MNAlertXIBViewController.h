//
//  MNAlertXIBViewController.h
//  minikit
//
//  Created by dongshangtong on 2019/10/14.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MNAlertXIBViewController : UIViewController

// 继承这个控制器，想要contentView位置放哪里就frame ,大小也可以改变
@property (nonatomic,strong)UIView *contentView;

@end

NS_ASSUME_NONNULL_END
