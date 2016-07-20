//
//  TitleCollectionView.m
//  01-QYNews
//
//  Created by qingyun on 16/5/23.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "TitleCollectionView.h"
#import "CollectionViewCell.h"
@interface TitleCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation TitleCollectionView

+(instancetype)titleCollectionViewWithTitles:(NSArray *)titles{
    //1.创建flowLayout
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    //滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //item间距
    flowLayout.minimumInteritemSpacing = 10;
    //预估的itemSize
    
    flowLayout.estimatedItemSize = CGSizeMake(44, 26);
    //sectionInsets
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    //2.创建一个titleCollectionView
    TitleCollectionView *titleCollectionView = [[TitleCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    titleCollectionView.backgroundColor = [UIColor lightGrayColor];
    //设置数据源和代理
    titleCollectionView.dataSource = titleCollectionView;
    titleCollectionView.delegate = titleCollectionView;
    //隐藏水平的滚动条
    titleCollectionView.showsHorizontalScrollIndicator = NO;
    //保存所有的栏目
    titleCollectionView.titles = titles;
    //注册cell
    [titleCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"item"];
    
    //设置默认选中的索引
    titleCollectionView.currentIndex = 0;
    
    return titleCollectionView;
}

#pragma mark -Data Source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    item.titleLabel.text = (self.titles[indexPath.item])[@"name"];
    item.titleLabel.textColor = indexPath.item == _currentIndex ? [UIColor redColor] : [UIColor blackColor];
    return item;
}

#pragma mark  -UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.currentIndex = indexPath.item;
    
    if (_changeContentVC) {
        _changeContentVC(indexPath.item);
    }
}



-(void)setCurrentIndex:(NSUInteger)currentIndex{
    //1.把之前选中的菜单的标题颜色置为黑色(_currentIndex)
    CollectionViewCell *cell = (CollectionViewCell *)[self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0]];
    cell.titleLabel.textColor = [UIColor blackColor];
    //2.把将要选中的菜单的标题置为红色(currentIndex)
    CollectionViewCell *willSelctedCell = (CollectionViewCell *)[self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndex inSection:0]];
    willSelctedCell.titleLabel.textColor = [UIColor redColor];
    //3.保留将要选中的菜单的索引
    _currentIndex = currentIndex;
    //4.计算偏移量
    CGFloat detalValue = willSelctedCell.center.x - self.center.x;
    if (detalValue < 0) {
        detalValue = 0;
    }else if (detalValue > self.contentSize.width - self.frame.size.width){
        detalValue = self.contentSize.width - self.frame.size.width;
    }
    //5.设置偏移量
    
    [self setContentOffset:CGPointMake(detalValue, 0) animated:YES];
}



@end
