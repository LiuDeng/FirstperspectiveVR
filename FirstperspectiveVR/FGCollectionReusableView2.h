//
//  FGCollectionReusableView2.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListDetailModel;
@interface FGCollectionReusableView2 : UICollectionReusableView
@property (nonatomic, strong) ListDetailModel *listDetailModel;
@property (nonatomic, strong) NSArray *modelArr;
@end
