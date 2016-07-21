//
//  MoreCollectionViewController.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MoreCollectionViewController.h"
#import "FGCollectionViewCell.h"
#import "FGCollectionViewCell3.h"
#import "AFNetWorking.h"
#import "RecommendModel.h"
#import "ListItemsDataModel.h"
#import "ListDetailModel.h"


#define VIEWW [UIScreen mainScreen].bounds.size.width
@interface MoreCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) RecommendModel *recommendModel;
@end

@implementation MoreCollectionViewController
static NSString * reuseIdentifier = @"Cell";
static NSString * reuseIdentifier2 = @"Cell2";
static NSString * reuseIdentifier3 = @"Cell3";

- (void)viewDidLoad {
    [super viewDidLoad];
    //请求数据
    NSString *urlStr = [NSString stringWithFormat:@"http://res.static.mojing.cn/160630-1-1-1/ios/zh/1/block/blockinfo/%@-start0-num30.js",_listItemsDataModel.res_id];
    [self getDateWithUrl:urlStr];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionViewCell3 class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier3];
    
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize = CGSizeMake(0, 0);
    if ([_listItemsDataModel.layout_type isEqualToString:@"video-h2"]) {
        itemSize = CGSizeMake((VIEWW-30)/2, 140);
        return itemSize;
    }else{
        itemSize = CGSizeMake((VIEWW - 40)/3, 160);
        return itemSize;
    }
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ListItemsDataModel *listItemsDataModel = _recommendModel.data[0];
    
    return listItemsDataModel.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListItemsDataModel *listItemsDataModel = _recommendModel.data[0];
    if ([_listItemsDataModel.layout_type isEqualToString:@"video-h2"]) {
        FGCollectionViewCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        Cell.listDetailModel = listItemsDataModel.list[indexPath.row];
        return Cell;
    }else {
        FGCollectionViewCell3 *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        Cell.listDetailModel = listItemsDataModel.list[indexPath.row];
        return Cell;
    }
}




#pragma mark 数据请求

- (AFHTTPSessionManager *)sessionManager{
    if (!_sessionManager) {
        //创建manager对象
        _sessionManager = [AFHTTPSessionManager manager];
        //设置网络监听
        _sessionManager.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        __weak AFNetworkReachabilityManager *reachManager=_sessionManager.reachabilityManager;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
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

- (void)getDateWithUrl:(NSString *)url{
    __weak MoreCollectionViewController *weakRecommendVC = self;
    //请求数据
    [self.sessionManager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSMutableDictionary *Mdict = [NSMutableDictionary dictionaryWithDictionary:responseObject];
            [Mdict setObject:@(YES) forKey:@"way"];
            _recommendModel = [RecommendModel recommendModelWithDictionary:Mdict];
            ListItemsDataModel *listItemsDataModel = _recommendModel.data[0];
            
            [weakRecommendVC.navigationController.navigationItem setTitle:listItemsDataModel.title];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakRecommendVC.collectionView reloadData];
            
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--==--%@",error);//输出错误信息
    }];
    
}


#pragma mark <UICollectionViewDelegate>//itmes  点击跳转

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

@end