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
#import "Key.h"
#import "RecommenModel.h"
#import "RecommenModel2.h"
#import "RecommenModel3.h"
#import "VideoModel.h"
#import "FGDetailViewViewController.h"

@interface FGRecommendCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSArray *modelArrOne;
@property (nonatomic, strong) NSArray *modelArrTwo;
@property (nonatomic, strong) NSArray *modelArrThree;
@property (nonatomic, strong) NSArray *modelArrFour;
@property (nonatomic, strong) NSArray *modelArrFive;
@property (nonatomic, strong) VideoModel *videoModel;
@property (nonatomic, strong) FGUrlDate *fgUrlDate;
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
    NSString *urlStr = @"http://img.static.mojing.cn/resource/newmarket/ios/20160120/home.js";
    [self getDateWithUrl:urlStr];
    //请求第4组嵌套数据
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //创建一个laout对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10.0;//行间距
    flowLayout.minimumInteritemSpacing = 0.0;//itme间距
    //section的头尾size,scrollDirection为垂直,Size中的高度起作用;scrollDirection为水平,Size中的宽度起作用
//    flowLayout.headerReferenceSize = CGSizeMake(30, 30);
//    flowLayout.footerReferenceSize = CGSizeMake(30, 30);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);//sectionInset边距
    //设置section头视图悬浮
    flowLayout.sectionHeadersPinToVisibleBounds = NO;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.collectionView.frame collectionViewLayout:flowLayout];
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    self.collectionView = collectionView;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionViewCell2 class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier2];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionViewCell3 class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier3];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FGCollectionReusableView2 class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier2];
    // Do any additional setup after loading the view.
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
            itemSize =  CGSizeMake(160 , 160);
            break;
        case 1:
            itemSize = CGSizeMake(100, 110);
            break;
        case 2:
            itemSize = CGSizeMake(100, 150);
            break;
        case 3:
            itemSize = CGSizeMake(80, 100);
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

    return 4;
}

//每一组cell的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (section == 0) {
        return 6;
    }else if (section == 1){
        return 9;
    }else if (section == 2){
        return 6;
    }else{
        return 4;
    }
}
//Cell的内容及格式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.recommentModel = self.modelArrTwo[indexPath.row];
        return cell;
    }else if (indexPath.section == 1){
        FGCollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier2 forIndexPath:indexPath];
        cell.recommenModel2 = self.modelArrThree[indexPath.row];
        return cell;
    }else if (indexPath.section == 2){
        FGCollectionViewCell3 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier3 forIndexPath:indexPath];
        cell.recommenModel3 = self.modelArrFour[indexPath.row];
//        if ([self.modelArrFour[indexPath.row] isKindOfClass:[RecommenModel3 class]]) {
//            RecommenModel3 *recommenModel3 = self.modelArrFour[indexPath.row];
//            NSString *oneStr = [recommenModel3.movie_id substringWithRange:NSMakeRange(2,3)];
//            if ([[oneStr substringWithRange:NSMakeRange(0, 1)]isEqualToString:@"0"]) {
//                oneStr = [oneStr substringWithRange:NSMakeRange(1, 2)];
//            }
//            NSString *urlStr = [NSString stringWithFormat:@"http://i.mojing.baofeng.com/v1.0/public/movie/%@/%@.js",oneStr,recommenModel3.movie_id];
//            _fgUrlDate = [[FGUrlDate alloc] initWithUrl:urlStr];
//        }
//        __weak FGRecommendCollectionViewController *weakRecommendVC = self;
//        _fgUrlDate.reLoadDateOfView = ^{
//            [weakRecommendVC.collectionView reloadData];
//        };
//        cell.videoModel = _fgUrlDate.videoModel;
        return cell;
    }else{
        FGCollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier2 forIndexPath:indexPath];
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
    if (indexPath.section == 0) {
        FGCollectionReusableView2 *sectionHeaderViewScroll = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier2 forIndexPath:indexPath];
        sectionHeaderViewScroll.recommenModel = self.modelArrOne[0];//保证首界面又数据
        sectionHeaderViewScroll.modelArr = self.modelArrOne;
        return sectionHeaderViewScroll;
    }else{
        FGCollectionReusableView *sectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
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

- (void)getDateWithUrl:(NSString *)url{
    __weak FGRecommendCollectionViewController *weakRecommendVC = self;
    //请求数据
    [self.sessionManager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[Kcolumns] isKindOfClass:[NSArray class]]) {
            NSArray *newsArr = (NSArray *)responseObject[Kcolumns];
            for (NSDictionary *dict in newsArr) {
                if ([dict[KColumn_id] integerValue] == 1) {//第0组的数据
                    NSArray *arr = dict[Klist];
                    NSMutableArray *MArr = [NSMutableArray array];
                    for (NSDictionary *dict1 in arr) {
                        RecommenModel *recommenModel = [RecommenModel recommenModelWithDictionary:dict1];
                        [MArr addObject:recommenModel];
                    }
                    _modelArrOne = MArr;
                }else if ([dict[KColumn_id] integerValue] == 2){//第1组的数据
                    NSArray *arr = dict[Klist];
                    NSMutableArray *MArr = [NSMutableArray array];
                    for (NSDictionary *dict1 in arr) {
                        RecommenModel *recommenModel = [RecommenModel recommenModelWithDictionary:dict1];
                        [MArr addObject:recommenModel];
                    }
                    _modelArrTwo = MArr;
                }else if ([dict[KColumn_id] integerValue] == 3){//第2组的数据
                    NSArray *arr = dict[Klist];
                    NSMutableArray *MArr = [NSMutableArray array];
                    for (NSDictionary *dict1 in arr) {
                        RecommenModel2 *recommenModel2 = [RecommenModel2 recommenModelWithDictionary:dict1];
                        [MArr addObject:recommenModel2];
                    }
                    _modelArrThree = MArr;
                }else if ([dict[KColumn_id] integerValue] == 4){
                    NSArray *arr = dict[Klist];
                    NSMutableArray *MArr = [NSMutableArray array];
                    for (NSDictionary *dict1 in arr) {
                        RecommenModel3 *recommenModel3 = [RecommenModel3 recommenModel3WithDictionary:dict1];
                        [MArr addObject:recommenModel3];
                    }
                    _modelArrFour = MArr;
                }
            }
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakRecommendVC.collectionView reloadData];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);//输出错误信息
    }];
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FGDetailViewViewController *detailVC = [[FGDetailViewViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
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
