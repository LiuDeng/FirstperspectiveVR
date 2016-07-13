//
//  FGUrlDate.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FGUrlDate.h"
#import "AFNetWorking.h"
#import "Key.h"

@interface FGUrlDate ()
@property (nonatomic, strong)AFHTTPSessionManager *sessionManager;
@end

@implementation FGUrlDate
static NSString *Klist = @"list";
static NSString *Kcolumns = @"columns";


- (AFHTTPSessionManager *)sessionManager{
    if (!_sessionManager) {
        //创建manager对象
        _sessionManager = [AFHTTPSessionManager manager];
        //设置网络监听
        _sessionManager.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        __weak AFNetworkReachabilityManager *reachManager=_sessionManager.reachabilityManager;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/x-javascript", nil];
        
        //设置监听回调函数
        [_sessionManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            //显示监听状态
            NSLog(@"=====当前网络状态=%@",[reachManager localizedNetworkReachabilityStatusString]);
        }];
        
        //启动监听
        [_sessionManager.reachabilityManager startMonitoring];
    }
    return _sessionManager;
}

- (void)getDateWithUrl:(NSString *)url{
    //请求数据
    [self.sessionManager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求视频详情界面数据
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *modelDict = responseObject;
            _videoModel = [VideoModel videoModelWithDictionary:modelDict];
        }
        _reLoadDateOfView();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);//输出错误信息
    }];
}

- (instancetype)initWithUrl: (NSString *)url{
    if (self = [super init]) {
        [self getDateWithUrl:url];
    }
    return self;
}

+ (instancetype)FGUrlDateIsOneWithUrl: (NSString*)url{
    
    
    return [[self alloc] initWithUrl:url];
}

@end
