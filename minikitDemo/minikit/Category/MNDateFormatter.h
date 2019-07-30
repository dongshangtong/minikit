//
//  MNDateFormatter.h
//  minikit
//
//  Created by dongshangtong on 2019/7/30.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MNFormatterStyle) {
    
     MNFormatterStyleYYYYMMddHHmmss ,//YYYY-MM-dd HH:mm:ss
     MNFormatterStyleYYYYMMddD,//YYYY.MM.dd
     MNFormatterStyleMdHm ,//MM-dd HH:mm
     MNFormatterStyleYMdHm ,//YYYY年MM月dd日 HH:mm
     MNFormatterStyleMdHmC ,//MM月dd日 HH:mm
     MNFormatterStyleYMdC ,//YYYY年MM月dd日
     MNFormatterStyleYMd ,//YYYY-MM-dd
    
};

@interface MNDateFormatter : NSDateFormatter

+ (instancetype)shareFormatter;

- (instancetype)defaultDateFormatterWithStyle:(MNFormatterStyle)style;



@end

NS_ASSUME_NONNULL_END
