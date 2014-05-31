//
//  JPVideo.m
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import "JPVideo.h"

@implementation JPVideo
-(id)initWithDicctionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _title = [[dic objectForKey:@"title"]objectForKey:@"text"];
        _duration = [[[dic objectForKey:@"group"]objectForKey:@"duration"]objectForKey:@"seconds"];
        _URL = [[[dic objectForKey:@"group"]objectForKey:@"player"]objectForKey:@"url"];
        //_rating = [[dic objectForKey:@"rating"]objectForKey:@"avarage"];
        _published = [[dic objectForKey:@"published"]objectForKey:@"text"];
        //NSDate *date = [JPVideo dateFromString:self.published];
        _description = [[[dic objectForKey:@"group"]objectForKey:@"description"]objectForKey:@"text"];
    }
    return self;
}

+(NSDate*) dateFromString:(NSString*)dateString
{
    NSDate *date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    NSTimeZone *madridTZ = [NSTimeZone timeZoneWithName:@"Europe/Madrid"];
    [dateFormat setTimeZone:madridTZ];
    [dateFormat setDateFormat:@"yyyy-MM-ddTHH:mm:ss.zzzz"];
    date = [dateFormat dateFromString:dateString];
    return date;
}


@end
