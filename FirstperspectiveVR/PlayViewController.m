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
#import "UIImageView+WebCache.h"
#import "FmdbTool.h"
#import "DownLoadList.h"
#import "DownLoadTool.h"
//#import "VAttrsModel.m"
#import "VDataModel.h"

@interface PlayViewController ()<GVRVideoViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIProgressView *downProgressView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet GVRVideoView *playerView;
@property (nonatomic, strong)AFHTTPSessionManager* myManager;
@property (nonatomic,strong) VModelFirst *model;
@property (nonatomic, strong) NSString *currentPlayUrl;
@property (nonatomic,strong)NSURLSessionDownloadTask* task;
@property (nonatomic,strong)DownLoadList* downloadModel;
@property (nonatomic,strong)DownLoadTool* downLoadTool;
@property (nonatomic,strong)NSTimer* timer;
@end

@implementation PlayViewController
BOOL _isPaused;
-(DownLoadList *)downloadModel{
    _downloadModel=[[DownLoadTool shareDownloadHandle] downLoadList:_currentPlayUrl];
    return _downloadModel;
}
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
        _model=[VModelFirst ModelWithDictionary:responseObject];
        NSArray *tempArr = _model.data.video_attrs;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_segmentedControl removeAllSegments];
            self.titleLabel.text=_model.data.title;
            self.scoreLabel.text=_model.data.score;
            self.descLabel.text=_model.data.desc;
            [_titleImage sd_setImageWithURL:_model.data.thumb_pic_url.firstObject];
            for (int i=0; i<tempArr.count; i++) {
                VAttrsModel *model = tempArr[i];
                [_segmentedControl insertSegmentWithTitle:model.definition_name atIndex:i animated:NO];
            }
            [_segmentedControl setSelectedSegmentIndex:0];
            VAttrsModel* model=_model.data.video_attrs[_segmentedControl.selectedSegmentIndex];
            self.sizeLabel.text=model.size;
            _currentPlayUrl = model.play_url;
        });
  
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
    _model=[self model];
    _downProgressView.hidden=YES;;
        if (_downloadModel.iscomplete==YES) {
            [_downloadButton setTitle:@"播放本地" forState:(UIControlStateNormal)];
            _downProgressView.hidden=YES;
        }
//    if (_downloadModel.isdownloading==YES) {
//        
//    }
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
}
-(void)refresh{
    _downProgressView.progress=self.downloadModel.progress.fractionCompleted;
    if (self.downloadModel.progress.fractionCompleted!=0) {
        if (self.downloadModel.isdownloading==NO) {
            [_downloadButton setTitle:@"继续" forState:(UIControlStateNormal)];
        }else{
            [_downloadButton setTitle:@"暂停" forState:(UIControlStateNormal)];
            _downProgressView.progress=self.downloadModel.progress.fractionCompleted;
            _downProgressView.hidden=NO;
        }
        
    }
    if (self.downloadModel.iscomplete==YES) {
        [_downloadButton setTitle:@"播放本地" forState:(UIControlStateNormal)];
        _downProgressView.hidden=YES;
        [_timer invalidate];
        _timer=nil;
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)downloadBtn:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"下载"]) {
        [[DownLoadTool shareDownloadHandle]createDownloadWithUrl:_currentPlayUrl name:_model.data.title];
        [sender setTitle:@"暂停" forState:(UIControlStateNormal)];
        _downProgressView.hidden=NO;
        _downProgressView.progress=self.downloadModel.progress.fractionCompleted;
    }else if ([sender.titleLabel.text isEqualToString:@"暂停"]) {
        _downloadModel=[[DownLoadTool shareDownloadHandle] pauseDownloadWithUrl:_currentPlayUrl];
        [sender setTitle:@"继续" forState:(UIControlStateNormal)];
        _downProgressView.hidden=YES;
    }else if ([sender.titleLabel.text isEqualToString:@"继续"]) {
        _downloadModel=[[DownLoadTool shareDownloadHandle] resumeDownloadWithUrl:_currentPlayUrl];
        [sender setTitle:@"暂停" forState:(UIControlStateNormal)];
        _downProgressView.hidden=NO;
        _downProgressView.progress=self.downloadModel.progress.fractionCompleted;
    }else if ([sender.titleLabel.text isEqualToString:@"播放本地"]) {
        _downProgressView.hidden=YES;
        [self.view bringSubviewToFront:_playerView];
        [_playerView loadFromUrl:[NSURL URLWithString:[NSString stringWithFormat:@"/Users/qingyun/Desktop/%@.MP4",_model.data.title]]];
    }
}

        


- (IBAction)playBtn:(UIButton *)sender {
    NSLog(@"!!!!!!!!!!!!!!!%@",_currentPlayUrl);
    [self.view bringSubviewToFront:_playerView];

    [_playerView loadFromUrl:[NSURL URLWithString:_currentPlayUrl]];
}
- (IBAction)clarityButton:(UISegmentedControl *)sender {
//    UISegmentedControlSegment *se = ];
    VAttrsModel* model=_model.data.video_attrs[sender.selectedSegmentIndex];
    
    self.sizeLabel.text=model.size;
    _currentPlayUrl = model.play_url;
    
    
    
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
-(void)dealloc{
    [_playerView stop];
    _playerView.delegate = nil;
    
    [_playerView removeFromSuperview];
    _playerView=nil;
}
- (void)videoView:(GVRVideoView*)videoView didUpdatePosition:(NSTimeInterval)position {
    // Loop the video when it reaches the end.
//    _slider.value = position;
    if (position == videoView.duration) {
//        [_playerView seekTo:0];
        [_playerView stop ];
        [self.view bringSubviewToFront:_titleImage];
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
