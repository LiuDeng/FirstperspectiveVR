//
//  FGRecommendCollectionViewController.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FGRecommendCollectionViewController.h"
#import "FGUrlDate.h"
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
#import "PlayViewController.h"
#import "VideoViewController.h"

#define VIEWW [UIScreen mainScreen].bounds.size.width


@interface FGRecommendCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSArray *modelArr;
@property (nonatomic, strong) RecommendModel *recommendModel;
@property (nonatomic, strong) FGUrlDate *fgUrlDate;
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@end

@implementation FGRecommendCollectionViewController
static NSString *Klist = @"list";
static NSString *Kcolumns = @"columns";
static NSString * reuseIdentifier = @"Cell";
static NSString * reuseIdentifier2 = @"Cell2";
static NSString * reuseIdentifier3 = @"Cell3";
static NSString * headerIdentifier = @"header";
static NSString * headerIdentifier2 = @"header2";

- (void)viewDidLoad {
    [super viewDidLoad];
    //请求数据
    NSString *urlStr = @"http://res.static.mojing.cn/160630-1-1-1/ios/zh/1/page/443512.js";
    [self getDateWithUrl:urlStr];
    //请求第4组嵌套数据
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    [self.collectionView setAlpha:0.05];
    //创建一个laout对象
    
//    flowLayout.estimatedItemSize = CGSizeMake(50, 100);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.collectionView.frame collectionViewLayout:[self crateFlowLayout]];
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    
    self.collectionView = collectionView;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionViewCell2 class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier2];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionViewCell3 class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier3];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionReusableView2 class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier2];
    //下拉刷新
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshView) forControlEvents:UIControlEventValueChanged];
     [self.collectionView addSubview:self.refreshControl];
    
    
}

- (UICollectionViewFlowLayout*)crateFlowLayout{
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.minimumLineSpacing = 10.0;//行间距
    flowlayout.minimumInteritemSpacing = 10.0;//itme间距
    //section的头尾size,scrollDirection为垂直,Size中的高度起作用;scrollDirection为水平,Size中的宽度起作用
    //    flowLayout.headerReferenceSize = CGSizeMake(30, 30);
    //    flowLayout.footerReferenceSize = CGSizeMake(30, 30);
    flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//sectionInset边距
    //设置section头视图悬浮
    flowlayout.sectionHeadersPinToVisibleBounds = NO;
    return flowlayout;
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

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize = CGSizeMake(0, 0);
    switch (indexPath.section) {
        case 0:
            itemSize =  CGSizeMake((VIEWW-60)/5 , 80);
            break;
        case 1:
            itemSize = CGSizeMake((VIEWW-30)/2, 140);
            break;
        case 2:
            itemSize = CGSizeMake((VIEWW-30)/2, 140);
            break;
        case 3:
            itemSize = CGSizeMake((VIEWW-40)/3, 150);
            break;
        case 4:
            itemSize = CGSizeMake((VIEWW-40)/3, 150);
            break;
        case 5:
            itemSize = CGSizeMake((VIEWW-40)/3, 150);
            break;
        case 6:
            itemSize = CGSizeMake((VIEWW-30)/2, 140);
            break;
        case 7:
            itemSize = CGSizeMake((VIEWW-30)/2, 140);
            break;
        case 8:
            itemSize = CGSizeMake((VIEWW-40)/3, 150);
            break;
        case 9:
            itemSize = CGSizeMake((VIEWW-40)/3, 150);
            break;
        case 10:
            itemSize = CGSizeMake((VIEWW-50)/4, 120);
            break;
        default:
            break;
    }
    return itemSize;
}
#if 0
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
#endif


#pragma mark <UICollectionViewDataSource>
//组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return _recommendModel.data.count-1;
}

//每一组cell的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ListItemsDataModel *listItemsDataModel = _recommendModel.data[section+1];
    return listItemsDataModel.list.count;
}
//Cell的内容及格式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListItemsDataModel *listItemsDataModel = _recommendModel.data[indexPath.section+1];
    if (indexPath.section == 4||indexPath.section == 5||indexPath.section == 8||indexPath.section == 9)
    {
        FGCollectionViewCell3 *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier3 forIndexPath:indexPath];
        cell2.listDetailModel = listItemsDataModel.list[indexPath.row];
        return cell2;
    }else if (indexPath.section == 0)
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
    //btn点击block块实现
    __weak FGRecommendCollectionViewController *weakRecommendVC = self;
    
    
    ListItemsDataModel *listItemsDataModel = _recommendModel.data[indexPath.section];
    ListDetailModel *detailModel = listItemsDataModel.list[0];
    if (indexPath.section == 0) {
        FGCollectionReusableView2 *sectionHeaderViewScroll = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier2 forIndexPath:indexPath];
        listItemsDataModel = _recommendModel.data[0];
        sectionHeaderViewScroll.listDetailModel = detailModel;//保证首界面又数据
        sectionHeaderViewScroll.modelArr = listItemsDataModel.list;
        return sectionHeaderViewScroll;
    }else{
        FGCollectionReusableView *sectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        ListItemsDataModel *listItemsDataModel = _recommendModel.data[indexPath.section+1];
        sectionHeaderView.listItemsDataModel = listItemsDataModel;
        
        sectionHeaderView.moreBtnClick = ^{
            //取出选中section的Model
            ListItemsDataModel *listItemsDataModel = _recommendModel.data[indexPath.section];
            //传递属性
            MoreCollectionViewController *moreVC = [[MoreCollectionViewController alloc] initWithCollectionViewLayout:[weakRecommendVC crateFlowLayout]];
            moreVC.listItemsDataModel = listItemsDataModel;
            [moreVC.collectionView setBackgroundColor:[UIColor whiteColor]];
            //navigationController push控制器
            [weakRecommendVC.navigationController pushViewController:moreVC animated:YES];
        };
    return sectionHeaderView;
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
    __weak FGRecommendCollectionViewController *weakRecommendVC = self;
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

#pragma mark 下拉刷新
- (void)refreshView{
    
    NSString *urlStr = @"http://res.static.mojing.cn/160630-1-1-1/ios/zh/1/page/443512.js";
    
    [self getDateWithUrl:urlStr];
    [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
    
}

#pragma mark <UICollectionViewDelegate>//itmes  点击跳转

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ListItemsDataModel *listItemsDataModel = _recommendModel.data[indexPath.section+1];
    ListDetailModel *listDetailModel = listItemsDataModel.list[indexPath.row];
    if ([listDetailModel.type integerValue]== 4) {
        UIStoryboard *sb2 = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        PlayViewController *playViewController = [sb2 instantiateViewControllerWithIdentifier:@"PlayViewController"];
        
        NSString *urlStr = [NSString stringWithFormat:@"http://res.static.mojing.cn/160630-1-1-1/ios/zh/%@",listDetailModel.url];
        playViewController.Url = urlStr;
        [self.navigationController pushViewController:playViewController animated:YES];
    }else if ([listDetailModel.type integerValue]== 9){
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main2" bundle:[NSBundle mainBundle]];
//        VideoViewController *VVC = [sb instantiateViewControllerWithIdentifier:@"VideoViewController"];
        [self.tabBarController setSelectedIndex:1];
//        [self presentViewController:VVC animated:YES completion:nil];
    }else{
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertController *alertContro = [UIAlertController alertControllerWithTitle:@"敬请期待" message:@"该资源尚未开放，请欣赏其他资源" preferredStyle:UIAlertControllerStyleAlert];
        [alertContro addAction:action];
        [self presentViewController:alertContro animated:YES completion:nil];
    }
    
   
}

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
