//
//  NSString+MNString.m
//  minikit
//
//  Created by dongshangtong on 2019/7/29.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "NSString+MNString.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/sysctl.h>
#import <sys/socket.h>
#import <net/if.h>
#import <net/if_dl.h>

static char base64EncodingTable[64] = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
};


@implementation NSString (MNString)

- (NSString *)mn_md5 {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}

- (NSString *)mn_SHA1 {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH], i;
    CC_SHA1([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for ( i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}

- (NSString *)mn_SHA256 {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_SHA256_DIGEST_LENGTH], i;
    CC_SHA256([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}

- (NSString *)mn_SHA512 {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_SHA512_DIGEST_LENGTH], i;
    CC_SHA512([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}

- (NSData *)mn_toData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)mn_toString:(NSData *)data {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)mn_base64Encoding {
    return [NSString mn_base64Encoding:self];
}

+ (NSString *)mn_base64Encoding:(NSString *)text {
    NSData *data = [text mn_toData];
    NSString *result = nil;
    
    // 7.0以下版本不可用
    result = [data base64EncodedStringWithOptions:0];
    
    return result;
}

+ (NSString *)mn_textWithBase64Encoding:(NSString *)base64Encoding {
    if (base64Encoding != nil) {
        NSData *data = [self _dataWithBase64EncodedString:base64Encoding];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return nil;
}

- (BOOL)mn_isValidEmail {
    return [NSString mn_isValidEmail:self];
}

+ (BOOL)mn_isValidEmail:(NSString *)email {
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[email lowercaseString]];
}

- (NSString *)mn_trimLeft {
    NSUInteger len = 0;
    
    while (len < self.length) {
        if ([self characterAtIndex:len] != ' ') {
            break;
        }
        
        len++;
    }
    
    if (len >= self.length) {
        len = self.length;
    }
    
    return [self substringFromIndex:len];
}

- (NSString *)mn_trimRight {
    NSInteger index = self.length - 1;
    for (NSInteger i = self.length - 1; i >= 0; --i) {
        if ([self characterAtIndex:i] != ' ') {
            break;
        } else {
            index--;
        }
    }
    
    if (index + 1 < self.length) {
        index++;
    }
    
    return [self substringToIndex:index];
}

- (NSString *)mn_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)mn_trimAll {
    NSString *tempString = self.mn_trim;
    return [tempString stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)mn_trimLetters {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]];
}

- (NSString *)mn_trimCharacter:(unichar)character {
    NSString *str = [NSString stringWithFormat:@"%c", character];
    return [self stringByReplacingOccurrencesOfString:str withString:@""];
}

- (NSString *)mn_trimWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSUInteger)mn_numberOfLines {
    return [self componentsSeparatedByString:@"\n"].count + 1;
}

- (BOOL)mn_isOnlyLetters {
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

- (BOOL)mn_isOnlyNumbers {
    NSCharacterSet *numSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numSet].location == NSNotFound);
}

