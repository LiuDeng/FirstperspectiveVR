//
//  VideoCollectionViewController.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "VideoCollectionViewController.h"
#import "FGCollectionViewCell.h"
#import "FGCollectionViewCell2.h"
#import "FGCollectionViewCell3.h"
#import "FGCollectionReusableView.h"
#import "FGCollectionReusableView2.h"
#import "AFNetWorking.h"
#import "DictKey.h"
#import "RecommendModel.h"
#import "ListItemsDataModel.h"
#import "ListDetailModel.h"
#import "FGDetailViewViewController.h"
#import "MoreCollectionViewController.h"


#define VIEWW [UIScreen mainScreen].bounds.size.width
@interface VideoCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSArray *modelArr;
@property (nonatomic, strong) RecommendModel *recommendModel;
@end

@implementation VideoCollectionViewController

static NSString *Klist = @"list";
static NSString *Kcolumns = @"columns";
static NSString * reuseIdentifier = @"Cell";
static NSString * reuseIdentifier2 = @"Cell2";
static NSString * reuseIdentifier3 = @"Cell3";
static NSString * headerIdentifier = @"header";
static NSString * headerIdentifier2 = @"header2";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求第4组嵌套数据
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //创建一个laout对象
   
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionViewCell2 class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier2];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionViewCell3 class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier3];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionReusableView2 class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier2];
    
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

#pragma mark <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    ListItemsDataModel *listItemsDataModel = _recommendModel.data[indexPath.section+1];
    CGSize itemSize = CGSizeMake(0, 0);
    if ([listItemsDataModel.layout_type isEqualToString:@"video-h2"]) {
        itemSize = CGSizeMake((VIEWW-30)/2, 140);
        return itemSize;
    }else if ([listItemsDataModel.layout_type isEqualToString:@"nav-single"]){
        itemSize = CGSizeMake((VIEWW -60)/5, 80);
    }else
        itemSize = CGSizeMake((VIEWW -40)/3, 130);
    return itemSize;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return _recommendModel.data.count-1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    ListItemsDataModel *listItemsDataModel = _recommendModel.data[section+1];
    return listItemsDataModel.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListItemsDataModel *listItemsDataModel = _recommendModel.data[indexPath.section+1];
    if ([listItemsDataModel.layout_type isEqualToString:@"video-h2"])
    {
        FGCollectionViewCell3 *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier3 forIndexPath:indexPath];
        cell2.listDetailModel = listItemsDataModel.list[indexPath.row];
        return cell2;
    }else if ([listItemsDataModel.layout_type isEqualToString:@"nav-single"])
    {
        FGCollectionViewCell2 *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier2 forIndexPath:indexPath];
        cell2.listDetailModel = listItemsDataModel.list[indexPath.row];
        return cell2;
    }else
    {
        FGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        
        cell.listDetailModel = listItemsDataModel.list[indexPath.row];
        return cell;
    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);
    }
    return CGSizeMake(30, 30);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ListItemsDataModel *listItemsDataModel = _recommendModel.data[indexPath.section];
    if (indexPath.section == 0) {
        FGCollectionReusableView2 *sectionHeaderViewScroll = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier2 forIndexPath:indexPath];
        listItemsDataModel = _recommendModel.data[0];
        ListDetailModel *detailModel = listItemsDataModel.list[0];
        
        sectionHeaderViewScroll.listDetailModel = detailModel;//保证首界面又数据
        sectionHeaderViewScroll.modelArr = listItemsDataModel.list;
        return sectionHeaderViewScroll;
    }else{
        __weak VideoCollectionViewController *weakRecommendVC = self;
        FGCollectionReusableView *sectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        ListItemsDataModel *listItemsDataModel = _recommendModel.data[indexPath.section];
        sectionHeaderView.listItemsDataModel = listItemsDataModel;
        
        sectionHeaderView.moreBtnClick = ^{
            //取出选中section的Model
            ListItemsDataModel *listItemsDataModel = _recommendModel.data[indexPath.section];
            //传递属性
            MoreCollectionViewController *moreVC = [[MoreCollectionViewController alloc] initWithCollectionViewLayout:[weakRecommendVC addFlowlaout]];
            moreVC.listItemsDataModel = listItemsDataModel;
            [moreVC.collectionView setBackgroundColor:[UIColor whiteColor]];
            //navigationController push控制器
            [weakRecommendVC.navigationController pushViewController:moreVC animated:YES];
        };

        return sectionHeaderView;
    }
}

//flowLayout
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
    __weak VideoCollectionViewController *weakRecommendVC = self;
    //请求数据
    [self.sessionManager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            _recommendModel = [RecommendModel recommendModelWithDictionary:responseObject];
            
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

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
