//
//  NSData+MNExtension.h
//  minikit
//
//  Created by dongshangtong on 2019/10/3.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (MNExtension)

//int转data
+(NSData *)ConvertIntToData:(int)i;
//data转int
+(int)ConvertDataToInt:(NSData *)data;
@end

NS_ASSUME_NONNULL_END
