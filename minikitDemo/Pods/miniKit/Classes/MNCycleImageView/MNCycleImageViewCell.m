//
//  MNCycleImageViewCell.m
//  takeCar
//
//  Created by dongshangtong on 2019/7/27.
//  Copyright © 2019 yue.com. All rights reserved.
//

#define kPageControl_H      40

#define kCellIdentifier     @"MNCycleImageViewCell"


#import "MNCycleImageViewCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@interface MNCycleImageViewCell()

//@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic)UIImageView *ccimage;
@end

@implementation MNCycleImageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithFrame:(CGRect)fram{
    self = [super initWithFrame:fram];
    
    if (self) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    
    UIImageView *ccimage = [[UIImageView alloc]init];
    [self.contentView addSubview:ccimage];
     __weak typeof (self) weakSelf = self;
    _ccimage = ccimage;
    [ccimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.contentView);
    }];
    
    
}


- (void)setImage:(NSString *)image
{
    _image = image;
    if ([image containsString:@"http"]) {
        [_ccimage sd_setImageWithURL:[NSURL URLWithString:image]];
    }else{
     self.ccimage.image = [UIImage imageNamed:image];
    }
    
}

@end
