//
//  NSString+MNString.h
//  minikit
//
//  Created by dongshangtong on 2019/7/29.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (MNString)



 //将16进制的字符串转换成NSData
+ (NSMutableData *)convertHexStrToData:(NSString *)str ;

//十六进制转换为普通字符串的。
+ (NSString *)ConvertHexStringToString:(NSString *)hexString;
//普通字符串转换为十六进制
+ (NSString *)ConvertStringToHexString:(NSString *)string;

//十六进制转换为普通字符串的。
+ (NSData *)ConvertHexStringToData:(NSString *)hexString;


#pragma mark - 加密相关
/**
 
 *
 *  生成MD5加密字符串
 *
 *  MD5加密后的字符串
 */
- (NSString *)mn_md5;

/**
 
 *
 *  生成SHA1/SHA256/SHA512加密字符串

 */
- (NSString *)mn_SHA1;
- (NSString *)mn_SHA256;
- (NSString *)mn_SHA512;

/**
 
 *
 *  对test进行AES算法加密
 *
 *  text 待加密的文本
 *  password 加密使用的密码，解密时会需要到此密码
 *
 *  AES加密后的字符串
 */
//+ (NSString *)mn_AESEncrypt:(NSString *)text password:(NSString *)password;

/**
 
 *
 *  进行AES算法解密
 *
 *  base64EncodedString 待解密的文本
 *  password 加密时使用的密码
 *
 *  AES解密后的字符串
 */
//+ (NSString *)mn_AESDecrypt:(NSString *)base64EncodedString password:(NSString *)password;

/**
 
 *
 * 把data转成base64字符串
 *
 * data 待转换的二进制数据
 * length 转换的长度范围
 *
 * 转换后的字符串
 */
+ (NSString *)mn_base64StringFromData:(NSData *)data length:(NSUInteger)length;

#pragma mark - Base64
/*!
 
 *
 *  将字符串转换成二进制数据后，再进行base64编码
 *
 *  返回base64编码后的字符串
 */
- (NSString *)mn_base64Encoding;
+ (NSString *)mn_base64Encoding:(NSString *)text;

/*!
 
 *
 *  将base64编码字符串还原成普通字符串
 *
 *  普通字符串
 */
+ (NSString *)mn_textWithBase64Encoding:(NSString *)base64Encoding;

/*!
 
 *
 *  转换成data数据
 *
 *  data数据
 */
- (NSData *)mn_toData;
+ (NSString *)mn_toString:(NSData *)data;

#pragma mark - 验证相关
/**
 
 *
 *  判断是否是合格的邮箱格式
 *
 *  YES表示正确，NO表示不正确
 */
- (BOOL)mn_isValidEmail;
+ (BOOL)mn_isValidEmail:(NSString *)email;

/*!
 
 *
 * 验证是否是正确的手机号码格式
 *
 * YES表示是正确的手机号码格式，返回NO表示手机号码格式不正确
 */
- (BOOL)mn_isValidPhone;
+ (BOOL)mn_isValidPhone:(NSString *)phone;

/*!
 
 *
 * 验证是否是正确的固定电话号码格式
 *
 * YES表示是正确的固定电话号码格式，返回NO表示固话号码格式不正确
 */
- (BOOL)mn_isValidTelNumber;
+ (BOOL)mn_isValidTelNumber:(NSString *)telNumber;

/*!
 
 *
 * 验证是否是正确的18位身份证号码格式
 *
 * YES表示是正确的身份证号码格式，返回NO表示身份证号码格式不正确
 */
- (BOOL)mn_isValidPersonID;
+ (BOOL)mn_isValidPersonID:(NSString *)PID;

#pragma mark - 去空格
/*!
 
 *
 * 去掉空格符号操作，分别是去掉左边的空格、去掉右边的空格、去掉两边的空格、去掉所有空格、去掉所有字母、
 * 去掉字符中中所有的指定的字符
 *
 * 处理后的字符串
 */
- (NSString *)mn_trimLeft;
- (NSString *)mn_trimRight;
- (NSString *)mn_trim;
- (NSString *)mn_trimAll;
- (NSString *)mn_trimLetters;
- (NSString *)mn_trimCharacter:(unichar)character;
- (NSString *)mn_trimWhitespace;

/**
 
 *
 *  获取字符串中共有多少行
 *
 *  行数
 */
- (NSUInteger)mn_numberOfLines;

#pragma mark - 判断字母、数字
/*!
 
 *
 * 判断是否只包含字母、数字、字母和数字
 *
 * YES，表示条件正确，否则返回NO
 */
- (BOOL)mn_isOnlyLetters;
- (BOOL)mn_isOnlyNumbers;
- (BOOL)mn_isOnlyAlphaNumeric;

/*!
 
 *
 * 判断是否是空串/判断去掉两边的空格后是否是空串
 *
 * YES表示是空串，NO表示非空
 */
- (BOOL)mn_isEmpty;
- (BOOL)mn_isTrimEmpty;

#pragma mark - URL包装
/**
 
 *
 * 转换成URL
 *
 * @note 前提条件是满URL
 */
- (NSURL *)mn_toURL;

/**
 
 *
 * 把URL进行UTF8转码
 *
 * @note 前提条件是满足URL
 */
