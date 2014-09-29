//
//  JPAppDelegate.h
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JPChannel.h"

@interface JPAppDelegate : NSObject <NSApplicationDelegate, NSCollectionViewDelegate, VideosInfo>

@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) NSMutableArray *channelArray;
@property (strong, nonatomic) NSMutableArray *videosArray;
@property (strong, nonatomic) NSMutableDictionary *loadedVideosDic;

@property (strong) IBOutlet NSCollectionView *videosCollectionView;
@property (strong) IBOutlet NSCollectionView *channelsCollectionView;
@property (strong) IBOutlet NSTextField *addChannelTextField;
@property (weak) IBOutlet NSButton *addChannelButton;

@property (strong) IBOutlet NSString *currentChannel;



@end
