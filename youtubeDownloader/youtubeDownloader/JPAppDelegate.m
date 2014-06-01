//
//  JPAppDelegate.m
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import "JPAppDelegate.h"
#import "JPChannel.h"
#import <gtm-oauth2/GTMOAuth2WindowController.h>

@implementation JPAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    JPChannel *channel = [[JPChannel alloc]init];
    [channel refreshWithTimeInterval:60*1];
    [channel loadData];
}

@end
