//
//  JPChannel.m
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import "JPChannel.h"

@interface JPChannel ()
@property (nonatomic, strong) JPVideoScrapper *scrapper;

@end

@implementation JPChannel 
-(id)init{
    self = [super init];
    if (self) {
        _scrapper = [[JPVideoScrapper alloc]init];
    }
    return self;
}

-(void)loadData{
    _scrapper.delegate = self;
    [_scrapper scrapWithURL:FeedURL];
}

-(void)videoScrappingFinishedWithVideos:(NSArray *)videos{
    self.videos = videos;
    JPVideoDownloader *donwloader = [[JPVideoDownloader alloc]init];
    [donwloader downloadVideo:videos[0]];
}




@end
