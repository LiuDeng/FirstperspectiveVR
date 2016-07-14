//
//  ChannelVC.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ChannelVC.h"
#import "TitleCollectionView.h"
#import "SubChannelVC.h"
@interface ChannelVC ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (nonatomic, strong) NSArray *titles;              //所有栏目标题集合
@property (nonatomic, strong) UIPageViewController* pageVC;
@property (nonatomic, strong) TitleCollectionView *titleCollectionView;

@end

@implementation ChannelVC
-(NSArray *)titles{
    if (_titles == nil) {
        NSString* path=[[NSBundle mainBundle]pathForResource:@"collection" ofType:@"plist"];
        _titles=[NSArray arrayWithContentsOfFile:path];
    }
    return _titles;
}

-(UIPageViewController *)pageVC{
    if (_pageVC == nil) {
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@(10.0)}];
        
        //设置数据源和代理
        _pageVC.dataSource = self;
        _pageVC.delegate = self;
        
        
    }
    return _pageVC;
}

-(TitleCollectionView *)titleCollectionView{
    if (_titleCollectionView == nil) {
        _titleCollectionView = [TitleCollectionView titleCollectionViewWithTitles:self.titles];
        __weak ChannelVC *weakSelf = self;
        _titleCollectionView.changeContentVC = ^(NSUInteger index){
            //更改内容控制器
            [weakSelf changeContentViewControllerWithIndex:index];
        };
    }
    return _titleCollectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.titleCollectionView;
    self.navigationItem.titleView.backgroundColor=[UIColor colorWithRed:41 green:220 blue:230 alpha:1];
    CGFloat CWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat CHeight = self.navigationController.navigationBar.bounds.size.height*0.6;
    
    _titleCollectionView.frame=CGRectMake(0, 0, CWidth, CHeight);
    self.navigationController.navigationBar.translucent = NO;
    
    //设置内容控制器
    SubChannelVC *contentVC = [self viewControllerWithIndex:0];
    [self.pageVC setViewControllers:@[contentVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

//根据选中的栏目的索引来更改内容控制器
-(void)changeContentViewControllerWithIndex:(NSUInteger)index{
    //1.获取当前控制器的type在titles中的索引currentIndex
    SubChannelVC *currentDataVC = self.pageVC.viewControllers.firstObject;
    NSUInteger currentIndex = [self indexOfViewController:currentDataVC];
    //2.currentIndex == index,return;
    if (currentIndex == index) {
        return;
    }
    //3.根据index获取对应的内容控制器,然后设置内容控制器
    SubChannelVC *willChangedVC = [self viewControllerWithIndex:index];
    [self.pageVC setViewControllers:@[willChangedVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}
//根据索引获取内容控制器
-(SubChannelVC *)viewControllerWithIndex:(NSUInteger)index{
    if (self.titles.count == 0 || index >= self.titles.count) {
        return nil;
    }
    
    SubChannelVC *dataVC = [[SubChannelVC alloc] init];
    dataVC.type = self.titles[index];
    dataVC.dataUrl=(self.titles[index])[@"url"];
    dataVC.name=(self.titles[index])[@"name"];
    
    //    dataVC.updateUrl=(self.titles[index])[@"updateUrl"];
    return dataVC;
}
//获取当前控制器的type在titles中的索引currentIndex
-(NSUInteger)indexOfViewController:(SubChannelVC *)vc{
    return [self.titles indexOfObject:vc.type];
}
//上一个内容控制器
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    //1.获取当前控制器的type在titles中的索引currentIndex
    NSUInteger currentIndex = [self indexOfViewController:(SubChannelVC *)viewController];
    //2.假如currentIndex == 0 返回nil; currentIndex != 0,currentIndex -= 1
    if (currentIndex == 0) {
        return nil;
    }
    currentIndex -= 1;
    //3.根据currentIndex获取上一个内容控制器
    return [self viewControllerWithIndex:currentIndex];
}

//下一个内容控制器
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    //1.获取当前控制器的type在titles中的索引currentIndex
    NSUInteger currentIndex = [self indexOfViewController:(SubChannelVC *)viewController];
    //2.currentIndex++
    currentIndex++;
    //3.假如currentIndex >= self.titles.count,返回nil
    if (currentIndex >= self.titles.count) {
        return nil;
    }
    //4.根据currentIndex获取下一个内容控制器
    return [self viewControllerWithIndex:currentIndex];
}

#pragma mark -UIPageViewControllerDelegate
//结束过渡动画
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    //1.获取当前控制器的type在titles中的索引currentIndex
    SubChannelVC *currentDataVC = self.pageVC.viewControllers.firstObject;
    NSUInteger currentIndex = [self indexOfViewController:currentDataVC];
    
    //2.获取上一个内容控制器的type在titles中的索引previousIndex
    NSUInteger previousIndex = [self indexOfViewController:(SubChannelVC *)previousViewControllers.firstObject];
    //3.判断currentIndex != previousIndex,设置_titleScrollView的currentIndex等于currentIndex
    if (currentIndex != previousIndex) {
        _titleCollectionView.currentIndex = currentIndex;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
