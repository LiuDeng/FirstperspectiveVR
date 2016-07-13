//
//  VideoModel.m
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "VideoModel.h"
#import "Key.h"

@implementation VideoModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        _id = dict[KId];
        _source = dict[KSource];
        _title = dict[KTitle];
        _typeid = dict[KTypeid];
        __description = dict[KDescription];
        _brief = dict[KBrief];
        _maxseq = dict[KMaxseq];
        _total = dict[KTotal];
        _finish = [dict[KFinish] integerValue];
        _seq_str = dict[KSeqstr];
        _directors = dict[KDirectors];
        _actors = dict[KActors];
        _writer = dict[KWriters];
        _posters = dict[KPosters];
        _authors = dict[KAutors];
        _voices = dict[KVoices];
        _area = dict[KArea];
        _cate = dict[KCate];
        _coopMovieid = dict[KCoopMovieid];
        _play_time = dict[KPlay_time];
        _update_brief = dict[KUpdate_brief];
        _television = dict[KTelevision];
        _pic = dict[KPic];
        _hpic = dict[KHpic];
        _score = [dict[KScore] integerValue];
        _score_float = dict[Kscore_float];
        _movie_type = dict[KMovie_type];
        __3d = dict[K3d];
        _albums = dict[KAlbums];
        _duration = [dict[KDuration] integerValue];
    }
    return self;
}

+ (instancetype)videoModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

@end
