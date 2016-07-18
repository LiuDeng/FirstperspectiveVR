//
//  PlayViewController.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PlayViewController.h"
#import "GVRVideoView.h"
#import "VModelFirst.h"
#import "AFNetworking.h"
#import "SDImageCache.h"
#import "FmdbTool.h"
@interface PlayViewController ()<GVRVideoViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet GVRVideoView *playerView;
@property (nonatomic, strong)AFHTTPSessionManager* myManager;
@property (nonatomic,strong) VModelFirst *model;
@end

@implementation PlayViewController
BOOL _isPaused;
-(AFHTTPSessionManager *)myManager{
    if (!_myManager) {
        //创建manager对象
        _myManager=[AFHTTPSessionManager manager];
        //设置网络监听
        _myManager.reachabilityManager=[AFNetworkReachabilityManager sharedManager];
        
        __weak AFNetworkReachabilityManager *reachManager=_myManager.reachabilityManager;
        
        //设置监听回调函数
        [_myManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            //显示监听状态
            NSLog(@"=====当前网络状态=%@",[reachManager localizedNetworkReachabilityStatusString]);
        }];
        
        //启动监听
        [_myManager.reachabilityManager startMonitoring];
    }
    
    return _myManager;
}
-(VModelFirst *)model{
    [self.myManager GET:_Url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络获取错误》》》》%@",error);
    }];
    return _model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _playerView.delegate = self;
    _playerView.enableFullscreenButton = YES;
    _playerView.enableCardboardButton = YES;
     _isPaused = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)downloadBtn:(UIButton *)sender {
}
- (IBAction)playBtn:(UIButton *)sender {
    [_playerView loadFromUrl:[NSURL URLWithString:@"http://dl.mojing.cn/xianchang/160707/1467865137_37_3840HD.mp4"]];
}
- (IBAction)clarityButton:(UISegmentedControl *)sender {
}
#pragma mark - GVRVideoViewDelegate

- (void)widgetViewDidTap:(GVRWidgetView *)widgetView {
    if (_isPaused) {
        [_playerView resume];
    } else {
        [_playerView pause];
    }
    _isPaused = !_isPaused;
}

- (void)widgetView:(GVRWidgetView *)widgetView didLoadContent:(id)content {
    NSLog(@"Finished loading video");
//    _slider.maximumValue = _videoView.duration;
    
}

- (void)widgetView:(GVRWidgetView *)widgetView
didFailToLoadContent:(id)content
  withErrorMessage:(NSString *)errorMessage {
    if ([errorMessage isEqualToString:@"Cannot Decode"]) {
        NSLog(@"您的手机不支持4K的视频，请选择标清播放");
    }else{
        NSLog(@"%@",errorMessage);
    }
    
}

- (void)videoView:(GVRVideoView*)videoView didUpdatePosition:(NSTimeInterval)position {
    // Loop the video when it reaches the end.
//    _slider.value = position;
    if (position == videoView.duration) {
        [_playerView seekTo:0];
        [_playerView resume];
    }
    //[_videoView seekTo:position];
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
