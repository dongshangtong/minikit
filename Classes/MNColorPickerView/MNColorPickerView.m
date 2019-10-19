//
//  MNColorPickerView.m
//  MNColorPickerView
//
//  Created by dongshangtong on 2019/10/19.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "MNColorPickerView.h"

#import "MNSemiCircleView.h"
#import "MNSlider.h"
#import "MNSemiCircleView.h"
#import "MNColorCicle.h"
#import "MNCenterCircleView.h"
#import "MNDripView.h"
#import "MNFavoriteColorView.h"
#import "MNMenuWindow.h"
#import "MNMenuView.h"

@interface MNColorPickerView()

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, getter=isConfirm) BOOL confirm;

@property (nonatomic, assign) CGFloat hue;
@property (nonatomic, assign) CGFloat saturation;
@property (nonatomic, assign) CGFloat brightness;
@property (nonatomic, assign) CGFloat alpha;

@property (nonatomic, strong) UIView *colorCircleView;
@property (nonatomic, strong) MNCenterCircleView *toplifeCircleView;

@property (nonatomic, strong) UIView *centerCircleView;
@property (nonatomic, strong) MNColorCicle *colorView;

@property (nonatomic, strong) UIButton *dripBtn;
@property (nonatomic, strong) MNDripView *dripView;

@property (nonatomic, strong) UIImageView *waterleftView;
@property (nonatomic, strong) UIImageView *waterRightView;

@property (nonatomic, strong) UIImageView *sunleftView;
@property (nonatomic, strong) UIImageView *sunRightView;

@property (nonatomic, strong) MNSlider *saturationSlider;
@property (nonatomic, strong) MNSlider *brightnessSlider;
@property (nonatomic, strong) CAGradientLayer *saturationGradientLayer;
@property (nonatomic, strong) CAGradientLayer *brightnessGradientLayer;

@property (nonatomic, strong) MNFavoriteColorView *favoriteColorView;

@property (nonatomic, copy)   ColorSelectedBlock colorSelectedBlock;

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat dripViewX;

@property (nonatomic, assign) CGFloat preAngle;
@property (nonatomic, assign) CGFloat preTransformAngle;



@end



static CGFloat DripViewWithAndHeight = 38;

