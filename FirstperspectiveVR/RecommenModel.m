//
//  RecommenModel.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "RecommenModel.h"
#import "Key.h"

@implementation RecommenModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        _banner_pic_path = dic[KBanner_pic_path];
        _banner_res_id = dic[KBanner_Res_id];
        _banner_type = dic[KBanner_type];
        _banner_sort = dic[KBanner_sort];
        _banner_subtitle = dic[KBanner_subtitle];
        _banner_title = dic[KBanner_title];
        _banner_link = dic[KBanner_link];
    }
    return self;
}

+ (instancetype)recommenModelWithDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDictionary:dic];
}
@end
