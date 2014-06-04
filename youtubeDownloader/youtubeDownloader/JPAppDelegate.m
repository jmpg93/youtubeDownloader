//
//  JPAppDelegate.m
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import "JPAppDelegate.h"
#import "JPChannel.h"
#import "JPVideo.h"
#import <gtm-oauth2/GTMOAuth2WindowController.h>

@implementation JPAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.channelArray = [[NSMutableArray alloc]init];
    
    // Insert code here to initialize your application
    JPChannel *channel = [[JPChannel alloc]init];
    //[channel checkID3];
    [channel refreshWithTimeInterval:60*1];
    [channel loadData];
    
    [channel addObserver:self
              forKeyPath:@"videos"
                 options:NSKeyValueChangeNewKey
                 context:NULL];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"videos"]) {
        [self.channelArray addObject:object];
        self.videosArray = ((JPChannel*)object).videos;
    }
}

@end