@implementation MNColorPickerView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor blueColor];
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _confirm = NO;
    _hue = 0.0;
    _saturation = 1.0;
    _brightness = 1.0;
    _alpha = 1.0;
    
    _preAngle = 0.0;
    _preTransformAngle = 0.0;
    
    // colour circle view
    _colorCircleView = [[UIView alloc] init];

    _colorView = [[MNColorCicle alloc] init];
    [_colorCircleView addSubview:_colorView];
    
    
    
    
    _toplifeCircleView = [[MNCenterCircleView alloc] init];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePreColor:)];
    [_toplifeCircleView addGestureRecognizer:tapRecognizer];
    [self addSubview:_toplifeCircleView];
    
    _centerCircleView = [[UIView alloc] init];
    [_colorCircleView addSubview:_centerCircleView];
    
    
    
    _dripView  = [[MNDripView alloc] init];
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changedPositionAndColor:)];
    [_dripView addGestureRecognizer:panRecognizer];
    [_colorCircleView addSubview:_dripView];
    
    // animation to show or hidden the menu
    _dripBtn = [[UIButton alloc] initWithFrame:_dripView.bounds];
    [_dripBtn addTarget:self action:@selector(showMenuByButtonClick:) forControlEvents:UIControlEventTouchDown];
    [_dripBtn addTarget:self action:@selector(hiddenMenuByButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_dripView addSubview:_dripBtn];
    [_dripView bringSubviewToFront:_dripBtn];
    
    [self addSubview:_colorCircleView];
    
    // top line View
    _waterleftView = [[UIImageView alloc] init];
    _waterleftView.image = [UIImage imageNamed:@"water"];
    [self addSubview:_waterleftView];
    
    _waterRightView = [[UIImageView alloc] init];
    _waterRightView.image = [UIImage imageNamed:@"water_selected"];
    [self addSubview:_waterRightView];
    
    // saturation slider
    _saturationSlider = [[MNSlider alloc] init];
    [self setupSliderWithSliderName:@"saturationSlider"];
    [self addSubview:_saturationSlider];
    
    _sunleftView = [[UIImageView alloc] init];
    _sunleftView.image = [UIImage imageNamed:@"sun"];
    [self addSubview:_sunleftView];
    
    _sunRightView = [[UIImageView alloc] init];
    _sunRightView.image = [UIImage imageNamed:@"sun_selected"];
    [self addSubview:_sunRightView];
    
    _brightnessSlider = [[MNSlider alloc] init];
    [self setupSliderWithSliderName:@"brightnessSlider"];
    [self addSubview:_brightnessSlider];
    
    // pre selected color view
    _favoriteColorView = [[MNFavoriteColorView alloc] init];
    _favoriteColorView.backgroundColor = [UIColor whiteColor];
    
    // setup origin selected colors from local
    NSMutableArray *colorArray = [self getSelectedColorFromeArchiver];
    _favoriteColorView.preSelectColorArray = [colorArray mutableCopy];
    if (colorArray.count > 0) {
        _preColor = colorArray.firstObject;
        _color = _preColor;
    }
    
    __weak typeof(self) weakSelf = self;
    [_favoriteColorView preSelectColorBlock:^(UIColor *color) {
        weakSelf.color = color;
        [weakSelf updateColorAndViewPositionWithAnimation:YES];
        
        // return selected color
        [weakSelf revertSelectedColorByBlock];
    }];
    [self addSubview:_favoriteColorView];
}

- (void)setupSliderWithSliderName:(NSString *)sliderName
{
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint   = CGPointMake(1.0, 0.0);
    
    __weak typeof(self)  weakSelf = self;
    if ([sliderName isEqualToString:@"saturationSlider"]) {
        gradientLayer.frame = _saturationSlider.layer.bounds;
        [gradientLayer setColors:[self getMultiSaturationColorWithHue:_hue brightness:_brightness]];
        _saturationGradientLayer = gradientLayer;
        
        [_saturationSlider.vittaView.layer addSublayer:gradientLayer];
        [_saturationSlider sliderValueChangeBlock:^(CGFloat value, BOOL confirm) {
            weakSelf.confirm = confirm;
            [weakSelf changeColorBySaturation:weakSelf.saturationSlider];
        }];
        
    }else if ([sliderName isEqualToString:@"brightnessSlider"]){
        gradientLayer.frame = _brightnessSlider.layer.bounds;
        [gradientLayer setColors:[self getMultiBrightnessColorWithHue:_hue saturation:_saturation]];
        _brightnessGradientLayer = gradientLayer;
        
        [_brightnessSlider.vittaView.layer addSublayer:gradientLayer];
        [_brightnessSlider sliderValueChangeBlock:^(CGFloat value, BOOL confirm) {
            weakSelf.confirm = confirm;
            [weakSelf changeColorByBrightness:weakSelf.brightnessSlider];
        }];
    }
}

