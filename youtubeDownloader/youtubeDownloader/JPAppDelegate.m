//
//  JPAppDelegate.m
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import "JPAppDelegate.h"
#import "JPVideoDownloader.h"
#import "JPChannel.h"
#import "JPVideo.h"
#import <gtm-oauth2/GTMOAuth2SignIn.h>


@interface JPAppDelegate()
    @property (nonatomic, strong) JPVideoDownloader *donwloader;
    @property (nonatomic, strong) GTMOAuth2Authentication *auth;
@end

@implementation JPAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.auth = [[GTMOAuth2Authentication alloc]init];
    self.channelArray = [[NSMutableArray alloc]init];
    self.videosArray = [[NSMutableArray alloc]init];
    _donwloader = [[JPVideoDownloader alloc]init];
    
    
    [self.channelsCollectionView setSelectable:YES];
    
    // Insert code here to initialize your application
    JPChannel *channel = [[JPChannel alloc]init];
    [channel setDelegate:self];
    //[channel checkID3];
    [channel refreshWithTimeInterval:60*60];
    [channel loadData];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        JPChannel *channel2 = [[JPChannel alloc]init];
        [channel2 setDelegate:self];
        channel.channelName = @"majesticcasual";
        [channel loadData];
    });
    
    
}


- (IBAction)donwloadVideo:(id)sender {
    
    NSButton *but = (NSButton*)sender;
    NSView *collectionView = but.superview;
    for (int i = 0; i < self.videosArray.count; i++) {
        NSView *aux = self.videosCollectionView.subviews[i];
        if ([aux isEqual:collectionView]) {
            JPVideo *video = [self.videosArray objectAtIndex:i];
            [but setEnabled:NO];
            [but setNeedsDisplay:YES];
            [self.donwloader forceDownloadVideo:video];
        }
    }
}
-(void)channelHasInfoOfVideos:(JPChannel *)channel{
#warning this is shit
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.channelArray addObject:channel];
        [self.channelsCollectionView setContent:self.channelArray];
        
        self.videosArray = [NSMutableArray arrayWithArray:channel.videos];
        [self.videosCollectionView setContent:channel.videos];
        [self.videosCollectionView setNeedsDisplay:YES];

    for (int i = 0; i < self.videosArray.count; i++) {
        
        NSCollectionViewItem *item = [self.videosCollectionView itemAtIndex:i];
        
        NSArray *views = item.view.subviews;
        
        for (NSView *view in views) {
            
            if ([view.identifier  isEqual: @"but"] && ((JPVideo*)[self.videosArray objectAtIndex:i]).donwloaded) {
                [((NSButton *)view)setEnabled:NO];
            }
            
        }
    }
    });
}

@end