- (NSString *)mn_URLEncode;

#pragma mark - 过滤HTML标签
/*!
 
 *
 * 过滤掉HTML标签
 *
 * html HTML内容
 * 返回喜欢去掉所有HTML标签后的字符串
 */
- (NSString *)mn_filteredHtml;
+ (NSString *)mn_filterHTML:(NSString *)html;

#pragma mark - 添加前缀、后缀
/*!
 * 添加前缀、后缀（不修改self）
 *
 * prefix subfix-后缀
 * 返回添加后的字符串
 */
- (NSString *)mn_addPrefix:(NSString *)prefix;
- (NSString *)mn_addSubfix:(NSString *)subfix;

#pragma mark - 获取文件路径
/*!

 *
 * 根据文件名返回文件的路径
 *  fileName 文件名(使用type参数，就不能加后缀)
 *  type     文件后缀名
 *
 * 如果文件路径存在，则返回该文件路径，否则返回nil
 */
+ (NSString *)mn_pathWithFileName:( NSString *)fileName;
+ (NSString *)mn_pathWithFileName:(NSString *)fileName ofType:(nullable NSString *)type;

#pragma mark - 获取Documents/tmp/Cache路径
/*!
 
 *
 * 获取Documents/tmp/Cache路径
 */
+ (NSString *)mn_documentPath;
+ (NSString *)mn_tmpPath;
+ (NSString *)mn_cachePath;
/*!
 * @author guoyouzeng
 *
 * 判断是否包含字符串
 *  str     需要判断的被包含的字符串
 */
-(BOOL)mn_isContainString:(NSString *)str;




#pragma mark - 文本计算方法
/**
 *  计算文字大小
 *
 *  @param font 字体
 *  @param size 计算范围的大小
 *  @param mode 段落样式
 *
 *  @return 计算出来的大小
 */
- (CGSize)mn_sizeWithSystemFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode;

/**
 计算字符串高度
 
 @param font 字体
 @param size 限制大小
 @param mode 计算的换行模型
 @param numberOfLine 限制计算高度的行数
 @return 返回计算大小
 */
- (CGSize)mn_sizeWithSystemFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode numberOfLine:(NSInteger)numberOfLine;

/**
 *  计算文字大小
 *
 *  @param font 字体
 *  @param size 计算范围的大小
 *
 *  @return 计算出来的大小
 */
- (CGSize)mn_sizeWithSystemFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 *  计算文字大小
 *
 *  @param text 文字
 *  @param font 字体
 *  @param size 计算范围的大小
 *
 *  @return 计算出来的大小
 */
+ (CGSize)mn_sizeWithText:(NSString *)text systemFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 计算粗体文字大小
 
 @param font 字体
 @param size 计算范围的大小
 @param mode 计算的换行模型
 @return 计算出来的大小
 */
- (CGSize)mn_sizeWithBoldFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode;

/**
 计算粗体文字大小
 
 @param font 字体
 @param size 计算范围的大小
 @return 计算出来的大小
 */
- (CGSize)mn_sizeWithBoldFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 计算粗体文字大小
 
 @param font 字体
 @param size 计算范围的大小
 @param mode 计算的换行模型
 @param numberOfLine 限制计算高度的行数
 @return 计算出来的大小
 */
- (CGSize)mn_sizeWithBoldFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode numberOfLine:(NSInteger)numberOfLine;


#pragma mark - 富文本相关
/**
 转变成富文本
 
 @param lineSpacing 行间距
 @param kern 文字间的间距
 @param lineBreakMode 换行方式
 @param alignment 文字对齐格式
 @return 转变后的富文本
 */
- (NSAttributedString *)mn_conversionToAttributedStringWithLineSpeace:(CGFloat)lineSpacing kern:(CGFloat)kern lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment;

/**
 计算富文本字体大小
 
 @param lineSpeace 行间距
 @param kern 文字间的间距
 @param font 字体
 @param size 计算范围
 @param lineBreakMode 换行方式
 @param alignment 文字对齐格式
 @return 计算后的字体大小
 */
- (CGSize)mn_sizeWithAttributedStringLineSpeace:(CGFloat)lineSpeace kern:(CGFloat)kern font:(UIFont *)font size:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment;

/**
 计算富文本字体大小
 
 @param lineSpeace 行间距
 @param kern 文字间的间距
 @param font 字体
 @param size 计算范围
 @param lineBreakMode 换行方式
 @param alignment 文字对齐格式
 @param numberOfLine 限制计算行数
 @return 计算后的字体大小
 */
- (CGSize)mn_sizeWithAttributedStringLineSpeace:(CGFloat)lineSpeace kern:(CGFloat)kern font:(UIFont *)font size:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment numberOfLine:(NSInteger)numberOfLine;

/**
 是否是一行高度
 
 @param lineSpeace 行间距
 @param kern 文字间的间距
 @param font 字体
 @param size 计算范围
 @param lineBreakMode 换行方式
 @param alignment 文字对齐格式
 @return 返回YES代表1行, NO代表多行
 */
- (BOOL)mn_numberOfLineWithLineSpeace:(CGFloat)lineSpeace kern:(CGFloat)kern font:(UIFont *)font size:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment;


@end

NS_ASSUME_NONNULL_END
