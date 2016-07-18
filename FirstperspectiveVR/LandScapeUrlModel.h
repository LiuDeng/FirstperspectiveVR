//
//  LandScapeUrlModel.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LandScapeUrlModel : NSObject
@property(nonatomic,strong)NSString* nav;
@property(nonatomic,strong)NSString* contents;
- (instancetype)initWithDictionary:(NSDictionary*)dic;
+ (instancetype)ModelWithDictionary:(NSDictionary*)dic;

@end
