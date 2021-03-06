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
@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSImage *thumbnailImage;
@property (nonatomic, strong) NSString *thumbnailURL;
@property (nonatomic, strong) NSString *URL;
@property (nonatomic, assign) float rating;
@property (nonatomic, assign) float max;
@property (nonatomic, assign) float min;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *albumOfSong;
@property (nonatomic, strong) NSString *published;
@property (nonatomic, strong) NSDate *dateReleased;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, assign) BOOL donwloaded;
@property (nonatomic, assign) BOOL imageSee;

@property (nonatomic, strong) NSImage *donwloadImage;

-(id)initWithDicctionary:(NSDictionary *)dic;
+(NSDate*) dateFromString:(NSString*)dateString;
-(BOOL)isNew;
-(BOOL)exists;
-(void)getThumbnailImageInView:(NSView *) view;
-(void)downloadImage;
@end
