//
//  JPChannel.m
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import "JPChannel.h"
#import <AudioToolbox/AudioToolbox.h>

@interface JPChannel ()
@property (nonatomic, strong) JPVideoScrapper *scrapper;
@property (nonatomic, strong) JPVideoDownloader *donwloader;
@end

@implementation JPChannel

-(id)init{
    self = [super init];
    if (self) {
        _scrapper = [[JPVideoScrapper alloc]init];
        _donwloader = [[JPVideoDownloader alloc]init];
        _channelName = [[NSString alloc]init];
        _channelName =  @"electropose1";
    }
    return self;
}

-(void)loadData{
    _scrapper.delegate = self;
    [_scrapper scrapWithURL:FeedURL];
}

-(void)videoScrappingFinishedWithVideos:(NSArray *)videos{
    self.videos = [[NSMutableArray alloc]initWithArray:videos];
    for (JPVideo *video in videos) {
        if ([video isNew]) {
            [self.donwloader downloadVideo:video];
        }
    }
    
    [self.delegate channelHasInfoOfVideos:self.videos];
}
-(void)downLoadLatestVideo{
    if (self.videos) {
        [self.donwloader downloadVideo:self.videos[0]];
    }
}

-(void)refreshWithTimeInterval:(int)time{
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(loadData)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)checkID3{
    //
    NSURL *url = [NSURL URLWithString:@"/Users/jmpg93/Documents/Bob.mp3"];
    AudioFileID fileID = nil;
    OSStatus error = noErr;
    CFDictionaryRef piDict = nil;
    
    error = AudioFileOpenURL((__bridge CFURLRef)url,kAudioFileReadWritePermission, kAudioFileMP3Type, &fileID);
    if (error != noErr) {
        NSLog(@"AudioFileOpenURL failed");
    }
    
    UInt32 id3DataSize  = 0;
    char *rawID3Tag    = NULL;
    
    error = AudioFileGetPropertyInfo(fileID, kAudioFilePropertyID3Tag, &id3DataSize, NULL);
    if (error != noErr)
        NSLog(@"AudioFileGetPropertyInfo failed for ID3 tag");
    
    rawID3Tag = (char *)malloc(id3DataSize);
    if (rawID3Tag == NULL)
        NSLog(@"could not allocate %d bytes of memory for ID3 tag", (unsigned int)id3DataSize);
    
    error = AudioFileGetProperty(fileID, kAudioFilePropertyID3Tag, &id3DataSize, rawID3Tag);
    if( error != noErr )
        NSLog(@"AudioFileGetPropertyID3Tag failed");
    
   
    UInt32 piDataSize   = sizeof(piDict);
    AudioFileGetProperty( fileID, kAudioFilePropertyInfoDictionary, &piDataSize, &piDict );
    NSLog(@"%@", (__bridge NSDictionary *)piDict);
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict = (__bridge NSMutableDictionary*)piDict;
    [dict setObject:@"NEW ALBUM NAME2222" forKey:@"album"];
    piDict = (__bridge CFDictionaryRef)dict;
    NSLog(@"%@", (__bridge NSDictionary *)piDict);
    
    
    piDataSize = sizeof(piDict);
    OSStatus status = AudioFileSetProperty(fileID, kAudioFilePropertyInfoDictionary, piDataSize, &piDict);
    NSLog(@"%d", (int)status);
    
    AudioFileGetProperty( fileID, kAudioFilePropertyInfoDictionary, &piDataSize, &piDict );
    NSLog(@"%@", (__bridge NSDictionary *)piDict);
    
    AudioFileClose(fileID);
    
   }

@end
