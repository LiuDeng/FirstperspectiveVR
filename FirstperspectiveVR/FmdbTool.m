//
//  FmdbTool.m
//  最新闻
//
//  Created by qingyun on 16/6/19.
//  Copyright © 2016年 Q. All rights reserved.
//

#import "FmdbTool.h"
#import "FMDB.h"
#import "TextModel.h"
#define KDBNAME @"datas.db"
@interface FmdbTool()
@property(nonatomic,strong)FMDatabase *base;
@end
@implementation FmdbTool
//懒加载
-(FMDatabase *)base{
    if(_base)return _base;
    //初始化_base对象,创建数据库
    //合并数据库路径,指向你数据库的文件
    //1.获取NSdocumentsPath
    NSString *documentsPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath=[documentsPath stringByAppendingPathComponent:KDBNAME];
    //初始化_base对象
    _base=[FMDatabase databaseWithPath:filePath];
    
    //打开数据库
    if(![_base open]){
        NSLog(@"==error===%@",[_base lastErrorMessage]);
    }
    return _base;
}

+(instancetype)shareHandel:(NSString*)name{
    static FmdbTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once
        tool=[[FmdbTool alloc] init];
        //创建表
        
    });
    [tool creatTable:name];
    return tool;
}
//@property (strong, nonatomic) NSString  *passtime;
//@property (strong, nonatomic) NSString  *text;
//@property (strong, nonatomic) NSString  *type;
//@property (strong, nonatomic) NSString  *video;
//@property (strong, nonatomic) NSString  *share_url;
//@property (strong, nonatomic) NSString  *gif;
//@property (strong, nonatomic) NSString  *image;
//@property (strong, nonatomic) NSString  *videoImage;
//@property (nonatomic)         NSInteger imageWidth;
//@property (nonatomic)         NSInteger imageHeight;
-(BOOL)creatTable:(NSString*)name{
    //1.sql语句
    NSString *sql=[NSString stringWithFormat:@"create table if not exists %@(passtime text,textOne text,type text,video text,share_url text,gif text,image text,videoImage text,np integer,imageWidth integer,imageHeight integer)",name];
    //执行创建表更新操作
    BOOL result=[self.base executeUpdate:sql];
    if (!result)NSLog(@"======create error==%@",[self.base lastErrorMessage]);
    return result;
}
-(BOOL)insertIntoStudent:(TextModel *)mode:(NSString*)name{
    //1.编写sql语句
    NSString *sql=[NSString stringWithFormat:@"insert into %@(passtime,textOne,type,video,share_url,gif,image,videoImage,np,imageWidth,imageHeight)values(?,?,?,?,?,?,?,?,?,?,?)",name];
    //2.执行sql语句
    BOOL result=[self.base executeUpdate:sql,mode.passtime,mode.text,mode.type,mode.video,mode.share_url,mode.gif,mode.image,mode.videoImage,@(mode.np),@(mode.imageWidth),@(mode.imageHeight)];
    if (!result) {
        NSLog(@"=====%@",[self.base lastErrorMessage]);
    }
    return result;
}
-(NSMutableArray *)selectAll:(NSString*)name{
    //1.sql语句
    NSString *sql=[NSString stringWithFormat:@"select * from %@",name];
    //2.执行查询
    FMResultSet *set=[self.base executeQuery:sql];
    //3.对结果进行遍历,取出数据
    NSMutableArray *dataArr=[NSMutableArray array];
    while ([set next]) {
        //从index 取出数据
        //int Id=[set intForColumnIndex:0];
        //NSLog(@"====%d",Id);
        TextModel *mode=[self extractModeFrom:set];
        [dataArr addObject:mode];
    }
    return dataArr;
}
-(void)deleteAll:(NSString*)name{
    //1.sql语句
    NSString *sql=[NSString stringWithFormat:@"delete from %@",name];
    //2.执行查询
    BOOL result=[self.base executeUpdate:sql];
    if (!result) {
        NSLog(@"=====%@",[self.base lastErrorMessage]);
    }
}
//查询的数据转换成mode
-(TextModel *)extractModeFrom:(FMResultSet *)set{
    //1.set 结果转换一个字典
    NSMutableDictionary *dic=(NSMutableDictionary *)[set resultDictionary];
    //2.Kvc 字典转成mode
    TextModel *mode=[[TextModel alloc]initWithDictionary2:dic];
    mode.np=[dic[@"np"] integerValue];
    // QYStudent *mode=[[QYStudent alloc] init];
    //[set kvcMagic:mode];
    
    return mode;
}


@end
