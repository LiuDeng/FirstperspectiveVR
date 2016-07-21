//
//  VModelSecond.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "VDataModel.h"
#import "LandScapeUrlModel.h"
//#import "VAttrsModel.h"
//@property(nonatomic,strong)NSString* payment_count;
//@property(nonatomic,strong)NSString* operation_type;
//@property(nonatomic,strong)NSString* source;
//@property(nonatomic,strong)NSString* title;
//@property(nonatomic,strong)NSString* type;
//@property(nonatomic,strong)NSString* score_count;
//@property(nonatomic,strong)NSString* duration;
//@property(nonatomic,strong)NSString* score;
//@property(nonatomic,strong)NSString* headwear;
//@property(nonatomic,strong)NSString* subtype;
//@property(nonatomic,strong)NSString* res_id;
//@property(nonatomic,strong)NSString* subtitle_file;
//@property(nonatomic,strong)NSString* is_panorama;
//@property(nonatomic,strong)NSString* video_dimension;
//@property(nonatomic,strong)NSString* download_count;
//@property(nonatomic,strong)NSString* payment_type;
//@property(nonatomic,strong)NSString* pov_heading;
//@property(nonatomic,strong)NSString* size;
//@property(nonatomic,strong)NSString* subtitle;
//@property(nonatomic,strong)NSString* video_is_live;
//@property(nonatomic,strong)NSString* is_pay;
//@property(nonatomic,strong)NSString* desc;
@implementation VDataModel
- (instancetype)initWithDictionary:(NSDictionary*)dic{
    if (self=[super init]) {
        self.payment_count=dic[@"payment_count"];
        self.operation_type=dic[@"operation_type"];
        self.source=dic[@"source"];
        self.desc=dic[@"desc"];
        self.is_pay=dic[@"is_pay"];
        self.video_is_live=dic[@"video_is_live"];
        self.subtitle=dic[@"subtitle"];
        self.size=dic[@"size"];
        self.pov_heading=dic[@"pov_heading"];
        self.payment_type=dic[@"payment_type"];
        self.download_count=dic[@"download_count"];
        self.video_dimension=dic[@"video_dimension"];
        self.is_panorama=dic[@"is_panorama"];
        self.subtitle_file=dic[@"subtitle_file"];
        self.res_id=dic[@"res_id"];
        self.subtype=dic[@"subtype"];
        self.headwear=dic[@"headwear"];
        self.score=dic[@"score"];
        self.duration=dic[@"duration"];
        self.score_count=dic[@"score_count"];
        self.type=dic[@"type"];
        self.title=dic[@"title"];
        self.source=dic[@"source"];
        self.operation_type=dic[@"operation_type"];
        self.payment_count=dic[@"payment_count"];
        //Array
        NSMutableArray* video_attrsAry=[NSMutableArray array];
        for (NSDictionary* dict in dic[@"video_attrs"]) {
            VAttrsModel* vAttrsmodel=[VAttrsModel ModelWithDictionary:dict];
            [video_attrsAry addObject:vAttrsmodel];
        }
        _video_attrs=video_attrsAry;
        _screenshot=dic[@"screenshot"];
        _thumb_pic_url=dic[@"thumb_pic_url"];
        _extra=dic[@"extra"];
        _landscape_url=[LandScapeUrlModel ModelWithDictionary:dic[@"landscape_url"]];
    }
    
    return self;
};


+ (instancetype)ModelWithDictionary:(NSDictionary*)dic{
    return [[self alloc]initWithDictionary:dic];
};
@end
