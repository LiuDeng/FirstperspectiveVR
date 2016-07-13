//
//  VideoModel.h
//  FirstperspectiveVR
//
//  Created by qingyun on 16/7/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *typeid;
@property (nonatomic, strong) NSString *_description;
@property (nonatomic, strong) NSString *brief;
@property (nonatomic, strong) NSString *maxseq;
@property (nonatomic, strong) NSString *total;
@property (nonatomic  ) NSInteger finish;
@property (nonatomic, strong) NSString *seq_str;
@property (nonatomic, strong) NSString *directors;
@property (nonatomic, strong) NSString *actors;
@property (nonatomic, strong) NSString *writer;
@property (nonatomic, strong) NSString *posters;
@property (nonatomic, strong) NSString *authors;
@property (nonatomic, strong) NSString *voices;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *cate;
@property (nonatomic, strong) NSString *coopMovieid;
@property (nonatomic, strong) NSString *play_time;
@property (nonatomic, strong) NSString *update_brief;
@property (nonatomic, strong) NSString *television;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *hpic;
@property (nonatomic  ) NSInteger score;
@property (nonatomic, strong) NSString *score_float;
@property (nonatomic, strong) NSString *movie_type;
@property (nonatomic, strong) NSString *_3d;
@property (nonatomic, strong) NSArray *albums;
@property (nonatomic ) NSInteger duration;

+ (instancetype)videoModelWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary :(NSDictionary*)dict;
@end
