//
//  DownLoadList.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DownLoadList : NSObject
@property(nonatomic,strong)NSProgress* progress;
@property(nonatomic,strong)NSString* urlstr;
@property(nonatomic,strong)NSURLSessionDownloadTask* task;
@property(nonatomic)BOOL iscomplete;
@property(nonatomic)BOOL isdownloading;
@end
