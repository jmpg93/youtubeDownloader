//
//  JPChannel.h
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPVideoScrapper.h"
#import "JPVideoDownloader.h"

#define FeedURL @"http://gdata.youtube.com/feeds/api/users/electropose1/uploads"

@interface JPChannel : NSObject <VideoScrapping>
@property (nonatomic, strong) NSMutableArray *videos;
@property (nonatomic, strong) NSString *feedURLVideos;

-(void)loadData;
-(void)downLoadLatestVideo;
-(void)refreshWithTimeInterval:(int)time;
@end
