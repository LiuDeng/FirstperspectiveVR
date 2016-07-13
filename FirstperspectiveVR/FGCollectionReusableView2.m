//
//  FGCollectionReusableView2.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FGCollectionReusableView2.h"
#import "RecommenModel.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

#define IMAGEX  _imageViewScrollView.frame.size.width
#define IMAGEWIDTH  _imageViewScrollView.frame.size.width
#define IMAGEHEIGHT  _imageViewScrollView.frame.size.height

@interface FGCollectionReusableView2 ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *imageViewScrollView;//滚动视图
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//主要标题
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;//副标题
@end

@implementation FGCollectionReusableView2



- (void)setRecommenModel:(RecommenModel *)recommenModel{
    _recommenModel = recommenModel;
    _titleLabel.text = recommenModel.banner_title;
    _subtitleLabel.text = recommenModel.banner_subtitle;
}

- (void)setModelArr:(NSArray *)modelArr{
    _modelArr = modelArr;
    for (int i = 0 ; i < 6; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imageViewScrollView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(IMAGEWIDTH, IMAGEHEIGHT));
            make.left.mas_equalTo(IMAGEWIDTH*i);
            make.top.mas_equalTo(0);
            make.center.equalTo(_imageViewScrollView);
        }];
        [imageView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(imageView);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
        [btn addTarget:self action:@selector(imageViewclickBtn) forControlEvents:UIControlEventTouchUpInside];
        if ([modelArr[i] isKindOfClass:[RecommenModel class]]) {
            _recommenModel = modelArr[i];
        }
        NSString *avatarImageUrl = _recommenModel.banner_pic_path;
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:avatarImageUrl] placeholderImage:[UIImage imageNamed:@"social-placeholder"]];
    }
    
}

//点击事件
- (void)imageViewclickBtn{
    
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger i = 0;
    if (IMAGEWIDTH+20>scrollView.contentOffset.x>0) {
        i = 1 ;
        [self setRecommenModel:_modelArr[i]];
        return;
    }else
        i = scrollView.contentOffset.x/IMAGEWIDTH;
    [self setRecommenModel:_modelArr[i]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    _imageViewScrollView.contentOffset = CGPointMake(0, 0);
    _imageViewScrollView.contentSize = CGSizeMake(IMAGEWIDTH*6, IMAGEHEIGHT);
    _imageViewScrollView.pagingEnabled = YES;
    _imageViewScrollView.delegate = self;
    // Initialization code
}

@end
