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
#import "TimeoutAFHTTPRequestSerializer.h"

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
        _spinning = [[NSProgressIndicator alloc]init];
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
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
                     NSLog(@"error downloading (auto)");
                 }
                 
                 
                 video.donwloaded = YES;
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"%@", error);
             }];
    });

}

-(void)forceDownloadVideo:(JPVideo *)video{
    //[self getVideoLink:video withBlock:^(NSString *URL, NSError *error) {
        
        
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
                     NSLog(@"error downloading (force)");
                 }
                 //video.donwloaded = YES;
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"%@", error);
             }];
        
    //}];
}
-(void)getVideoLink:(JPVideo *)video withBlock:(void (^)(NSString *URL, NSError *error))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *URL = @"http://youtubeinmp3.com/fetch/?api=advanced&video=";
        URL = [NSString stringWithFormat:@"%@%@",URL,video.URL];
        AFHTTPRequestOperationManager *mana = [AFHTTPRequestOperationManager manager];
        AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
        [serializer setAcceptableContentTypes:[NSSet setWithArray:@[@"text/html", @"image/jpeg", @"audio/mpeg"]]];
        mana.responseSerializer = serializer;

        [mana GET:URL parameters:NULL
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 NSString *URLPlain = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                 NSRange range = [URLPlain rangeOfString:@"Link:"];
                 URLPlain = [URLPlain substringFromIndex:range.location+6];
                 range = [URLPlain rangeOfString:@"s="];
                 URLPlain = [URLPlain substringToIndex:range.location+3];
                 
                 block(URLPlain, NULL);
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"%@", error);
                 block(NULL, error);
                 
             }];
    });
}
@end
