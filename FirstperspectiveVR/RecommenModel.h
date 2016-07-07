//
//  RecommenModel.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommenModel : NSObject

@property (nonatomic, strong)NSString *banner_pic_path;//图片网址
@property (nonatomic, strong)NSString *banner_res_id;//获取资源参数码
@property (nonatomic, strong)NSString *banner_type;
@property (nonatomic, strong)NSString *banner_sort;
@property (nonatomic, strong)NSString *banner_subtitle;//副标题
@property (nonatomic, strong)NSString *banner_title;//主标题
@property (nonatomic, strong)NSString *banner_link;//跳转链接

- (instancetype)initWithDictionary:(NSDictionary*)dic;
+ (instancetype)recommenModelWithDictionary:(NSDictionary*)dic;

@end
