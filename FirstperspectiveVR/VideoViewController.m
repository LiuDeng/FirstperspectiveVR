//
//  VideoViewController.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "VideoViewController.h"
#import "Masonry.h"
#import "VideoCollectionViewController.h"

#define VIEWW [UIScreen mainScreen].bounds.size.width
#define VIEWH [UIScreen mainScreen].bounds.size.height
@interface VideoViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic)NSInteger page;
@property (nonatomic, strong) VideoCollectionViewController *videoCollerctionViewControllerVR;
@property (nonatomic, strong) VideoCollectionViewController *videoCollerctionViewController2D;
@property (nonatomic, strong) VideoCollectionViewController *videoCollerctionViewController3D;
@property (nonatomic, strong) VideoCollectionViewController *videoCollerctionViewControllerZB;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 0;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self addTitleButton];
    
    // Do any additional setup after loading the view.
}

#pragma mark pageViewController
//设置首页
- (UIPageViewController *)pageViewController{
    if (_pageViewController == nil) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        //设置当前页
        VideoCollectionViewController *videoCollectionVC = [[VideoCollectionViewController alloc] initWithCollectionViewLayout:[self addFlowlaout]];
        NSArray *vcArr = @[videoCollectionVC];
        [_pageViewController setViewControllers:vcArr direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
            NSString *urlStr = @"http://res.static.mojing.cn/160630-1-1-1/ios/zh/1/page/443513.js";
            [videoCollectionVC getDateWithUrl:urlStr];
        }];
    }
    return _pageViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    if (_page == 0) {
        return nil;
    }else
        _page--;
        return [self crateVideoCollerctionViewController:_page];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    if (_page == 3) {
        return nil;
    }else
        _page++;
    return [self crateVideoCollerctionViewController:_page];
}

- (VideoCollectionViewController *)crateVideoCollerctionViewController:(NSInteger)page{
    if (page >4) {
        return nil;
    }
    VideoCollectionViewController *videoCollectionVC = [[VideoCollectionViewController alloc] initWithCollectionViewLayout:[self addFlowlaout]];
    [self getdata:page :videoCollectionVC];
    return videoCollectionVC;
}
- (void)getdata:(NSInteger)page : (VideoCollectionViewController*)collectionVc{
    NSString *urlStr = [NSString string];
    switch (page) {
        case 0:
            urlStr = @"http://res.static.mojing.cn/160630-1-1-1/ios/zh/1/page/443513.js";
            break;
        case 1:
            urlStr = @"http://res.static.mojing.cn/160630-1-1-1/ios/zh/1/page/443514.js";
            break;
        case 2:
            urlStr = @"http://res.static.mojing.cn/160630-1-1-1/ios/zh/1/page/443515.js";
            break;
        case 3:
            urlStr = @"http://res.static.mojing.cn/160630-1-1-1/ios/zh/1/page/443516.js";
            break;
            
        default:
            break;
    }
    [collectionVc getDateWithUrl:urlStr];
}
//添加界面
- ( UICollectionViewFlowLayout *)addFlowlaout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 10.0;//行间距
    flowLayout.minimumInteritemSpacing = 0.0;//itme间距
    //section的头尾size,scrollDirection为垂直,Size中的高度起作用;scrollDirection为水平,Size中的宽度起作用
    //    flowLayout.headerReferenceSize = CGSizeMake(30, 30);
    //    flowLayout.footerReferenceSize = CGSizeMake(30, 30);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);//sectionInset边距
    //设置section头视图悬浮
    flowLayout.sectionHeadersPinToVisibleBounds = NO;
    //    flowLayout.estimatedItemSize = CGSizeMake(50, 100);
//    _videoCollerctionViewControllerVR = [[VideoCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
//    [self addChildViewController:_videoCollerctionViewControllerVR];
//    self.view =_videoCollerctionViewControllerVR.collectionView;
//    _videoCollerctionViewControllerVR.view.frame = CGRectMake(0, 65, VIEWW, VIEWH);
    return flowLayout;
}

//添加标题Button
- (void)addTitleButton{
    UIButton *btnVr = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn2d = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn3d = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btnZb = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnVr setTitle:@"VR" forState:UIControlStateNormal];
    [btn2d setTitle:@"2D" forState:UIControlStateNormal];
    [btn3d setTitle:@"3D" forState:UIControlStateNormal];
    [btnZb setTitle:@"直播" forState:UIControlStateNormal];
    btnVr.tag = 1;
    btn2d.tag = 2;
    btn3d.tag = 3;
    btnZb.tag = 4;
    [self.view addSubview:btnVr];
    [self.view addSubview:btn2d];
    [self.view addSubview:btn3d];
    [self.view addSubview:btnZb];
    [btnVr addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn2d addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn3d addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnZb addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnZb setBackgroundColor:[UIColor blackColor]];
    [btnVr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(VIEWW/4);
    }];
    [btn2d mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(VIEWW/4);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(VIEWW/4);
    }];
    [btn3d mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(VIEWW/2);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(VIEWW/4);
    }];
    [btnZb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(VIEWW/4*3);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(VIEWW/4);
    }];
    
}

- (void)btnClick:(UIButton*)sender{
    
    NSInteger crueenIndex = sender.tag-1;
    if (crueenIndex == _page) {
        return;
    }
    _page = sender.tag-1;
    VideoCollectionViewController *vc = [self crateVideoCollerctionViewController:_page];
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
