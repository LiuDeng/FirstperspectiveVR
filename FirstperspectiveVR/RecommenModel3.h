//
//  RecommenModel3.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommenModel3 : NSObject

@property (nonatomic, strong)NSString *column_id;
@property (nonatomic, strong)NSString *brief;
@property (nonatomic, strong)NSString *movie_name;
@property (nonatomic, strong)NSString *sort;
@property (nonatomic, strong)NSString *movie_id;
@property (nonatomic, strong)NSString *coop_movieid;

- (instancetype)initWithDictionary :(NSDictionary*)dict;
+ (instancetype)recommenModel3WithDictionary :(NSDictionary*)dict;

@end
