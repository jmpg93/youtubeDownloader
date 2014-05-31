//
//  JPVideoScrapper.h
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@protocol VideoScrapping;

@interface JPVideoScrapper : NSObject

@property (strong) id <VideoScrapping> delegate;

- (void)scrapWithURL:(NSString *)URL;

@end

@protocol VideoScrapping <NSObject>

- (void)videoScrappingFinishedWithVideos:(NSArray*) videos;

@end