- (BOOL)mn_isOnlyAlphaNumeric {
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

- (BOOL)mn_isEmpty {
    return self == nil || self.length == 0;
}

- (BOOL)mn_isTrimEmpty {
    return self == nil || self.mn_trim.length == 0;
}

- (BOOL)mn_isValidPhone {
    return [NSString mn_isValidPhone:self];
}

+ (BOOL)mn_isValidPhone:(NSString *)phone {
    NSString *pattern = @"^1\\d{10}$";
    
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if ([mobilePredicate evaluateWithObject:phone]) {
        return YES;
    }
    
    return NO;
}

//+ (BOOL)mn_isValidPhone:(NSString *)phone {
//  /**
//   * 手机号码
//   * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//   * 联通：130,131,132,152,155,156,185,186
//   * 电信：133,1349,153,180,189
//   */
//  NSString *mobile = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//  /**
//   10         * 中国移动：China Mobile
//   11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//   12         */
//  NSString *chinaMobile = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//  /**
//   15         * 中国联通：China Unicom
//   16         * 130,131,132,152,155,156,185,186
//   17         */
//  NSString * chinaUnicom = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//  /**
//   20         * 中国电信：China Telecom
//   21         * 133,1349,153,180,189
//   22         */
//  NSString * chinaTelecom = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//
//  NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
//  NSPredicate *cmPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaMobile];
//  NSPredicate *cuPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaUnicom];
//  NSPredicate *ctPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaTelecom];
//  if ([mobilePredicate evaluateWithObject:phone]
//      || [cmPredicate evaluateWithObject:phone]
//      || [cuPredicate evaluateWithObject:phone]
//      || [ctPredicate evaluateWithObject:phone]) {
//    return YES;
//  }
//
//  return NO;
//}

- (BOOL)mn_isValidTelNumber {
    return [NSString mn_isValidTelNumber:self];
}

+ (BOOL)mn_isValidTelNumber:(NSString *)telNumber {
    NSString *PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return [pred evaluateWithObject:telNumber];
}

- (BOOL)mn_isValidPersonID {
    return [NSString mn_isValidPersonID:self];
}

+ (BOOL)mn_isValidPersonID:(NSString *)PID {
    // 判断位数 取消15位数的判断
    if (PID.length != 18) {
        return NO;
    }
    NSString *carid = PID;
    long lSumQT = 0;
    // 加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    // 校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    // 将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:PID];
    if (PID.length == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        
        for (int i = 0; i<= 16; i++) {
            p += (pid[i] - 48) * R[i];
        }
        
        int o = p % 11;
        NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    // 判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self _areaCode:sProvince]) {
        return NO;
    }
    
    // 判断年月日是否有效
    // 年份
    int strYear = [[self _substringWithString:carid begin:6 end:4] intValue];
    // 月份
    int strMonth = [[self _substringWithString:carid begin:10 end:2] intValue];
    // 日
    int strDay = [[self _substringWithString:carid begin:12 end:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",
                                                strYear, strMonth, strDay]];
    if (date == nil) {
        return NO;
    }
    
    const char *PaperId  = [carid UTF8String];
    // 检验长度
    if(18 != strlen(PaperId)) return NO;
    // 校验数字
    for (int i = 0; i < 18; i++) {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ) {
            return NO;
        }
    }
    
    // 验证最末的校验码
    for (int i=0; i<=16; i++) {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] ) {
        return NO;
    }
    return YES;
}

- (NSString *)mn_filteredHtml {
    return [NSString mn_filterHTML:self];
}

+ (NSString *)mn_filterHTML:(NSString *)html {
    if (html == nil) {
        return nil;
    }
    NSScanner *scanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([scanner isAtEnd] == NO) {
        // 找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        // 找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        // 替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text]
                                               withString:@""];
    }
    
    return html;
}

- (NSString *)mn_addPrefix:(NSString *)prefix {
    if (prefix == nil || prefix.length == 0) {
        return self;
    }
    
    return [NSString stringWithFormat:@"%@%@", prefix, self];
}

- (NSString *)mn_addSubfix:(NSString *)subfix {
    if (subfix == nil || subfix.length == 0) {
        return self;
    }
    
    return [NSString stringWithFormat:@"%@%@", self, subfix];
}

+ (NSString *)mn_documentPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

+ (NSString *)mn_tmpPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
}

+ (NSString *)mn_cachePath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
}

+ (NSString *)mn_pathWithFileName:(NSString *)fileName {
    return [self mn_pathWithFileName:fileName ofType:nil];
}

+ (NSString *)mn_pathWithFileName:(NSString *)fileName ofType:(nullable NSString *)type {
    return [[NSBundle mainBundle] pathForResource:fileName ofType:type];
}

- (NSURL *)mn_toURL {
    return [NSURL URLWithString:[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
}

+ (NSString *)mn_base64StringFromData:(NSData *)data length:(NSUInteger)length {
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length];
    if (lentext < 1) {
        return @"";
    }
    result = [NSMutableString stringWithCapacity: lentext];
    raw = [data bytes];
    ixtext = 0;
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0) {
            break;
        }
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext) {
                input[i] = raw[ix];
            }
            else {
                input[i] = 0;
            }
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++) {
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        }
        
        for (i = ctcopy; i < 4; i++) {
            [result appendString: @"="];
        }
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length)) {
            charsonline = 0;
        }
    }
    return result;
}



