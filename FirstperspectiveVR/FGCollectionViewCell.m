//
//  FGCollectionViewCell.m
//  
//
//  Created by qingyun on 16/7/8.
//
//

#import "FGCollectionViewCell.h"
#import "ListDetailModel.h"
#import "UIImageView+WebCache.h"

@interface FGCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation FGCollectionViewCell

- (void)setListDetailModel:(ListDetailModel *)listDetailModel{
    _listDetailModel = listDetailModel;
    NSString *imageUrl = listDetailModel.pic_url;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"social-user"]];
    _titleLabel.text = listDetailModel.title;
    _subtitleLabel.text =listDetailModel.subtitle;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
