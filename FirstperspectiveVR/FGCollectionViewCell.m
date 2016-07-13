//
//  FGCollectionViewCell.m
//  
//
//  Created by qingyun on 16/7/8.
//
//

#import "FGCollectionViewCell.h"
#import "RecommenModel.h"
#import "UIImageView+WebCache.h"

@interface FGCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation FGCollectionViewCell

- (void)setRecommentModel:(RecommenModel *)recommentModel{
    _recommentModel = recommentModel;
    NSString *imageUrl = recommentModel.banner_pic_path;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"social-user"]];
    _titleLabel.text = recommentModel.banner_title;
    _subtitleLabel.text = recommentModel.banner_subtitle;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
