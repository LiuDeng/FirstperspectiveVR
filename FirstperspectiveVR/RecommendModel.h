//
//  RecommendModel.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListItemsDataModel.h"
@interface RecommendModel : NSObject
@property (nonatomic, strong) NSString *status;	//String	0
@property (nonatomic, strong) NSString *status_msg;//	String	ok
@property (nonatomic, strong) NSString *version;//	String	160630
@property (nonatomic, strong) NSString *channel;//	String	1
@property (nonatomic, strong) NSString *date;//	String	1468584840
@property (nonatomic, strong) NSString *language;//	String	zh
@property (nonatomic, strong) NSString *data_type;//	String	1
@property (nonatomic, strong) NSArray *data;//	Object
@property (nonatomic) BOOL way;

+ (instancetype) recommendModelWithDictionary :(NSDictionary *)dict;
- (instancetype) initWithDictionary :(NSDictionary *)dict;
@end
