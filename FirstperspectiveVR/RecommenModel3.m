//
//  RecommenModel3.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "RecommenModel3.h"
#import "Key.h"

@implementation RecommenModel3

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        _column_id = dict[KColumn_id];
        _brief = dict[KBrief];
        _movie_name = dict[KMovie_name];
        _sort = dict[Ksort];
        _movie_id = dict[KMovie_id];
        _coop_movieid = dict[KCoop_movieid];
    }
    return self;
}

+ (instancetype)recommenModel3WithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}

@end
