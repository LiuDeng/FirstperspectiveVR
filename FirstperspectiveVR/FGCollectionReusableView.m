//
//  FGCollectionReusableView.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FGCollectionReusableView.h"


@interface FGCollectionReusableView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;


@end

@implementation FGCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    [_moreButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    // Initialization code
}

- (void)setListItemsDataModel:(ListItemsDataModel *)listItemsDataModel{
    _listItemsDataModel = listItemsDataModel;
    _titleLabel.text = listItemsDataModel.title;
    if ([listItemsDataModel.has_more integerValue]) {
        _moreButton.hidden =NO;
    }else{
        _moreButton.hidden =YES;
    }
}

- (void)btnClick{
    if (_moreBtnClick) {
        _moreBtnClick();
    }else{
        NSLog(@"dasdasd");
    }
}

@end
