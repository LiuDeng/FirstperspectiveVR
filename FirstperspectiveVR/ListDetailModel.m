//
//  ListDetailModel.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ListDetailModel.h"
#import "DictKey.h"
@implementation ListDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        _payment_count = dict[KPayment_count];
        _operation_type = dict[KOperation_type];
        _category_type = dict[KCategory_type];
        _banner = dict[KBanner];
        _title = dict[KTitle];
        _type = dict[KType];
        _url = dict[KUrl];
        _headwear = dict[KHeadwear];
        _payment_type = dict[KPayment_type];
        _subtype = dict[KSubtype];
        _res_id = dict[KRes_id];
        _subtitle = dict[KSubtitle];
        _pic_url = dict[KPic_url];
        _is_pay = dict[KIs_pay];
    }
    return self;
}
+ (instancetype)listDetailModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}
@end
