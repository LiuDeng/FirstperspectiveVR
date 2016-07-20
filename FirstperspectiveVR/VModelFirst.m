//
//  VModelFirst.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "VModelFirst.h"
#import "VDataModel.h"
//@property(nonatomic,strong)NSString* status;
//@property(nonatomic,strong)NSString* status_msg;
//@property(nonatomic,strong)NSString* version;
//@property(nonatomic,strong)NSString* channel;
//@property(nonatomic,strong)NSString* date;
//@property(nonatomic,strong)NSString* language;
//@property(nonatomic,strong)NSString* data_type;
//@property(nonatomic,strong)VDataModel* data;
@implementation VModelFirst
- (instancetype)initWithDictionary:(NSDictionary*)dic{
    if (self=[super init]) {
        _status=dic[@"status"];
        _status_msg=dic[@"status_msg"];
        _version=dic[@"version"];
        _channel=dic[@"channel"];
        _date=dic[@"date"];
        _language=dic[@"language"];
        _data_type=dic[@"data_type"];
        _data=[VDataModel ModelWithDictionary:dic[@"data"]];
    }
    return self;
};


+ (instancetype)ModelWithDictionary:(NSDictionary*)dic{
    return [[self alloc]initWithDictionary:dic];
};
@end
