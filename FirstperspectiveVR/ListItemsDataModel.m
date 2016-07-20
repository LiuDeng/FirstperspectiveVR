//
//  ListItemsDataModel.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ListItemsDataModel.h"
#import "DictKey.h"

@implementation ListItemsDataModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        _total = dict[KTotal];
        _res_id = dict[KRes_id];
        _layout_type = dict[KLayout_type];
        _has_more = dict[KHas_more];
        _title = dict[KTitle];
//        [self setValuesForKeysWithDictionary:dict];
        //解析List数组数据
        if ([dict[KList] isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = [NSMutableArray array];
            for (NSDictionary *dict1 in dict[KList]) {
                ListDetailModel *listDetailModel = [ListDetailModel listDetailModelWithDictionary:dict1];
                [mArr addObject:listDetailModel];
            }
            _list = mArr;
        }
        _url = dict[KUrl];
    }
    return self;
}
+ (instancetype)listItemsDataModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}
@end
