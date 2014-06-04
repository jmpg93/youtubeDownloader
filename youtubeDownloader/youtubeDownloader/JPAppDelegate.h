//
//  JPAppDelegate.h
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JPAppDelegate : NSObject <NSApplicationDelegate, NSCollectionViewDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) NSMutableArray *channelArray;
@property (strong, nonatomic) NSMutableArray *videosArray;
@property (strong, nonatomic) NSMutableDictionary *loadedVideosDic;
@property (weak) IBOutlet NSCollectionView *videosCollectionView;

@end
