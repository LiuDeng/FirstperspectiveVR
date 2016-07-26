//
//  MoreCollectionViewController.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListItemsDataModel.h"
@interface MoreCollectionViewController : UICollectionViewController
@property (nonatomic ) BOOL isHideen;
@property (nonatomic, strong) ListItemsDataModel *listItemsDataModel;
@end
