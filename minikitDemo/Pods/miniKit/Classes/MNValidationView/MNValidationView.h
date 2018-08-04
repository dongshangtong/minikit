//
//  MNValidationView.h
//  minikit
//
//  Created by dongshangtong on 2018/8/4.
//  Copyright © 2018年 dongshangtong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangValidationCodeBlock)(NSString *code) ;

@interface MNValidationView : UIView

@property (nonatomic ,copy)ChangValidationCodeBlock validationCodeBlock;
-(instancetype)initWithFrame:(CGRect)frame  andCharCount:(NSInteger)charCount andLineCount:(NSInteger)lineCount;

@end
