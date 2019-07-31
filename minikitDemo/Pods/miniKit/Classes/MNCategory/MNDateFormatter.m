//
//  MNDateFormatter.m
//  minikit
//
//  Created by dongshangtong on 2019/7/30.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "MNDateFormatter.h"

@implementation MNDateFormatter

//性能问题
+ (instancetype)shareFormatter{
    
    static MNDateFormatter *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[MNDateFormatter alloc] init];
    });
    return _instance;
    
}
/*
 MNFormatterStyleYYYYMMddHHmmss ,//YYYY-MM-dd HH:mm:ss
 MNFormatterStyleYYYYMMddD,//YYYY.MM.dd
 MNFormatterStyleMdHm ,//MM-dd HH:mm
 MNFormatterStyleYMdHm ,//YYYY年MM月dd日 HH:mm
 MNFormatterStyleMdHmC ,//MM月dd日 HH:mm
 MNFormatterStyleYMdC ,//YYYY年MM月dd日
 MNFormatterStyleYMd ,//YYYY-MM-dd
 */
- (instancetype)defaultDateFormatterWithStyle:(MNFormatterStyle)style
{
    static MNDateFormatter *staticDateFormatter;
    
    staticDateFormatter = [MNDateFormatter shareFormatter];
    switch (style) {
        case MNFormatterStyleYYYYMMddHHmmss:
            [staticDateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            break;
        case MNFormatterStyleYYYYMMddD:
            [staticDateFormatter setDateFormat:@"YYYY.MM.dd"];
            break;
        case MNFormatterStyleMdHm:
            [staticDateFormatter setDateFormat:@"MM-dd HH:mm"];
            break;
        case MNFormatterStyleYMdHm:
            [staticDateFormatter setDateFormat:@"YYYY年MM月dd日 HH:mm"];
            break;
        case MNFormatterStyleMdHmC:
            [staticDateFormatter setDateFormat:@"MM月dd日 HH:mm"];
            break;
        case MNFormatterStyleYMdC:
            [staticDateFormatter setDateFormat:@"YYYY年MM月dd日"];
            break;
        case MNFormatterStyleYMd:
            [staticDateFormatter setDateFormat:@"YYYY年MM月dd日"];
            break;
        default:
            [staticDateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            break;
    }
    
    return staticDateFormatter;
}


@end
