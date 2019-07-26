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

@interface MNCycleImageViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation MNCycleImageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setImage:(NSString *)image
{
    _image = image;
    if ([image containsString:@"http"]) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:image]];
    }else{
     self.imageView.image = [UIImage imageNamed:image];
    }
    
}

@end
