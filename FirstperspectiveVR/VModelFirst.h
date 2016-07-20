//
//  VModelFirst.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VDataModel;
@interface VModelFirst : NSObject
@property(nonatomic,strong)NSString* status;
@property(nonatomic,strong)NSString* status_msg;
@property(nonatomic,strong)NSString* version;
@property(nonatomic,strong)NSString* channel;
@property(nonatomic,strong)NSString* date;
@property(nonatomic,strong)NSString* language;
@property(nonatomic,strong)NSString* data_type;
@property(nonatomic,strong)VDataModel* data;
- (instancetype)initWithDictionary:(NSDictionary*)dic;
+ (instancetype)ModelWithDictionary:(NSDictionary*)dic;
@end
