//
//  FGUrlDate.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FGUrlDate : NSObject

@property (nonatomic, strong) void(^reLoadDateOfView)();
+ (instancetype)FGUrlDateIsOneWithUrl :(NSString*)url;
- (instancetype)initWithUrl : (NSString *)url;
@end
