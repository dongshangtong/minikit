//
//  UIView+MNMaker.m
//  minikit
//
//  Created by dongshangtong on 2019/7/29.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "UIView+MNMaker.h"
#import "Masonry.h"
#import <objc/runtime.h>
#import "UIColor+MNExtension.h"

//MARK:~~~~ UIView (MNMaker) ~~~~
@implementation UIView (MNMaker)

+ (instancetype)mn_instanceWithSuperView:(UIView *)superView constraint:(void (^)(MASConstraintMaker *))constraint {
    UIView *view = [[self alloc]init];
    [superView addSubview:view];
    [view mas_makeConstraints:constraint];
    
    return view;
}

+ (instancetype)mn_instanceWithBackgroundColor:(UIColor *)backgroundColor superView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *))constraint {
    
    UIView *view = [[self alloc]init];
    view.backgroundColor = backgroundColor;
    [superView addSubview:view];
    [view mas_makeConstraints:constraint];
    
    return view;
}

@end

//MARK:~~~~ UILabel (MNMaker) ~~~~
@implementation UILabel (MNMaker)

+ (instancetype)mn_labelWithFontSize:(float)fontSize textColorValue:(uint)textColorValue superView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *))constraint {
    return [UILabel mn_labelWithFont:[UIFont systemFontOfSize:fontSize] textColor:[UIColor colorWithRGBValue:textColorValue] superView:superView constraint:constraint];
}

+ (instancetype)mn_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor superView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *))constraint {
    return [UILabel mn_labelWithText:@"" font:font textColor:textColor backgroundColor:[UIColor clearColor] superView:superView constraint:constraint];
}

+ (instancetype)mn_labelWithText:(NSString *)text fontSize:(float)fontSize textColorValue:(uint)textColorValue backgroundColorValue:(uint)backgroundColorValue superView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *))constraint {
    
    return [UILabel mn_labelWithText:text font:[UIFont systemFontOfSize:fontSize] textColor:[UIColor colorWithRGBValue:textColorValue] backgroundColor:[UIColor colorWithRGBValue:backgroundColorValue] superView:superView constraint:constraint];
}

+ (instancetype)mn_labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor superView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *))constraint {
    
    UILabel *label = [[UILabel alloc]init];
    if (text.length > 0) {
       label.text = text;
    }
    label.font = font;
    label.textColor = textColor;
    label.backgroundColor = backgroundColor;
    [superView addSubview:label];
    [label mas_makeConstraints:constraint];
    
    return label;
}

@end

//MARK:~~~~ UIButton (Maker) ~~~~
@implementation UIButton (Maker)

+ (instancetype)mn_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont superView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *))constraint {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    [superView addSubview:button];
    [button mas_makeConstraints:constraint];
    
    return button;
    
}

+ (instancetype)mn_buttonWithSuperView:(UIView *)superView constraint:(void(^)(MASConstraintMaker *))constraint {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [superView addSubview:button];
    [button mas_makeConstraints:constraint];
    
    return button;
}

+ (instancetype)mn_buttonWithImage:(UIImage *)image selectImage:(UIImage *)selectImage superView:(UIView *)superView constraint:(void (^)(MASConstraintMaker *))constraint {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectImage forState:UIControlStateSelected];
    [superView addSubview:button];
    [button mas_makeConstraints:constraint];
    
    return button;
    
}

@end


//MARK:~~~~ UITableView (Maker) ~~~~

static const void *k_mn_tableView_sectionNumber = @"k_mn_tableView_sectionNumber";
static const void *k_mn_tableView_rowNumber = @"k_mn_tableView_rowNumber";
static const void *k_mn_tableView_cellConfig = @"k_mn_tableView_cellConfig";
static const void *k_mn_tableView_iden = @"k_mn_tableView_iden";

@interface UITableView (PropertyExtension)

@property (copy, nonatomic) NSInteger (^sectionNumber)(void);
@property (copy, nonatomic) NSInteger (^rowNumber)(NSInteger section);
@property (copy, nonatomic) void (^cellConfig)(NSIndexPath *indexPath ,UITableViewCell *cell);
@property (strong, nonatomic) NSString *iden;

@end

@implementation UITableView (Maker)

+ (instancetype)mn_tableViewWithStyle:(UITableViewStyle)style cellClassOrNibName:(id)cellClassOrNibName sectionNumber:(NSInteger (^)(void))sectionNumber rowNumber:(NSInteger (^)(NSInteger section))rowNumber cellConfig:(void (^)(NSIndexPath *indexPath ,UITableViewCell *cell))cellConfig {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:style];
    
    tableView.dataSource = tableView;
    if ([cellClassOrNibName isKindOfClass:[NSString class]]) {
        [tableView registerNib:[UINib nibWithNibName:cellClassOrNibName bundle:nil] forCellReuseIdentifier:cellClassOrNibName];
        tableView.iden = (NSString *)cellClassOrNibName;
    } else if ((Class)cellClassOrNibName) {
        [tableView registerClass:cellClassOrNibName forCellReuseIdentifier:NSStringFromClass(cellClassOrNibName)];
        tableView.iden = NSStringFromClass(cellClassOrNibName);
    } else if (!cellClassOrNibName){
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DefaultUITableViewCell"];
        tableView.iden = @"DefaultUITableViewCell";
    }
    tableView.sectionNumber = sectionNumber;
    tableView.rowNumber = rowNumber;
    tableView.cellConfig = cellConfig;
    
    return tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.rowNumber) {
        return 0;
    }
    return self.rowNumber(section);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.iden forIndexPath:indexPath];
    if (self.cellConfig) {
        self.cellConfig(indexPath,cell);
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.sectionNumber) {
        return 1;
    }
    return self.sectionNumber();
}


- (void)setIden:(NSString *)iden {
    objc_setAssociatedObject(self, k_mn_tableView_iden, iden, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setSectionNumber:(NSInteger (^)(void))sectionNumber {
    objc_setAssociatedObject(self, k_mn_tableView_sectionNumber, sectionNumber, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setRowNumber:(NSInteger (^)(NSInteger))rowNumber {
    objc_setAssociatedObject(self, k_mn_tableView_rowNumber, rowNumber, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setCellConfig:(void (^)(NSIndexPath *, UITableViewCell *))cellConfig {
    objc_setAssociatedObject(self, k_mn_tableView_cellConfig, cellConfig, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)iden {
    return objc_getAssociatedObject(self, k_mn_tableView_iden);
}

- (NSInteger (^)(void))sectionNumber {
    return objc_getAssociatedObject(self, k_mn_tableView_sectionNumber);
}

- (NSInteger (^)(NSInteger))rowNumber {
    return objc_getAssociatedObject(self, k_mn_tableView_rowNumber);
}

- (void (^)(NSIndexPath *, UITableViewCell *))cellConfig {
    return objc_getAssociatedObject(self, k_mn_tableView_cellConfig);
}

@end
