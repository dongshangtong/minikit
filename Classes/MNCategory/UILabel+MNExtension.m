//
//  UILabel+MNExtension.m
//  minikit
//
//  Created by dongshangtong on 2019/7/29.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "UILabel+MNExtension.h"

@implementation UILabel (MNExtension)


- (void)mn_setTextFont:(UIFont *)font atRange:(NSRange)range
{
    [self setTextAttributes:@{NSFontAttributeName : font}
                    atRange:range];
}

- (void)mn_setTextColor:(UIColor *)color atRange:(NSRange)range
{
    [self setTextAttributes:@{NSForegroundColorAttributeName : color}
                    atRange:range];
}

- (void)mn_setTextFont:(UIFont *)font color:(UIColor *)color atRange:(NSRange)range
{
    [self setTextAttributes:@{NSFontAttributeName : font,
                              NSForegroundColorAttributeName : color}
                    atRange:range];
}

- (void)mn_setTextLineSpace:(float)space atRange:(NSRange)range
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:space];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}
-(void)mn_setTextAttributes:(NSDictionary *)attributes atRange:(NSRange)range{
    
    [self setTextAttributes:attributes atRange:range];
}


- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    if (lineSpacing < 0.01 || !text) {
        self.text = text;
        return;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    self.attributedText = attributedString;
}

- (void)setTextAttributes:(NSDictionary *)attributes atRange:(NSRange)range
{
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    for (NSString *name in attributes)
    {
        [mutableAttributedString addAttribute:name value:[attributes objectForKey:name] range:range];
    }
    // [mutableAttributedString setAttributes:attributes range:range]; error
    
    self.attributedText = mutableAttributedString;
    
}


@end
