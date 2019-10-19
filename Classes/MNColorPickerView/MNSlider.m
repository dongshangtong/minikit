//
//  MNSlider.m
//  MNColorPickerView
//
//  Created by dongshangtong on 2019/10/19.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "MNSlider.h"
#import "MNMenuWindow.h"

@interface MNSlider ()

@property (nonatomic, assign) CGFloat minX;
@property (nonatomic, assign) CGFloat maxX;

@property (nonatomic, assign) CGFloat preX;

@property (nonatomic, copy) SliderValueChangeBlock sliderValueChangeBlock;

@end

@implementation MNSlider

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _vittaView = [[UIView alloc] init];
        _vittaView.layer.masksToBounds = YES;
        _vittaView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
        _vittaView.layer.borderWidth = 0.1;
        [self addSubview:_vittaView];
        
        _indicatorButton = [[UIButton alloc] init];
        _indicatorButton.backgroundColor     = [UIColor orangeColor];
        _indicatorButton.layer.borderWidth   = 0.1;
        _indicatorButton.layer.borderColor   = [UIColor colorWithWhite:0.80 alpha:1.0].CGColor;
        _indicatorButton.layer.shadowOffset  = CGSizeMake(0, 3);
        _indicatorButton.layer.shadowRadius  = 3;
        _indicatorButton.layer.shadowOpacity = 0.2;
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changedIndicatorButtonPosition:)];
        [_indicatorButton addGestureRecognizer:panRecognizer];
        
        // animation to show or hidden the menu
        [_indicatorButton addTarget:self action:@selector(showMenuByButtonClick:) forControlEvents:UIControlEventTouchDown];
        [_indicatorButton addTarget:self action:@selector(hiddenMenuByButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_indicatorButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGPoint center = _indicatorButton.center;
    CGSize size = self.frame.size;
    CGFloat indicatorBtnWidth = size.height ;
    CGFloat vittaViewWidth    = size.width - indicatorBtnWidth;
    _minX = indicatorBtnWidth * 0.5;
    _maxX = size.width - indicatorBtnWidth * 1.5;
    
    _vittaView.frame = CGRectMake(_minX, 4, vittaViewWidth, size.height - 8);
    _vittaView.layer.cornerRadius = _vittaView.frame.size.height * 0.5;
    
    _indicatorButton.frame = CGRectMake(_maxX, 0, indicatorBtnWidth, indicatorBtnWidth);
    _indicatorButton.layer.cornerRadius = indicatorBtnWidth * 0.5;
    if (!CGPointEqualToPoint(center, CGPointZero)) {
        _indicatorButton.center = center;
    }
}

#pragma mark -

- (void)changedIndicatorButtonPosition:(UIPanGestureRecognizer *)recognizer {
    CGRect frame = self.indicatorButton.frame;
    self.preX = frame.origin.x;
    
    CGPoint currentPoint = [recognizer locationInView:self];
    CGFloat moveX = currentPoint.x - self.preX;
    frame.origin.x += moveX;
    if (frame.origin.x < self.minX) {
        frame.origin.x = self.minX;
    }else if (frame.origin.x > self.maxX){
        frame.origin.x = self.maxX;
    }
    self.indicatorButton.frame = frame;
    
    CGFloat actualOffsetX = frame.origin.x - self.minX;
    self.value  = actualOffsetX / (self.vittaView.frame.size.width - 2 * self.minX);
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            if ([MNMenuWindow shareMenuWindow].hidden) {
                [self changeMenuFrameAndValue];
                [MNMenuWindow animationToShowMenu];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{
            if (frame.origin.x >= 0 && frame.origin.x <= self.vittaView.frame.size.width) {
                [self changeMenuFrameAndValue];
                if (self.sliderValueChangeBlock) {
                    self.sliderValueChangeBlock(self.value, NO);
                }
            }
            break;
        }
        case UIGestureRecognizerStateEnded: {
            if (frame.origin.x >= 0 && frame.origin.x <= self.vittaView.frame.size.width) {
                [self changeMenuFrameAndValue];
                if (self.sliderValueChangeBlock) {
                    self.sliderValueChangeBlock(self.value, YES);
                }
            }
            [MNMenuWindow animationToHiddenMenu];
            
            break;
        }
        default: {
            break;
        }
    }
}

- (void)changeValue:(CGFloat)value animation:(BOOL)isAnimation {
    if (isAnimation) {
        [self changePositionAnimationWithValue:value andDuration: 1.0]; // 修改动画时间
    }else{
        [self changePositionAnimationWithValue:value andDuration:0.0];
    }
    self.value = value;
}

- (void)changePositionAnimationWithValue:(CGFloat)value andDuration:(CGFloat)duration {
    CGSize size = self.indicatorButton.frame.size;
    CGFloat vittaViewWidth = self.vittaView.frame.size.width;
    CGFloat toX = value * vittaViewWidth;
    if (toX < self.minX) {
        toX = self.minX;
    }
    
    [UIView animateWithDuration:duration animations:^{
        [self.indicatorButton setCenter:CGPointMake(toX, size.width * 0.5)];
    }];
}

#pragma mark - menu

- (void)hiddenMenuByButtonClick:(UIButton *)button {
    [MNMenuWindow animationToHiddenMenu];
}

- (void)showMenuByButtonClick:(UIButton *)button {
    [self changeMenuFrameAndValue];
    [MNMenuWindow animationToShowMenu];
}

- (void)changeMenuFrameAndValue {
    CGRect frame = self.indicatorButton.frame;
    CGRect menuFrame = [MNMenuWindow shareMenuWindow].frame;
    CGPoint origin = [[MNMenuWindow shareMenuWindow] convertPoint:self.indicatorButton.center fromView:self.indicatorButton.superview];
    menuFrame.origin.x = origin.x - frame.size.width - 10;
    menuFrame.origin.y = origin.y - frame.size.height - 33;
    
    [[MNMenuWindow shareMenuWindow] updateWithFrame:menuFrame];
    [MNMenuWindow shareMenuWindow].titleLabel.text = [NSString stringWithFormat:@"%.1f%@",self.value * 100, @"%"];
}

#pragma mark - setter

- (void)setValue:(CGFloat)value {
    if (value > 1.0) {
        value = 1.0;
    }else if (value < 0.0){
        value = 0.0;
    }
    _value = value;
}

#pragma mark - block

- (void)sliderValueChangeBlock:(void (^)(CGFloat, BOOL))sliderValueChangeBlock {
    if (sliderValueChangeBlock) {
        self.sliderValueChangeBlock = sliderValueChangeBlock;
    }
}


@end
