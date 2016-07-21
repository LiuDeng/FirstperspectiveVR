//
//  VModelSecond.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LandScapeUrlModel;
#import "VAttrsModel.h"
//@class VAttrsModel;
//payment_count	String	0.0
//operation_type	String	3
//video_attrs	Array
//source	String	暴风魔镜
//screenshot	Array
//title	String	E罩杯健身舞王
//type	String	4
//score_count	String	0
//thumb_pic_url	Array
//duration	String	138
//score	String	9.2
//headwear	String	0
//subtype	String	0
//res_id	String	444309
//extra	Array
//subtitle_file	String
//is_panorama	String	2
//landscape_url	Object
//video_dimension	String	1
//download_count	String	0
//payment_type	String	0
//pov_heading	String	180
//size	String	0Byte
//subtitle	String	金刚芭比秀肌肉
//video_is_live	String	0
//is_pay	String	0
//desc	String	柏堂静,上海知名健身教练，曾获香港、亚洲健身健美锦标赛的冠军。协调匀称的身体比例，并拥有E罩杯的傲人上围，被誉为零脂肪最美健身舞王。
@interface VDataModel : NSObject
@property(nonatomic,strong)NSString* payment_count;
@property(nonatomic,strong)NSString* operation_type;
@property(nonatomic,strong)NSString* source;
@property(nonatomic,strong)NSString* title;
@property(nonatomic,strong)NSString* type;
@property(nonatomic,strong)NSString* score_count;
@property(nonatomic,strong)NSString* duration;
@property(nonatomic,strong)NSString* score;
@property(nonatomic,strong)NSString* headwear;
@property(nonatomic,strong)NSString* subtype;
@property(nonatomic,strong)NSString* res_id;
@property(nonatomic,strong)NSString* subtitle_file;
@property(nonatomic,strong)NSString* is_panorama;
@property(nonatomic,strong)NSString* video_dimension;
@property(nonatomic,strong)NSString* download_count;
@property(nonatomic,strong)NSString* payment_type;
@property(nonatomic,strong)NSString* pov_heading;
@property(nonatomic,strong)NSString* size;
@property(nonatomic,strong)NSString* subtitle;
@property(nonatomic,strong)NSString* video_is_live;
@property(nonatomic,strong)NSString* is_pay;
@property(nonatomic,strong)NSString* desc;
//ARY
@property(nonatomic,strong)NSArray* video_attrs;
@property(nonatomic,strong)NSArray* screenshot;
@property(nonatomic,strong)NSArray* thumb_pic_url;
@property(nonatomic,strong)NSArray* extra;
//dic
@property(nonatomic,strong)LandScapeUrlModel* landscape_url;
- (instancetype)initWithDictionary:(NSDictionary*)dic;
+ (instancetype)ModelWithDictionary:(NSDictionary*)dic;

@end
