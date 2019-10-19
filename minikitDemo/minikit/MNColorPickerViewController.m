//
//  MNColorPickerViewController.m
//  minikit
//
//  Created by dongshangtong on 2019/10/20.
//  Copyright © 2019 dongshangtong. All rights reserved.
//

#import "MNColorPickerViewController.h"
#import "MNColorPickerView.h"
@interface MNColorPickerViewController ()

@property (nonatomic, strong) UIColor *currentSelectedColor;
@property (nonatomic, strong) MNColorPickerView *colorPickerView;


@property (strong, nonatomic) UIView *contentView;

@end

@implementation MNColorPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.view.backgroundColor = [UIColor whiteColor];
        CGSize p_size = [UIScreen mainScreen].bounds.size;
        
        CGFloat p_width = p_size.width;
        
        CGFloat p_height = p_size.height;
        
        _contentView = [[UIView alloc]init];
        _contentView.frame = CGRectMake(50, 60,p_width -100 , p_height -120);
        [self.view addSubview:_contentView];
        _contentView.backgroundColor = [UIColor whiteColor];
        
        
        /// color picker view
        _colorPickerView = [[MNColorPickerView alloc] initWithFrame:CGRectMake(0, 0, p_width -100, p_height -120)];
        [_contentView addSubview:_colorPickerView];
        
        /// selected color preview
    //    _currentSelectedColorPreview.backgroundColor = _colorPickerView.preColor;
        
        /// selected color block
        __weak typeof(self) weakSelf = self;
        [_colorPickerView colorSelectedBlock:^(UIColor *color, BOOL isConfirm) {
            /// do something...
            ///
    //        weakSelf.currentSelectedColorPreview.backgroundColor = color;
            weakSelf.currentSelectedColor = color;
        }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
