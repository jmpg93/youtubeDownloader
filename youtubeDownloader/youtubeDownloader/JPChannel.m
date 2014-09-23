
//
//  JPChannel.m
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import "JPChannel.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface JPChannel ()
@property (nonatomic, strong) JPVideoScrapper *scrapper;
@property (nonatomic, strong) JPVideoDownloader *donwloader;
@end

@implementation JPChannel

-(id)init{

    self = [super init];
    if (self) {
        _scrapper = [[JPVideoScrapper alloc]init];
        _donwloader = [[JPVideoDownloader alloc]init];
        _channelName =  @"";
    }
    return self;
}
-(id)initWithName:(NSString *)name{
    self = [self init];
    _channelName = name;
    return self;
}

-(void)loadData{
    _scrapper.delegate = self;
    NSMutableString *URL = [NSMutableString stringWithString:FeedURLStart];
    [URL appendString:self.channelName];
    [URL appendString:FeedURLEnd];
    [_scrapper scrapWithURL:URL];
}

-(void)videoScrappingFinishedWithVideos:(NSArray *)videos{
    self.videos = [[NSMutableArray alloc]initWithArray:videos];
    for (JPVideo *video in videos) {
        video.albumOfSong = self.channelName;
        [self.donwloader downloadVideo:video];

    }
    
    [self.delegate channelHasInfoOfVideos:self];
}
-(void)downLoadLatestVideo{
    if (self.videos) {
        [self.donwloader downloadVideo:self.videos[0]];
    }
}

-(void)refreshWithTimeInterval:(int)time{
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(loadData)
                                   userInfo:nil
                                    repeats:YES];
}


@end
