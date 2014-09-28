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
#import "TagDemo.h"

#define  URL_YOUTUBE_VIDEO @"http://youtubeinmp3.com/fetch/?video="


@implementation JPVideoDownloader
{
    AFHTTPRequestOperationManager *manager;
    TagDemo *tagChanger;
    int numBytes;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        numBytes = 15000;
        manager = [AFHTTPRequestOperationManager manager];
        AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
        tagChanger = [[TagDemo alloc]init];
        [serializer setAcceptableContentTypes:[NSSet setWithArray:@[@"text/html", @"image/jpeg", @"audio/mpeg"]]];
        manager.responseSerializer = serializer;
        
    }
    return self;
}
-(void)downloadVideo:(JPVideo *)video{
    NSMutableString *URL = [[NSMutableString alloc]initWithString:URL_YOUTUBE_VIDEO];
    [URL appendString:video.URL];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [manager GET:URL parameters:NULL
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSData *checker = responseObject;
             int bytes = (int)checker.length;
             
             if (bytes > numBytes) {
                 [fileManager createFileAtPath:video.filePath
                                      contents:responseObject
                                    attributes:NULL];
                 [tagChanger changeTagsOfVideo:video];
             }else{
                 NSLog(@"error downloading");
             }
             NSLog(@"paso por downloadVideo");
             
             
             
             video.donwloaded = YES;
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", error);
         }];
    

}

-(void)forceDownloadVideo:(JPVideo *)video{
    NSMutableString *URL = [[NSMutableString alloc]initWithString:URL_YOUTUBE_VIDEO];
    [URL appendString:video.URL];
    
    //comprobar esto
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [manager GET:URL parameters:NULL
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSData *checker = responseObject;
             int bytes = (int)checker.length;
             
             if (bytes > numBytes) {
                 [fileManager createFileAtPath:video.filePath
                                      contents:responseObject
                                    attributes:NULL];
                 [tagChanger changeTagsOfVideo:video];
             }else{
                 video.donwloaded = NO;
                 NSLog(@"error downloading");
             }
             //video.donwloaded = YES;
             NSLog(@"paso por forcedownloadVideo");
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", error);
         }];
}
@end