- (NSString *)mn_URLEncode {
    NSString *result = [self stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| "] invertedSet]];
 
    return [result mn_trim];
}

//+ (NSString *)mn_AESEncrypt:(NSString *)text password:(NSString *)password {
//  NSData *encryptedData = [[text mn_toData] mn_AES256EncryptedUsingKey:[password mn_SHA256] error:nil];
//  NSString *base64EncodedString  = [NSString mn_base64StringFromData:encryptedData
//                                                           length:[encryptedData length]];
//
//  return base64EncodedString;
//}

//+ (NSString *)mn_AESDecrypt:(NSString *)base64EncodedString password:(NSString *)password {
//  NSData *encryptedData = [NSData mn_base64DataFromString:base64EncodedString];
//  NSData *decryptedData = [encryptedData mn_AES256DecryptedUsingKey:[password mn_SHA256]
//                                                           error:nil];
//
//  return [decryptedData mn_toString];
//}

#pragma mark - Private
+ (NSString *)_substringWithString:(NSString *)str begin:(NSInteger)begin end:(NSInteger )end {
    return [str substringWithRange:NSMakeRange(begin, end)];
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
+ (BOOL)_areaCode:(NSString *)code {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

+ (NSData *)_dataWithBase64EncodedString:(NSString *)string {
    
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:@""];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL) {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        
        const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES) {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++) {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}
-(BOOL)mn_isContainString:(NSString *)str {
    NSRange range = [self rangeOfString:str];
    return range.location != NSNotFound;
}

#pragma mark - 文本计算方法
- (CGSize)mn_sizeWithSystemFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = mode;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attributes = @{NSFontAttributeName : font,
                                 NSParagraphStyleAttributeName : paragraphStyle};
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
}

- (CGSize)mn_sizeWithSystemFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode numberOfLine:(NSInteger)numberOfLine {
    CGSize maxSize = [self mn_sizeWithSystemFont:font constrainedToSize:size lineBreakMode:mode];
    CGFloat oneLineHeight = [self mn_sizeWithSystemFont:font constrainedToSize:CGSizeMake(size.width, font.lineHeight) lineBreakMode:NSLineBreakByTruncatingTail].height;
    CGFloat height = 0;
    CGFloat limitHeight = oneLineHeight * numberOfLine;
    
    if (maxSize.height > limitHeight) {
        height = limitHeight;
    } else {
        height = maxSize.height;
    }
    
    return CGSizeMake(maxSize.width, height);
}

- (CGSize)mn_sizeWithSystemFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return [self mn_sizeWithSystemFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
}

+ (CGSize)mn_sizeWithText:(NSString *)text systemFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return [text mn_sizeWithSystemFont:font constrainedToSize:size];
}

- (CGSize)mn_sizeWithBoldFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = mode;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *attributes = @{NSFontAttributeName: font,
                                 NSParagraphStyleAttributeName: paragraphStyle};
    
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
}

- (CGSize)mn_sizeWithBoldFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return [self mn_sizeWithBoldFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
}

- (CGSize)mn_sizeWithBoldFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode numberOfLine:(NSInteger)numberOfLine {
    CGSize maxSize = [self mn_sizeWithBoldFont:font constrainedToSize:size lineBreakMode:mode];
    CGFloat oneLineHeight = [self mn_sizeWithBoldFont:font constrainedToSize:CGSizeMake(size.width, font.lineHeight) lineBreakMode:NSLineBreakByTruncatingTail].height;
    CGFloat height = 0;
    CGFloat limitHeight = oneLineHeight * numberOfLine;
    
    if (maxSize.height > limitHeight) {
        height = limitHeight;
    } else {
        height = maxSize.height;
    }
    
    return CGSizeMake(maxSize.width, height);
}


#pragma mark - 富文本相关
- (NSAttributedString *)mn_conversionToAttributedStringWithLineSpeace:(CGFloat)lineSpacing kern:(CGFloat)kern lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.lineBreakMode = lineBreakMode;
    paragraphStyle.alignment = alignment;
    
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle,
                                 NSKernAttributeName:@(kern)};
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    
    return attributedString;
}

- (CGSize)mn_sizeWithAttributedStringLineSpeace:(CGFloat)lineSpeace kern:(CGFloat)kern font:(UIFont *)font size:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment {
    if (font == nil) {
        NSLog(@"font不能为空");
        return CGSizeMake(0, 0);
    }
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpeace;
    paraStyle.lineBreakMode = lineBreakMode;
    paraStyle.alignment = alignment;
    
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:paraStyle,
                          NSKernAttributeName:@(kern)};
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
}

