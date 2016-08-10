//
//  DownLoadTool.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DownLoadTool.h"
#import "AFNetworking.h"
#import "DownLoadList.h"
@interface DownLoadTool ()
@property(nonatomic,strong)DownLoadList* currentModel;
@end
@implementation DownLoadTool
static DownLoadTool *new;
static AFURLSessionManager* manager;
+ (DownLoadTool *)shareDownloadHandle{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        new=[self new];
        manager=[[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return new;
}
-(DownLoadList *)downLoadList:(NSString *)urlst{
        if (_downLoadListAry.count!=0) {
            for (DownLoadList*model in _downLoadListAry) {
                if ([model.urlstr isEqualToString:urlst]) {
                    _downLoadList=model;
                    return _downLoadList;
                }
            }
        }
    
    return nil;
}
-(NSMutableArray *)downLoadListAry{
    if (!_downLoadListAry) {
        _downLoadListAry=[NSMutableArray array];
    }
    return _downLoadListAry;
}

- (DownLoadList*)createDownloadWithUrl:(NSString *)urlst name:(NSString *)name{
    //1.创建URl
    NSURL *url=[NSURL URLWithString:urlst];
            //2.创建Request请求
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    //3.创建模型
    _currentModel=[DownLoadList new];
    _currentModel.urlstr=urlst;
    //4.创建下载任务
    NSURLSessionDownloadTask* task=[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _currentModel.progress=downloadProgress;
            [[DownLoadTool shareDownloadHandle] downLoadList:urlst].progress=downloadProgress;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:[NSString stringWithFormat:@"/Users/qingyun/Desktop/%@.MP4",name]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"下载失败原因:%@",error);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                _currentModel.iscomplete=YES;
          });
        }
    }];
    [task resume];
    _currentModel.isdownloading=YES;
    _currentModel.task=task;
    [self.downLoadListAry addObject:_currentModel];
    return _currentModel;
}

-(DownLoadList*)pauseDownloadWithUrl:(NSString *)urlst{
    DownLoadList* model=[DownLoadList new];
    for (model in self.downLoadListAry) {
        if ([urlst isEqualToString:model.urlstr]) {
            [model.task suspend];
            model.isdownloading=NO;
            return model;
        }
    }
    return model;
}

-(DownLoadList*)resumeDownloadWithUrl:(NSString *)urlst{
    DownLoadList* model=[DownLoadList new];
    for (model in self.downLoadListAry) {
        if ([urlst isEqualToString:model.urlstr]) {
            [model.task resume];
            model.isdownloading=YES;
            return model;
        }
    }
    return model;
}

-(void)cancelDownloadWithUrl:(NSString *)urlst{
    DownLoadList* model=[DownLoadList new];
    for (model in self.downLoadListAry) {
        if ([urlst isEqualToString:model.urlstr]) {
            [model.task cancel];
            [self.downLoadListAry removeObject:model];
        }
    }
}

@end