#pragma mark - layout subviews

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _preAngle = 0.0;
    _preTransformAngle = 0.0;
    
    CGFloat magin  = 80;
    CGSize size    = self.frame.size;
    CGFloat square = fmin(size.height, size.width);
    size           = CGSizeMake(square * 0.75, square * 0.75);
    CGFloat x      = (self.frame.size.width - size.width) * 0.5;
    _radius        = size.width * 0.5;

    // 设置小圆环在大圆环上
    _dripViewX     = _radius - 24;
    
    CGFloat radiusCenter = size.width - 84;
    
    // colour circle view
    _colorCircleView.frame = CGRectMake(x, 100, size.width, size.height);

    _colorView.frame       = CGRectMake(18, 18, size.width - 36, size.height - 36);
    _toplifeCircleView.frame = CGRectMake(20, 30, 80, 80);
    
    _centerCircleView.frame  = CGRectMake(0, 0, radiusCenter , radiusCenter);
    _centerCircleView.center = CGPointMake(_radius, _radius);
    _centerCircleView.layer.cornerRadius = radiusCenter/2;
    _centerCircleView.layer.masksToBounds = YES;
    _centerCircleView.backgroundColor = [UIColor whiteColor];
    
    // drip view
    _dripView.frame = CGRectMake(_dripViewX, 0, DripViewWithAndHeight, DripViewWithAndHeight);
    _dripBtn.frame  = _dripView.bounds;
    
    // line View & slider
    _waterleftView.frame      = CGRectMake(magin * 0.5 -25, CGRectGetMaxY(_colorCircleView.frame) + 30, 15, 15);
    
   
    
    _saturationSlider.frame = CGRectMake(magin * 0.5, CGRectGetMaxY(_colorCircleView.frame) + 30, self.frame.size.width - magin , 15);
    
    _waterRightView.frame      = CGRectMake(CGRectGetMaxX(_saturationSlider.frame) + 10, CGRectGetMaxY(_colorCircleView.frame) + 30,15, 15);
       
    
    _sunleftView.frame   = CGRectMake(magin * 0.5 -25, CGRectGetMaxY(_saturationSlider.frame) + 20, 15, 15);
    
    
    _brightnessSlider.frame = CGRectMake(magin * 0.5, CGRectGetMaxY(_saturationSlider.frame) + 20, self.frame.size.width - magin, 15);
    
      _sunRightView.frame   = CGRectMake(CGRectGetMaxX(_brightnessSlider.frame) + 10, CGRectGetMaxY(_saturationSlider.frame) + 20, 15, 15);
    
    
    _saturationGradientLayer.frame = _saturationSlider.bounds;
    _brightnessGradientLayer.frame = _brightnessSlider.layer.bounds;
    
    // pre selected color view
    _favoriteColorView.frame = CGRectMake(0, CGRectGetMaxY(_brightnessSlider.frame) + 30, self.frame.size.width, 35);
    
    [self updateColorAndViewPositionWithAnimation:NO];
}

#pragma mark - gesture recognizer action

