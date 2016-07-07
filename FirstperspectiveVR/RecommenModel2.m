//
//  RecommenModel2.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "RecommenModel2.h"
#import "Key.h"

@implementation RecommenModel2

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        _res_video_is_live = dict[KRes_video_is_live];
        _res_thumb_large = dict[KRes_thumb_large];
        _res_subtitle_file = dict[KRes_subtitle_file];
        _res_SD_filesize = dict[KRes_SD_filesize];
        _res_producter_id = dict[KRes_producter_id];
        _res_video_duration = dict[KRes_video_duration];
        _res_business_name = dict[KRes_business_name];
        _res_title = dict[KRes_title];
        _res_id = dict[KRes_id];
        _res_video_paly_mode = dict[KRes_video_play_mode];
        _res_downloadHD_url = dict[KRes_downloadHD_url];
        _res_is_payment = dict[KRes_is_payment];
        _res_thumb = dict[KRes_thumb];
        _res_pov_heading = dict[KRes_pov_heading];
        _res_payment = dict[KRes_payment];
        _res_business_id = dict[KRes_business_id];
        _res_video_dimension = dict[KRes_video_dimension];
        _res_high_playurl = dict[KRes_high_playurl];
        _res_new_flag = dict[KRes_new_flag];
        _res_HD_filesize = dict[KRes_HD_filesize];
        _res_score = dict[KRes_score];
        _res_scor_count = dict[KRes_scor_count];
        _res_type = [dict[KRes_type] integerValue];
        _res_download_count = dict[KRes_download_count];
        _res_creat_time = dict[KRes_creat_time];
        _res_general_palyurl = dict[KRes_general_palyurl];
        _res_standard_playurl = dict[KRes_standard_playurl];
        _res_is_panorama = [dict[KRes_is_panorama] integerValue];
        _res_subtitle = dict[KRes_subtitle];
    }
    return self;
}

+ (instancetype)recommenModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}

@end
