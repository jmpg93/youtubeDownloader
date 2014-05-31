//
//  JPVideo.h
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPVideo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSURL *thumbnailImage;
@property (nonatomic, strong) NSString *URL;
@property (nonatomic, assign) float rating;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *published;

-(id)initWithDicctionary:(NSDictionary *)dic;
+(NSDate*) dateFromString:(NSString*)dateString;
@end
