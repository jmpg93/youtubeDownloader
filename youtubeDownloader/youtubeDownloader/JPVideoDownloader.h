//
//  JPVideoDownloader.h
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "JPVideoDownloader.h"
#import "JPVideo.h"

@interface JPVideoDownloader : NSObject
-(void)downloadVideo:(JPVideo *)video;
@end
