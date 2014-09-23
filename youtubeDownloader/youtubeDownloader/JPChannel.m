
//
//  JPChannel.m
//  youtubeDownloader
//
//  Created by Jose Maria Puerta on 31/05/14.
//  Copyright (c) 2014 Jose Maria Puerta. All rights reserved.
//

#import "JPChannel.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface JPChannel ()
@property (nonatomic, strong) JPVideoScrapper *scrapper;
@property (nonatomic, strong) JPVideoDownloader *donwloader;
@end

@implementation JPChannel

-(id)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        TagDemo *tag = [[TagDemo alloc]init];
        [tag demo];
    });

    self = [super init];
    if (self) {
        _scrapper = [[JPVideoScrapper alloc]init];
        _donwloader = [[JPVideoDownloader alloc]init];
        _channelName =  @"";
    }
    return self;
}
-(id)initWithName:(NSString *)name{
    self = [self init];
    _channelName = name;
    return self;
}

-(void)loadData{
    _scrapper.delegate = self;
    NSMutableString *URL = [NSMutableString stringWithString:FeedURLStart];
    [URL appendString:self.channelName];
    [URL appendString:FeedURLEnd];
    [_scrapper scrapWithURL:URL];
}

-(void)videoScrappingFinishedWithVideos:(NSArray *)videos{
    self.videos = [[NSMutableArray alloc]initWithArray:videos];
    for (JPVideo *video in videos) {
        [self.donwloader downloadVideo:video];

    }
    
    [self.delegate channelHasInfoOfVideos:self];
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

//    NSURL *url = [NSURL URLWithString:@"/Users/jmpg93/Documents/Bob.mp3"];
//    AudioFileID fileID = nil;
//    OSStatus error = noErr;
//    CFDictionaryRef piDict = nil;
//    
//    error = AudioFileOpenURL((__bridge CFURLRef)url,kAudioFileReadWritePermission, kAudioFileMP3Type, &fileID);
//    if (error != noErr) {
//        NSLog(@"AudioFileOpenURL failed");
//    }
//    
//    
//    UInt32 piDataSize   = sizeof(piDict);
//    AudioFileGetProperty( fileID, kAudioFilePropertyInfoDictionary, &piDataSize, &piDict );
//    NSLog(@"%@", (__bridge NSDictionary *)piDict);
//    
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    dict = (__bridge NSMutableDictionary*)piDict;
//    [dict setObject:@"NEW ALBUM NAME2222" forKey:@"album"];
//    piDict = (__bridge CFDictionaryRef)dict;
//    NSLog(@"%@", (__bridge NSDictionary *)piDict);
//    
//    piDataSize = sizeof(piDict);
//    OSStatus status = AudioFileSetProperty(fileID, kAudioFilePropertyInfoDictionary, piDataSize, &piDict);
//    NSLog(@"%d", (int)status);
//    
//    AudioFileGetProperty( fileID, kAudioFilePropertyInfoDictionary, &piDataSize, &piDict );
//    NSLog(@"%@", (__bridge NSDictionary *)piDict);
//    
//    AudioFileClose(fileID);
    
   }

- (void)loadArtworksForFileAtPath:(NSString *)path completion:(void (^)(NSArray *))completion
{
    NSURL *u =  [NSURL URLWithString:@"/Users/jmpg93/Documents/Bob.mp3"];
    AVURLAsset *a = [AVURLAsset URLAssetWithURL:u options:nil];
    NSArray *k = [NSArray arrayWithObjects:@"commonMetadata", nil];
    
    [a loadValuesAsynchronouslyForKeys:k completionHandler: ^{
        NSArray *artworks = [AVMetadataItem metadataItemsFromArray:a.commonMetadata
                                                           withKey:AVMetadataFormatID3Metadata
                                                          keySpace:AVMetadataKeySpaceCommon];
        
        NSMutableArray *artworkImages = [NSMutableArray array];
        for (AVMetadataItem *i in artworks)
        {
            NSString *keySpace = i.keySpace;
            CIImage *im = nil;
            
            if ([keySpace isEqualToString:AVMetadataKeySpaceID3])
            {
                NSDictionary *d = [i.value copyWithZone:nil];
                im = [CIImage imageWithData:[d objectForKey:@"data"]];
            }
            else if ([keySpace isEqualToString:AVMetadataKeySpaceiTunes])
                im = [CIImage imageWithData:[i.value copyWithZone:nil]];
            
            if (im)
                [artworkImages addObject:im];
        }
        
        completion(artworkImages);
    }];
}

@end
