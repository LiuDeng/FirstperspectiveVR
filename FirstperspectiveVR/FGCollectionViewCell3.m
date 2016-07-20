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



- (void)setListDetailModel:(ListDetailModel *)listDetailModel{
    _listDetailModel = listDetailModel;
    NSString *imageUrl = listDetailModel.pic_url;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"social-placeholder"]];
    _titleLabel.text = listDetailModel.title;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
