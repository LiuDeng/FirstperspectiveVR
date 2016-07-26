//
//  RecommendModel.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "RecommendModel.h"
#import "DictKey.h"
@implementation RecommendModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        _way = [dict[KWay] boolValue];
        _status = dict[KStatus];
        _status_msg = dict[KStatus_msg];
        _version = dict[KVersion];
        _channel = dict[KChanel];
        _date = dict[KDate];
        _language = dict[KLanguage];
        _data_type = dict[KData_type];
        if (_way) {
            ListItemsDataModel *listItemsDataModel = [ListItemsDataModel listItemsDataModelWithDictionary :dict[KData]];
            _data = @[listItemsDataModel];
        }else
        if ([dict[KData] isKindOfClass:[NSObject class]]) {
            NSArray *dataArr = dict[KData][KList];
            NSMutableArray *mArr = [NSMutableArray array];
            for (NSDictionary *dict1 in dataArr) {
                ListItemsDataModel *listItemsDataModel = [ListItemsDataModel listItemsDataModelWithDictionary :dict1];
                [mArr addObject:listItemsDataModel];
            }
            _data = mArr;
        }
    }
    return self;
}



+ (instancetype)recommendModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}
@end