- (CGSize)mn_sizeWithAttributedStringLineSpeace:(CGFloat)lineSpeace kern:(CGFloat)kern font:(UIFont *)font size:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment numberOfLine:(NSInteger)numberOfLine {
    CGSize maxSize = [self mn_sizeWithAttributedStringLineSpeace:lineSpeace kern:kern font:font size:size lineBreakMode:lineBreakMode alignment:alignment];
    CGFloat oneLineHeight = [self mn_sizeWithAttributedStringLineSpeace:lineSpeace kern:kern font:font size:CGSizeMake(size.width, font.lineHeight) lineBreakMode:NSLineBreakByTruncatingTail alignment:alignment].height;
    CGFloat height = 0;
    CGFloat limitHeight = oneLineHeight * numberOfLine;
    
    if (maxSize.height > limitHeight) {
        height = limitHeight;
    } else {
        height = maxSize.height;
    }
    
    return CGSizeMake(maxSize.width, height);
}

- (BOOL)mn_numberOfLineWithLineSpeace:(CGFloat)lineSpeace kern:(CGFloat)kern font:(UIFont *)font size:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment {
    CGFloat oneHeight = [self mn_sizeWithAttributedStringLineSpeace:lineSpeace kern:kern font:font size:CGSizeMake(size.width, font.lineHeight) lineBreakMode:NSLineBreakByTruncatingTail alignment:alignment].height;
    CGFloat maxHeight = [self mn_sizeWithAttributedStringLineSpeace:lineSpeace kern:kern font:font size:size lineBreakMode:lineBreakMode alignment:alignment].height;
    
    if (maxHeight > oneHeight) {
        return NO;
    }
    
    return YES;
}




//将16进制的字符串转换成NSData
+ (NSData *)convertHexStrToData:(NSString *)str
{
    if (!str.length) {
        return nil;
    }
    
    NSMutableData *tempData = [NSMutableData dataWithCapacity:10];
    NSRange range;
    if ([str length] %2 == 0) {
        range = NSMakeRange(0,2);
    } else {
        range = NSMakeRange(0,1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
       
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [tempData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return [NSData dataWithData:tempData];
}

//将NSData转为16进制的字符串
+ (NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *tempString = [NSMutableString stringWithCapacity:data.length];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange,BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i =0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) &0xff];
            if ([hexStr length] == 2) {
                [tempString appendString:hexStr];
            }
            else {
                [tempString appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return [NSString stringWithString:tempString];
}
//十进制准换为十六进制字符串
+ (NSString *)hexStringFromString:(NSString *)string
{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++){
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

+(NSString *) parseByteArray2HexString:(Byte[]) bytes
{
    NSMutableString *hexStr = [[NSMutableString alloc]init];
    int i = 0;
    if(bytes){
        while (bytes[i] != '\0'){
            NSString *hexByte = [NSString stringWithFormat:@"%x",bytes[i] & 0xff];///16进制数
            if([hexByte length]==1)
                [hexStr appendFormat:@"0%@", hexByte];
            else
                [hexStr appendFormat:@"%@", hexByte];
            i++;
        }
    }
    return hexStr;
}



+(NSString *)stringFromHexString:(NSString *)hexString
{//
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 +1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i =0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr] ;
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    return unicodeString;
}

//10进制转16进制
+(NSString *)ToHex:(long long int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i =0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    return str;
}



//十六进制转换为普通字符串的。
+ (NSString *)ConvertHexStringToString:(NSString *)hexString {
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    //    BabyLog(@"===字符串===%@",unicodeString);
    return unicodeString;
}

//普通字符串转换为十六进制
+ (NSString *)ConvertStringToHexString:(NSString *)string {
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for (int i=0;i<[myD length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if ([newHexStr length]==1) {
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else{
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
        
    }
    return hexStr;
}


//十六进制转换为普通字符串的。
+ (NSData *)ConvertHexStringToData:(NSString *)hexString {
    
    NSData *data = [[self ConvertHexStringToString:hexString] dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}


@end
