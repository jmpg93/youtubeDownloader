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


#define FeedURLStart @"http://gdata.youtube.com/feeds/api/users/"
#define FeedURLEnd @"/uploads"

@protocol VideosInfo;

@interface JPChannel : NSObject <VideoScrapping>

@property (strong) id <VideosInfo> delegate;

@property (nonatomic, strong) NSMutableArray *videos;
@property (nonatomic, strong) NSString *feedURLVideos;
@property (nonatomic, strong) NSString *channelName;

-(id)initWithName:(NSString *)name;
-(void)loadData;
-(void)downLoadLatestVideo;
-(void)refreshWithTimeInterval:(int)time;

@end

@protocol VideosInfo <NSObject>

-(void)channelHasInfoOfVideos:(JPChannel*) channel;
@end