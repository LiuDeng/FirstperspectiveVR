//
//  FGCollectionViewCell2.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FGCollectionViewCell2.h"
#import "RecommenModel2.h"
#import "UIImageView+WebCache.h"

@interface FGCollectionViewCell2 ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation FGCollectionViewCell2

- (void)setRecommenModel2:(RecommenModel2 *)recommenModel2{
    _recommenModel2 = recommenModel2;
    NSString *imageUrl = recommenModel2.res_thumb;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"social-user"]];
    _titleLabel.text = recommenModel2.res_title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
