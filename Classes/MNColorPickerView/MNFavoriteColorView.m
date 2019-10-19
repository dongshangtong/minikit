//
//  MNFavoriteColorView.m
//  MNColorPickerView
//
//  Created by dongshangtong on 2019/10/19.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "MNFavoriteColorView.h"

@interface MNFavoriteColorView ()

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) NSMutableArray *dotteLineArray;

@property (nonatomic, strong) UIView *topLineVeiw;
@property (nonatomic, strong) UIView *bottomLineVeiw;

@property (nonatomic, copy) PreSelectColorBlock preSelectColorBlock;

@end

NSInteger const kButtonNumber = 5;

@implementation MNFavoriteColorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _preSelectColorArray = [NSMutableArray array];
        _buttonArray = [NSMutableArray array];
        _dotteLineArray = [NSMutableArray array];
        
        for (int i = 0; i < kButtonNumber; i++) {
            UIButton *colorButton = [[UIButton alloc] init];
            colorButton.userInteractionEnabled = NO;
            [colorButton addTarget:self action:@selector(preColor:) forControlEvents:UIControlEventTouchDown];
            [_buttonArray addObject:colorButton];
            [self addSubview:colorButton];
            
            CAShapeLayer *dotteLine =  [CAShapeLayer layer];
            [colorButton.layer addSublayer:dotteLine];
            [_dotteLineArray addObject:dotteLine];
        }
        
        // line View
        _topLineVeiw = [[UIView alloc] init];
        _topLineVeiw.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
        [self addSubview:_topLineVeiw];
        
        _bottomLineVeiw = [[UIView alloc] init];
        _bottomLineVeiw.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
        [self addSubview:_bottomLineVeiw];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat maginY = 2;
    CGRect  frame = self.frame;
    CGFloat buttonHeight = frame.size.height - maginY * 2;
    CGFloat buttonWidht = buttonHeight;
    CGFloat magin = (frame.size.width - kButtonNumber * buttonWidht) / (kButtonNumber + 1) ;
    
    for (int i = 0; i < self.buttonArray.count; i++) {
        UIButton *colorButton = self.buttonArray[i];
        colorButton.frame = CGRectMake(i * (buttonWidht + magin) + magin, maginY, buttonWidht, buttonHeight);
        colorButton.layer.cornerRadius = buttonWidht * 0.5;
        colorButton.layer.masksToBounds = YES;
        
        CAShapeLayer *dotteLine =  self.dotteLineArray[i];
        CGMutablePathRef dottePath =  CGPathCreateMutable();
        dotteLine.lineWidth = 0.5;
        dotteLine.strokeColor = [UIColor colorWithWhite:0.7 alpha:1].CGColor;
        dotteLine.fillColor = [UIColor clearColor].CGColor;
        CGPathAddEllipseInRect(dottePath, nil, CGRectMake(0, 0, buttonWidht, buttonHeight));
        dotteLine.path = dottePath;
        NSArray *arr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:3],[NSNumber numberWithInt:3], nil];
        dotteLine.lineDashPattern = arr;
        dotteLine.lineDashPhase = 1.0;
        CGPathRelease(dottePath);
    }
    
    _topLineVeiw.frame    = CGRectMake(0, 0, frame.size.width, 0.5);
    _bottomLineVeiw.frame = CGRectMake(0, frame.size.height, frame.size.width, 0.5);
}

- (void)setPreSelectColorArray:(NSMutableArray *)preSelectColorArray
{
    _preSelectColorArray = preSelectColorArray;
    [self updateSelectedColor];
}

- (void)updateSelectedColor
{
    for (int i = 0; i < self.preSelectColorArray.count; i++) {
        UIColor *color = self.preSelectColorArray[i];
        UIButton *button = self.buttonArray[i];
        button.backgroundColor = color;
        button.userInteractionEnabled = YES;
        button.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
        button.layer.borderWidth = 0.1;
        
        CAShapeLayer *dotteLine = self.dotteLineArray[i];
        [dotteLine removeFromSuperlayer];
    }
}

#pragma mark - click

- (void)preColor:(UIButton *)button {
    if (self.preSelectColorBlock) {
        self.preSelectColorBlock(button.backgroundColor);
    }
}

#pragma mark - block

- (void)preSelectColorBlock:(void (^)(UIColor *))preSelectColorBlock {
    if (preSelectColorBlock) {
        self.preSelectColorBlock = preSelectColorBlock;
    }
}


@end