- (void)changedPositionAndColor:(UIGestureRecognizer *)recognizer
{
    _confirm = NO;

    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            if ([MNMenuWindow shareMenuWindow].hidden) {
                [self changeMenuFrameAndValue];
                [MNMenuWindow animationToShowMenu];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{
            CGPoint point = [recognizer locationInView:_colorCircleView];
            CGFloat dx = point.x - self.radius;
            CGFloat dy = point.y - self.radius;
            CGFloat angle = atan2f(dy, dx);
            if (dy != 0) {
                angle += M_PI;
                _hue = angle / (2 * M_PI);
            } else if (dx > 0) {
                _hue = 0.5;
            }
            [self changeValue];
            [self changeMenuFrameAndValue];
            
            break;
        }
        case UIGestureRecognizerStateEnded: {
            _confirm = YES;
            [self changeValue];
            [self changeMenuFrameAndValue];
            [MNMenuWindow animationToHiddenMenu];
            
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark -  update Color and View Position

- (void)updateColorAndViewPositionWithAnimation:(BOOL)isAnimation
{
    // update hue, saturation, brightness, alpha
    [self.color getHue:&_hue saturation:&_saturation brightness:&_brightness alpha:&_alpha];
    
    self.toplifeCircleView.favoriteColorView.semiCircleColor = self.color;
    self.toplifeCircleView.colorView.semiCircleColor = self.color;
    
    // slider position and color
    [self.saturationSlider changeValue:_saturation animation:isAnimation];
    [self.brightnessSlider changeValue:_brightness animation:isAnimation];
    
    [self.saturationGradientLayer setColors:[self getMultiSaturationColorWithHue:_hue brightness:_brightness]];
    [self.brightnessGradientLayer setColors:[self getMultiBrightnessColorWithHue:_hue saturation:_saturation]];
    
    // dripView positon
    if (isAnimation) {
        [self changeDripViewPositionWithDuration:1.0]; // 修改过
    } else {
        [self changeDripViewPositionWithDuration:0.01];
    }
}

#pragma mark - slider action

- (void)changeColorBySaturation:(MNSlider *)slider
{
    _saturation = slider.value;
    [self changeColor];
}

- (void)changeColorByBrightness:(MNSlider *)slider
{
    _brightness = slider.value;
    [self changeColor];
}

- (void)changeColor
{
    _color = [UIColor colorWithHue:_hue saturation:_saturation brightness:_brightness alpha:_alpha];
    self.toplifeCircleView.colorView.semiCircleColor = _color;
    
    [self.saturationGradientLayer setColors:[self getMultiSaturationColorWithHue:_hue brightness:_brightness]];
    [self.brightnessGradientLayer setColors:[self getMultiBrightnessColorWithHue:_hue saturation:_saturation]];
    
    // return selected color
    [self revertSelectedColorByBlock];
}

- (NSArray *)getMultiSaturationColorWithHue:(CGFloat)hue brightness:(CGFloat)brightness
{
    return @[
             (id)[UIColor colorWithHue:hue saturation:0.0 brightness:brightness alpha:1.0].CGColor,
             (id)[UIColor colorWithHue:hue saturation:1.0 brightness:brightness alpha:1.0].CGColor
             ];
}

- (NSArray *)getMultiBrightnessColorWithHue:(CGFloat)hue  saturation:(CGFloat)saturation
{
    return @[
             (id)[UIColor colorWithHue:hue saturation:saturation brightness:0.0 alpha:1.0].CGColor,
             (id)[UIColor colorWithHue:hue saturation:saturation brightness:1.0 alpha:1.0].CGColor
             ];
}

#pragma mark - change value and position

- (void)changeValue
{
    [self changeDripViewPositionWithDuration:0.0];
    
    // current selected color
    [self changeColor];
    
    // slider color
    [self.saturationGradientLayer setColors:[self getMultiSaturationColorWithHue:_hue brightness:_brightness]];
    [self.brightnessGradientLayer setColors:[self getMultiBrightnessColorWithHue:_hue saturation:_saturation]];
}

- (void)changeDripViewPositionWithDuration:(CGFloat)duration
{
    CGFloat currentAngle = M_PI * 2 * _hue - M_PI;
    
    // prevent repeated clicks
    if (self.preAngle != 0 && currentAngle == self.preAngle) return;
    
    CGFloat cx = self.dripViewX * cos(currentAngle) + self.dripViewX;
    CGFloat cy = self.dripViewX * sin(currentAngle) + self.dripViewX;
    CGRect frame = self.dripView.frame;
    frame.origin.x = cx;
    frame.origin.y = cy;
    self.dripView.frame = frame;
    
    // dripView shadow
    CGFloat offsetX = 2 * cos(currentAngle);
    CGFloat offsetY = 2 * sin(currentAngle + M_PI);
    self.dripView.layer.shadowOffset  = CGSizeMake(offsetX, offsetY);
    self.dripView.layer.shadowRadius  = 4;
    self.dripView.layer.shadowOpacity = 0.2;
     
    // dripView animation
    CAKeyframeAnimation *positionAnimation = [[CAKeyframeAnimation alloc] init];
    positionAnimation.rotationMode = kCAAnimationRotateAuto;
    
    BOOL isClockwise = YES;
    if ((currentAngle < self.preAngle && currentAngle - self.preAngle > - M_PI) || (currentAngle - self.preAngle > M_PI)) {
        isClockwise = NO;
        positionAnimation.rotationMode = kCAAnimationRotateAutoReverse;
    }
    positionAnimation.keyPath = @"position";
    positionAnimation.path = [UIBezierPath bezierPathWithArcCenter:_centerCircleView.center
                                                            radius:self.dripViewX
                                                        startAngle:self.preAngle
                                                          endAngle:currentAngle
                                                         clockwise:isClockwise].CGPath;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    positionAnimation.repeatCount = 1;
    positionAnimation.duration = duration;
    positionAnimation.fillMode = kCAFillModeBoth;
    positionAnimation.removedOnCompletion = NO;
    [self.dripView.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
    
    self.preAngle = currentAngle;
}

- (void)changePreColor:(UITapGestureRecognizer *)recognizer
{
    self.color = self.toplifeCircleView.favoriteColorView.semiCircleColor;
    [self updateColorAndViewPositionWithAnimation:YES];
    
    // return selected color
    [self revertSelectedColorByBlock];
}

#pragma mark - menu

- (void)hiddenMenuByButtonClick:(UIButton *)button {
    [MNMenuWindow animationToHiddenMenu];
}

- (void)showMenuByButtonClick:(UIButton *)button {
    [self changeMenuFrameAndValue];
    [MNMenuWindow animationToShowMenu];
}

- (void)changeMenuFrameAndValue
{
    CGPoint origin = [[MNMenuWindow shareMenuWindow] convertPoint:self.dripView.center fromView:self.dripView.superview];
    CGRect dripFrame = self.dripView.frame;
    CGRect menuFrame = [MNMenuWindow shareMenuWindow].frame;
    menuFrame.origin.x = origin.x - dripFrame.size.width;
    menuFrame.origin.y = origin.y - menuFrame.size.height - 20;
    
    [[MNMenuWindow shareMenuWindow] updateWithFrame:menuFrame];
    [MNMenuWindow shareMenuWindow].titleLabel.text = [NSString stringWithFormat:@"%.0f°",_hue * 360];
}

#pragma mark - save and get selected color frome archiver

- (void)saveSelectedColorsToArchiver
{
    self.color = self.toplifeCircleView.colorView.semiCircleColor;
    
    // remove the same color in array
    for (int i = 0; i < self.favoriteColorView.preSelectColorArray.count; i++) {
        UIColor *color = self.favoriteColorView.preSelectColorArray[i];
        if (CGColorEqualToColor(self.color.CGColor, color.CGColor)) {
            [self.favoriteColorView.preSelectColorArray removeObject:color];
        }
    }
    
    // array count max 5
    if (self.favoriteColorView.preSelectColorArray.count >= 5) {
        [self.favoriteColorView.preSelectColorArray removeLastObject];
    }
    [self.favoriteColorView.preSelectColorArray insertObject:self.color atIndex:0];
    [self.favoriteColorView updateSelectedColor];
    
    // archiver
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"preColor.archiver"];
    
    BOOL isSuccess = [NSKeyedArchiver archiveRootObject:self.favoriteColorView.preSelectColorArray toFile:path];
    if (!isSuccess) {
        NSLog(@"It's archiver selected color error");
    }
}

- (NSMutableArray *)getSelectedColorFromeArchiver
{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"preColor.archiver"];
    NSMutableArray *preColor = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (preColor) {
        return [preColor mutableCopy];
    }
    return [NSMutableArray array];
}

+ (void)cleanSelectedColorsInArchiver
{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"preColor.archiver"];
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager fileExistsAtPath:path]) {
        [defaultManager removeItemAtPath:path error:nil];
    }
}

#pragma mark - block

- (void)colorSelectedBlock:(void (^)(UIColor *, BOOL))colorSelectedBlock {
    if (colorSelectedBlock) {
        self.colorSelectedBlock = colorSelectedBlock;
    }
}

- (void)revertSelectedColorByBlock {
    if (self.colorSelectedBlock) {
        self.colorSelectedBlock(self.color, self.isConfirm);
    }
}


@end
