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



@implementation JPVideoDownloader : NSObject
{
    AFHTTPRequestOperationManager *manager;
    TagDemo *tagChanger;
}

- (id)init
{
    self = [super init];
    if (self) {
        manager = [AFHTTPRequestOperationManager manager];
        AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
        tagChanger = [[TagDemo alloc]init];
        [serializer setAcceptableContentTypes:[NSSet setWithArray:@[@"text/html", @"image/jpeg", @"audio/mpeg"]]];
        manager.responseSerializer = serializer;
        
    }
    return self;
}
-(void)downloadVideo:(JPVideo *)video{
    NSMutableString *URL = [[NSMutableString alloc]initWithString:@"http://youtubeinmp3.com/fetch/?video="];
    [URL appendString:video.URL];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [manager GET:URL parameters:NULL
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [fileManager createFileAtPath:video.filePath
                                  contents:responseObject
                                attributes:NULL];
             
             [tagChanger changeTagsOfVideo:video];
             video.donwloaded = YES;
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", error);
         }];
    

}

-(void)forceDownloadVideo:(JPVideo *)video{
    NSMutableString *URL = [[NSMutableString alloc]initWithString:@"http://youtubeinmp3.com/fetch/?video="];
    [URL appendString:video.URL];
    
    //comprobar esto
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [tagChanger changeTagsOfVideo:video];
    [manager GET:URL parameters:NULL
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [fileManager createFileAtPath:video.filePath
                                  contents:responseObject
                                attributes:NULL];
             NSData *data = [[NSData alloc]initWithData:responseObject];
             [tagChanger changeTagsOfVideo:video];
             video.donwloaded = YES;
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", error);
         }];
}
@end
