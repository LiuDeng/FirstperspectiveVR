//
//  RecommenModel2.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommenModel2 : NSObject

@property (nonatomic, strong)NSString *res_video_is_live;
@property (nonatomic, strong)NSString *res_thumb_large;
@property (nonatomic, strong)NSString *res_subtitle_file;
@property (nonatomic, strong)NSString *res_SD_filesize;//SD版下载文件大小
@property (nonatomic, strong)NSString *res_producter_id;
@property (nonatomic, strong)NSString *res_video_duration;//播放时长
@property (nonatomic, strong)NSString *res_business_name;
@property (nonatomic, strong)NSString *res_title;//主标题
@property (nonatomic, strong)NSString *res_id;//网址参数
@property (nonatomic, strong)NSString *res_video_paly_mode;
@property (nonatomic, strong)NSString *res_downloadHD_url;//HD版下载地址
@property (nonatomic, strong)NSString *res_is_payment;
@property (nonatomic, strong)NSString *res_thumb;
@property (nonatomic, strong)NSString *res_pov_heading;
@property (nonatomic, strong)NSString *res_payment;
@property (nonatomic, strong)NSString *res_business_id;
@property (nonatomic, strong)NSString *res_video_dimension;
@property (nonatomic, strong)NSString *res_high_playurl;//高清播放地址
@property (nonatomic, strong)NSString *res_new_flag;
@property (nonatomic, strong)NSString *res_HD_filesize;//
@property (nonatomic, strong)NSString *res_score;
@property (nonatomic, strong)NSString *res_scor_count;
@property (nonatomic) NSInteger res_type;
@property (nonatomic, strong)NSString *res_download_count;
@property (nonatomic, strong)NSString *res_creat_time;
@property (nonatomic, strong)NSString *res_downloadSD_url;//SD版下载地址
@property (nonatomic, strong)NSString *res_general_palyurl;//播放地址
@property (nonatomic, strong)NSString *res_standard_playurl;//标清播放地址
@property (nonatomic) NSInteger res_is_panorama;
@property (nonatomic, strong)NSString *res_subtitle;

- (instancetype)initWithDictionary :(NSDictionary*)dict;
+ (instancetype)recommenModelWithDictionary :(NSDictionary*)dict;

@end
