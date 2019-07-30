//
//  UIView+MNMaker.h
//  minikit
//
//  Created by dongshangtong on 2019/7/29.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
NS_ASSUME_NONNULL_BEGIN

//MARK:~~~~ UIView (MNMaker) ~~~~
@interface UIView (MNMaker)

+ (instancetype)mn_instanceWithSuperView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *make))constraint;

+ (instancetype)mn_instanceWithBackgroundColor:(UIColor *)backgroundColor superView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *make))constraint;

@end

//MARK:~~~~ UILabel (MNMaker) ~~~~

@interface UILabel (MNMaker)//行数和对齐方式如果需要请单独设置

+ (instancetype)mn_labelWithFontSize:(float)fontSize textColorValue:(uint)textColorValue superView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *make))constraint;

+ (instancetype)mn_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor superView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *make))constraint;


/**
 创建label 并设置属性
 
 @param text text
 @param fontSize systemFontOfSize:fontSize
 @param textColorValue 16进制色值 无alpha 0x555555
 @param backgroundColorValue 16进制色值 无alpha 0x555555
 @param superView superView
 @param constraint constraint
 @return label
 */
+ (instancetype)mn_labelWithText:(NSString *)text fontSize:(float)fontSize textColorValue:(uint)textColorValue backgroundColorValue:(uint)backgroundColorValue superView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *make))constraint;


/**
 创建label 并设置属性
 
 @param text text
 @param font font
 @param textColor textColor
 @param backgroundColor backgroundColor
 @param superView superView
 @param constraint masonry约束
 @return label
 */
+ (instancetype)mn_labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor superView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *make))constraint;


@end

//MARK:~~~~ UIButton (MNMaker) ~~~~

@interface UIButton (MNMaker)


/**
 创建button
 
 @param title normal状态下title
 @param titleColor normal状态下titleColor
 @param titleFont titleFont
 @param superView superView
 @param constraint constraint
 @return button
 */
+ (instancetype)mn_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont superView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *make))constraint;

/**
 创建空白的button
 
 @param superView superView
 @param constraint constraint
 @return button
 */
+ (instancetype)mn_buttonWithSuperView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *make))constraint;


/**
 创建有选中图案的button
 
 @param image image
 @param selectImage selectImage
 @param superView superView
 @param constraint constraint
 @return button
 */
+ (instancetype)mn_buttonWithImage:(UIImage *)image selectImage:(UIImage *)selectImage superView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *make))constraint;


@end

//MARK:~~~~ UITableView (MNMaker) ~~~~
@interface UITableView (MNMaker)<UITableViewDataSource>


/**
 创建tableView 对其三个数据源方法封装 对简单的tableView适用
 
 @param style UITableViewStyle
 @param cellClassOrNibName cell类或者xib名
 @param sectionNumber 组数 nullable nil 1组
 @param rowNumber 行数 nullable nil 0行
 @param cellConfig 设置cell nullable nil nil
 @return tableView
 */
+ (instancetype)mn_tableViewWithStyle:(UITableViewStyle)style cellClassOrNibName:(id)cellClassOrNibName sectionNumber:(NSInteger (^)(void))sectionNumber rowNumber:(NSInteger (^)(NSInteger section))rowNumber cellConfig:(void (^)(NSIndexPath *indexPath ,UITableViewCell *cell))cellConfig;

@end

NS_ASSUME_NONNULL_END
