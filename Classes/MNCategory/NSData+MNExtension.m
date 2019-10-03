//
//  NSData+MNExtension.m
//  minikit
//
//  Created by dongshangtong on 2019/10/3.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "NSData+MNExtension.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@implementation NSData (MNExtension)

//int转data
+ (NSData *)ConvertIntToData:(int)i {
    
    NSData *data = [NSData dataWithBytes: &i length: sizeof(i)];
    return data;
}

//data转int
+ (int)ConvertDataToInt:(NSData *)data {
    int i;
    [data getBytes:&i length:sizeof(i)];
    return i;
}

@end
