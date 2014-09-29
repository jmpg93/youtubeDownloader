//
//  JPVideo.m
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import "JPVideo.h"
#import "JPChannel.h"

@implementation JPVideo

-(id)initWithDicctionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _title = [[dic objectForKey:@"title"]objectForKey:@"text"];
        
        NSString *aux = [NSString stringWithString:_title];
        NSRange range = [_title rangeOfString:@" - "];
        if (range.location < 100) {
            _artist = [_title substringToIndex:range.location];
            _title = [aux substringFromIndex:range.location + 3];
        }else{
            _artist = _albumOfSong;
        }
        
        aux = [[[dic objectForKey:@"link"]objectAtIndex:0]objectForKey:@"href"];
        range = [aux rangeOfString:@"v="];
        range.length = 11;
        range.location += 2;
        aux = [aux substringWithRange:range];
        
        _thumbnailURL = [NSString stringWithFormat:@"%@/%@%@", @"http://img.youtube.com/vi", aux,@"/1.jpg"];
        _duration = [[[dic objectForKey:@"group"]objectForKey:@"duration"]objectForKey:@"seconds"];
        _URL = [[[dic objectForKey:@"group"]objectForKey:@"player"]objectForKey:@"url"];
        _rating = [[[dic objectForKey:@"rating"]objectForKey:@"average"] floatValue];
        _max = 5;
        _min = 0;
        _published = [[dic objectForKey:@"published"]objectForKey:@"text"];
        _description = [[[dic objectForKey:@"group"]objectForKey:@"description"]objectForKey:@"text"];
        _donwloaded = false;
        _thumbnailImage = [[NSImage alloc]init];
        [self downloadImage];
        [self createFilePath];
        
        _dateReleased = [JPVideo dateFromString:self.published];
        [self calcDurationInMinutes];
    
    }
    return self;
}

+(NSDate*) dateFromString:(NSMutableString*)dateString
{
    NSString *auxDate = [[dateString substringFromIndex:11] substringToIndex:8];
    dateString = [NSMutableString stringWithString:[dateString substringToIndex:10]];
    [dateString appendString:auxDate];
    
    NSDate *date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSTimeZone *madridTZ = [NSTimeZone timeZoneWithName:@"Europe/Madrid"];
    [dateFormat setTimeZone:madridTZ];
    [dateFormat setDateFormat:@"yyyy-MM-ddHH:mm:ss"];
    date = [dateFormat dateFromString:dateString];
    
    return date;
}

-(void)calcDurationInMinutes{
    if (_duration) {
        int minutes = (int)[self.duration integerValue] / 60;
        int seconds = [self.duration integerValue] % 60;
        
        _duration = [NSString stringWithFormat:@"%d:%d", minutes, seconds];

    }
}

-(BOOL)isNew{
    
    BOOL isNew = false;
    NSDate *date = [NSDate date];
    int time = [date timeIntervalSinceDate:self.dateReleased];
    int timeAloowDownload = 2*60*60*24;
    
    isNew = (time < timeAloowDownload);
    return isNew;
}


-(void)getThumbnailImageInView:(NSView *) view{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"antes");
        NSURLRequest *req = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.thumbnailURL]];
        
            AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:req];
            requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
            [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSBitmapImageRep *repre = responseObject;
                NSData *data = [repre TIFFRepresentation];
                self.thumbnailImage = [[NSImage alloc]initWithData:data];
                NSImageView *imageView = [[NSImageView alloc]initWithFrame:CGRectMake(0, 0, 115, 83)];
                imageView.image = self.thumbnailImage;
                [view addSubview:imageView];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Image error: %@", error);
            }];
            [requestOperation start];
    });
        

}
-(void)downloadImage{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"antes");
        NSURLRequest *req = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.thumbnailURL]];
        
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:req];
        requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSBitmapImageRep *repre = responseObject;
            NSData *data = [repre TIFFRepresentation];
            self.thumbnailImage = [[NSImage alloc]initWithData:data];

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Image error: %@", error);
        }];
        [requestOperation start];
    });
    
}

-(BOOL)exists{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath: self.filePath];
    //NSData *song = [[NSData alloc]initWithContentsOfFile:self.filePath];
    self.donwloaded = !exist;
    return exist;
    
    
}

-(void)createFilePath{
    NSMutableString *path = [[NSMutableString alloc]initWithString:@"/Volumes/Disco local 2/jmpg93/Music/"];
    [path appendString:self.albumOfSong];
    
    NSMutableString *name = [[NSMutableString alloc]initWithString:self.title];
    [name appendString:@".mp3"];
    
    NSString  *filePath = [NSString stringWithFormat:@"%@/%@", path,name];
    
    self.filePath = filePath;
}


@end
