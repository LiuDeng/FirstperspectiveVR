//
//  FGDetailViewViewController.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FGDetailViewViewController.h"


#import "AFNetWorking.h"



@interface FGDetailViewViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *downloadLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *definitionLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (nonatomic, strong)AFHTTPSessionManager *sessionManager;
@end

@implementation FGDetailViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDate];
    
    // Do any additional setup after loading the view from its nib.
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 请求数据
- (instancetype)getDate{
    __weak FGDetailViewViewController *weakVC = self;
    NSString *urlStr = [NSString stringWithFormat:@"http://img.static.mojing.cn/resource/detail/newmarket/%@.js",_typeId];
    [self.sessionManager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([_resId isEqualToString:@"1"]) {
                
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakVC viewWillAppear:YES];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    return nil;
}
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
            NSLog(@"=====＋＋＋当前网络状态为＋＋＋=%@",[reachManager localizedNetworkReachabilityStatusString]);
        }];
        
        //启动监听
        [_sessionManager.reachabilityManager startMonitoring];
    }
    return _sessionManager;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
