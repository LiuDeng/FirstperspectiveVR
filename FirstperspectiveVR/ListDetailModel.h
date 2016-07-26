//
//  ListDetailModel.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListDetailModel : NSObject
@property (nonatomic, strong) NSString *payment_count;//	String	0.0
@property (nonatomic, strong) NSString *operation_type;//	String	0
@property (nonatomic, strong) NSString *category_type;//	String	0
@property (nonatomic, strong) NSArray *banner;//	Array
@property (nonatomic, strong) NSString *title;//	String	《Hello！ 女神》王思聪与美女泥潭戏猪
@property (nonatomic, strong) NSString *type;//	String	8
@property (nonatomic, strong) NSString *url;//	String	1/special/445541.js
@property (nonatomic, strong) NSString *headwear;//	String	0
@property (nonatomic, strong) NSString *payment_type;//	String	0
@property (nonatomic, strong) NSString *subtype;//	String	0
@property (nonatomic, strong) NSString *res_id;//	String	445541
@property (nonatomic, strong) NSString *subtitle;//	String
@property (nonatomic, strong) NSString *pic_url;//	String	http://res.static.mojing.cn//upload/676d2/14/c2a56cc6.jpg
@property (nonatomic, strong) NSString *is_pay;//	String	0

+ (instancetype)listDetailModelWithDictionary :(NSDictionary *)dict;
- (instancetype)initWithDictionary :(NSDictionary *)dict;
@end
