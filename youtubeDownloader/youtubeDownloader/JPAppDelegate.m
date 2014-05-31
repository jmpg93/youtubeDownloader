//
//  JPAppDelegate.m
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import "JPAppDelegate.h"
#import "JPChannel.h"

@implementation JPAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    JPChannel *channel = [[JPChannel alloc]init];
    [channel loadData];
    //
}

@end
