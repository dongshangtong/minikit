//
//  UIColor+MNExtension.h
//  minikit
//
//  Created by dongshangtong on 2019/7/29.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    CGFloat r; // Red component (0 <= r <= 1)
    CGFloat g; // Green component (0 <= g <= 1)
    CGFloat b; // Blue component (0 <= b <= 1)
    CGFloat a; // Alpha/opacity component (0 <= a <= 1)
}
RGBA;

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (MNExtension)

#pragma mark *************一些颜色初始化方法**************
/**
 *  Return a UIColor from an SVG color name
 *
 *  @param name The color name
 */
+ (UIColor *)colorFromName:(NSString *)name;

/**
 *  Return a UIColor using the HSL color space
 *
 *  @param hue The color's hue
 *  @param saturation The color's saturation
 *  @param lightness The color's lightness
 */
+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness;

/**
 *  Return a UIColor using the HSL color space and an alpha value
 *
 *  @param hue The color's hue
 *  @param saturation The color's saturation
 *  @param lightness The color's lightness
 *  @param alpha The color's alpha value
 */
+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;

/**
 *  Return a UIColor from a 3- or 6-digit hex string
 *
 *  @param hexString The hex color string value
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**
 *  Return a UIColor from a 3- or 6-digit hex string and an alpha value
 *
 *  @param hexString The hex color string value
 *  @param alpha The color's alpha value
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString withAlpha:(CGFloat)alpha;

/**
 *  Return a UIColor from a RGBA int
 *
 *  @param value The int value
 */
+ (UIColor *)colorWithRGBAValue:(uint)value;

/**
 *  Return a UIColor from a ARGB int
 *
 *  @param value The int value
 */
+ (UIColor *)colorWithARGBValue:(uint)value;

/**
 *  Return a UIColor from a RGB int
 *
 *  @param value The int value
 */
+ (UIColor *)colorWithRGBValue:(uint)value;

/**
 *  Convert this color to HSLA
 *
 *  @param hue A float pointer that will be set by this conversion
 *  @param saturation A float pointer that will be set by this conversion
 *  @param lightness A float pointer that will be set by this conversion
 *  @param alpha A float pointer that will be set by this conversion
 */
- (BOOL)getHue:(CGFloat *)hue saturation:(CGFloat *)saturation lightness:(CGFloat *)lightness alpha:(CGFloat *)alpha;

/**
 *  Determine if this color is opaque. Essentially, this returns true if the alpha channel is 1.0
 */
- (BOOL)isOpaque;

/**
 *  Adds percent to the lightness channel of this color
 */
- (UIColor *)darkenByPercent:(CGFloat)percent;

/**
 *  Subtracts percent from the lightness channel of this color
 */
- (UIColor *)lightenByPercent:(CGFloat)percent;

+ (UIColor *)randomColor;


RGBA RGBAFromUIColor(UIColor *color);

//  把UIColor 转换 cgb 进制, 需要在外面设置 CGFloat components[3];
- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color;

//  把UIColor 转换 16 进制
- (NSString *)hexadecimalFromUIColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
