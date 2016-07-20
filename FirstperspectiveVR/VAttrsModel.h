//
//  VAttrsModel.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
//definition_id	String	5
//size	String	65MB
//play_url	String	http://dl.mojing.cn/xianchang/160707/1467865137_44_BD.mp4
//definition_name	String	1080
//download_url	String	http://dl.mojing.cn/xianchang/160707/1467865137_44_BD.mp4
@interface VAttrsModel : NSObject
@property(nonatomic,strong)NSString* definition_id;
@property(nonatomic,strong)NSString* size;
@property(nonatomic,strong)NSString* play_url;
@property(nonatomic,strong)NSString* definition_name;
@property(nonatomic,strong)NSString* download_url;
- (instancetype)initWithDictionary:(NSDictionary*)dic;
+ (instancetype)ModelWithDictionary:(NSDictionary*)dic;
@end
