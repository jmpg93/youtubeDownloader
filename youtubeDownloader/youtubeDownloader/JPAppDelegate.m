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
#import "TagDemo.h"

#import <gtm-oauth2/GTMOAuth2SignIn.h>


@interface JPAppDelegate()
    @property (nonatomic, strong) JPVideoDownloader *donwloader;
    @property (nonatomic, strong) GTMOAuth2Authentication *auth;
@end

@implementation JPAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _addChannelTextField = [[NSTextField alloc]init];

    _currentChannel = [[NSString alloc]init];
    int minutesToRefresh = 5;
    minutesToRefresh = minutesToRefresh*60;
    
    self.auth = [[GTMOAuth2Authentication alloc]init];
    self.channelArray = [[NSMutableArray alloc]init];
    self.videosArray = [[NSMutableArray alloc]init];
    _donwloader = [[JPVideoDownloader alloc]init];
    
    
    [self.channelsCollectionView setSelectable:YES];
    
    // Insert code here to initialize your application
    JPChannel *electropose1 = [[JPChannel alloc]initWithName:@"electropose1"];;
    [self.channelArray addObject:electropose1];
    
    JPChannel *majesticcasual = [[JPChannel alloc]initWithName:@"majesticcasual"];
    [self.channelArray addObject:majesticcasual];
    
    JPChannel *MrSuicideSheep = [[JPChannel alloc]initWithName:@"MrSuicideSheep"];
    [self.channelArray addObject:MrSuicideSheep];
    
    JPChannel *PandoraMuslc = [[JPChannel alloc]initWithName:@"PandoraMuslc"];
    [self.channelArray addObject:PandoraMuslc];
    
    
    JPChannel *soundisstyle = [[JPChannel alloc]initWithName:@"soundisstyle"];
    [self.channelArray addObject:soundisstyle];

    JPChannel *LaBelleChannel = [[JPChannel alloc]initWithName:@"LaBelleChannel"];
    [self.channelArray addObject:LaBelleChannel];
    
    
    [self loadDataOfChannels];
    for (JPChannel *chan in self.channelArray) {
        [chan refreshWithTimeInterval:minutesToRefresh];
    }
}

-(void)loadDataOfChannels{
    for(JPChannel *channel in self.channelArray){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [channel setDelegate:self];
            [channel loadData];
        });

    }
    
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
            video.donwloaded = NO;
            self.window.viewsNeedDisplay = YES;
            [self.donwloader forceDownloadVideo:video];
            return;
        }
    }
}
- (IBAction)changeChannel:(id)sender {
    NSButton *but = (NSButton*)sender;
    NSView *collectionView = but.superview;
    for (int i = 0; i < self.channelArray.count; i++) {
        NSView *aux = self.channelsCollectionView.subviews[i];
        if ([aux isEqual:collectionView]) {
            
            JPChannel *channel = [self.channelArray objectAtIndex:i];
            
            self.currentChannel = channel.channelName;

            
            self.videosArray = [NSMutableArray arrayWithArray:channel.videos];
            return;
        }
    }
}

-(void)channelHasInfoOfVideos:(JPChannel *)channel{
#warning this is shit
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.currentChannel = channel.channelName;
        
        [self.channelsCollectionView setContent:self.channelArray];
        
        self.videosArray = [NSMutableArray arrayWithArray:((JPChannel *)self.channelArray[0]).videos];
        
    });
}
- (IBAction)addChannel:(id)sender {
    NSLog (@"%@", self.addChannelTextField.stringValue);
    //[self.addChannelTextField setStringValue:@"hola"];
    
}




@end
