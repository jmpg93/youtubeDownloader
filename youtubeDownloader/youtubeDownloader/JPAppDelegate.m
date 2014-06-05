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
    self.videosArray = [[NSMutableArray alloc]init];
    
    // Insert code here to initialize your application
    JPChannel *channel = [[JPChannel alloc]init];
    [channel setDelegate:self];
    //[channel checkID3];
    [channel refreshWithTimeInterval:60*60];
    [channel loadData];
    
    
    
}


- (IBAction)donwloadVideo:(id)sender {
    NSView *collectionView = ((NSButton *)sender).superview;
    for (int i = 0; i < self.videosArray.count; i++) {
        NSView *aux = self.videosCollectionView.subviews[i];
        if ([aux isEqual:collectionView]) {
            JPVideo *video = [self.videosArray objectAtIndex:i];
        }
    }
}
-(void)channelHasInfoOfVideos:(NSArray *)videos{
    [self.videosCollectionView setContent:videos];
    self.videosArray = videos;
    //[self.channelsCollectionView setContent:self.channelArray];
}

@end
