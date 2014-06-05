 //
//  JPVideoDownloader.m
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import <AudioToolbox/AudioToolbox.h>
#import "JPVideoDownloader.h"
#import "JPVideo.h"
@implementation JPVideoDownloader : NSObject
{
    AFHTTPRequestOperationManager *manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        manager = [AFHTTPRequestOperationManager manager];
        AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
        [serializer setAcceptableContentTypes:[NSSet setWithArray:@[@"text/html", @"image/jpeg", @"audio/mpeg"]]];
        manager.responseSerializer = serializer;
        
    }
    return self;
}
-(void)downloadVideo:(JPVideo *)video{
    NSMutableString *URL = [[NSMutableString alloc]initWithString:@"http://youtubeinmp3.com/fetch/?video="];
    [URL appendString:video.URL];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,   NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSMutableString *name = [[NSMutableString alloc]initWithString:video.title];
    [name appendString:@".mp3"];
    
    NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,name];
    
    bool exist = [[NSFileManager defaultManager] fileExistsAtPath: filePath];
    
    if(!exist){
        [manager GET:URL parameters:NULL
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 [responseObject writeToFile:filePath atomically:YES];

             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"%@", error);
             }];
    }

}
@end
