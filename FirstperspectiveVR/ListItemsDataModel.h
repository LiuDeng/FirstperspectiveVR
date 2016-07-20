//
//  ListItemsDataModel.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListDetailModel.h"
@interface ListItemsDataModel : NSObject
@property (nonatomic, strong) NSString *total;//	String	6
@property (nonatomic, strong) NSString *res_id;//	String	444172
@property (nonatomic, strong) NSString *layout_type;//	String	global-banner
@property (nonatomic, strong) NSString *has_more;//	String	0
@property (nonatomic, strong) NSString *title;//	String	推荐页轮播图（IOS）
@property (nonatomic, strong) NSArray *list;//	Array
@property (nonatomic, strong) NSString *url;//	String
@property (nonatomic, strong) NSString *more_url;

+ (instancetype) listItemsDataModelWithDictionary :(NSDictionary *)dict;
- (instancetype) initWithDictionary :(NSDictionary *)dict;
@end
