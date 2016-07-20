//
//  FmdbTool.h
//  最新闻
//
//  Created by qingyun on 16/6/19.
//  Copyright © 2016年 Q. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TextModel;
@interface FmdbTool : NSObject
+(instancetype)shareHandel:(NSString*)name;

//1.插入数据
-(BOOL)insertIntoStudent:(TextModel *)mode:(NSString*)name;

//2.查询所有的数据
-(NSMutableArray *)selectAll:(NSString*)name;

//3.删除所有数据
-(void)deleteAll:(NSString*)name;
@end
