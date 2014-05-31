//
//  JPVideoScrapper.m
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import "JPVideoScrapper.h"
#import "JPVideo.h"
#import <XMLReader/XMLReader.h>
#import <AFNetworking/AFNetworking.h>

@interface JPVideoScrapper ()

@end

@implementation JPVideoScrapper
{
    AFHTTPRequestOperationManager *manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        manager = [AFHTTPRequestOperationManager manager];
        AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
        [serializer setAcceptableContentTypes:[NSSet setWithArray:@[@"text/html", @"image/jpeg", @"application/atom+xml"]]];
        manager.responseSerializer = serializer;
        
    }
    return self;
}

- (void)scrapWithURL:(NSString *)URL
{
    [manager GET:URL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self scrapWithData:responseObject];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"GET failed: %@",error);
         }];
    
}
- (void)scrapWithData:(NSData*) data
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSError *parseError = [[NSError alloc]init];
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLData:data
                                                              options:NSJSONWritingPrettyPrinted
                                                                error:NULL];
        
        xmlDictionary = [xmlDictionary objectForKey:@"feed"];
        NSMutableArray *arrayOfVideoDics = [xmlDictionary objectForKey:@"entry"];
        NSMutableArray *videos = [[NSMutableArray alloc]init];
        
        for (NSDictionary *videoDic in arrayOfVideoDics) {
            
            JPVideo *vid = [[JPVideo alloc]
                            initWithDicctionary:videoDic];
            
            [videos addObject:vid];
            

        }

        [self.delegate videoScrappingFinishedWithVideos:videos];

        
    });
}



@end
