//
//  FGCollectionViewCell3.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FGCollectionViewCell3.h"
#import "UIImageView+WebCache.h"


@interface FGCollectionViewCell3 ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FGCollectionViewCell3

- (void)setRecommenModel3:(RecommenModel3 *)recommenModel3{
    _recommenModel3 = recommenModel3;
    _titleLabel.text = recommenModel3.movie_name;
}

- (void)setVideoModel:(VideoModel *)videoModel{
    _videoModel = videoModel;
    NSString *imageurl = videoModel.pic;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"social-placeholder"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
