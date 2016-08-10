//
//  DownLoadTool.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DownLoadList;
@class AFURLSessionManager;
@interface DownLoadTool : NSObject
@property(nonatomic,strong)NSMutableArray* downLoadListAry;
@property(nonatomic,strong)DownLoadList* downLoadList;
+(DownLoadTool *)shareDownloadHandle;
-(DownLoadList*)createDownloadWithUrl:(NSString *)urlst name:(NSString*)name;
-(DownLoadList*)pauseDownloadWithUrl:(NSString *)urlst;
-(DownLoadList*)resumeDownloadWithUrl:(NSString *)urlst;
-(void)cancelDownloadWithUrl:(NSString *)urlst;
-(DownLoadList *)downLoadList:(NSString *)urlst;
@end
