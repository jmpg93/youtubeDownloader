//
//  TagDemo.m
//  libid3
//
//  Created by 徐 楽楽 on 12/01/25.
//  Copyright (c) 2012年 ラクラクテクノロジーズ. All rights reserved.
//

#import "JPVideo.h"

#import "TagDemo.h"
#import <id3/tag.h>
#import <id3/id3lib_streams.h>

@implementation TagDemo
using namespace std;

- (void)demo {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"amazing-grace-10s" ofType:@"mp3"];
    
    
    //NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *docPath = [[docPaths objectAtIndex:0] stringByAppendingPathComponent:@"amazing-grace-10s.mp3"];
     NSString *docPath = @"/Users/jmpg93/Desktop/amazing-grace-10s.mp3";

    [[NSFileManager defaultManager] copyItemAtPath:path toPath:docPath error:nil];
    
    // Read title tag
    ID3_Tag tag;
    tag.Link([path UTF8String]);
    
    ID3_Frame *titleFrame = tag.Find(ID3FID_TITLE);
    unicode_t const *value = titleFrame->GetField(ID3FN_TEXT)->GetRawUnicodeText();
    NSString *title = [NSString stringWithCString:(char const *) value encoding:NSUnicodeStringEncoding];
    NSLog(@"The title before is %@", title);


    // Write title tag
    tag.Link([docPath UTF8String]);
    tag.Strip(ID3TT_ALL);
    tag.Clear();
    
    ID3_Frame frame;
    frame.SetID(ID3FID_TITLE);
    frame.GetField(ID3FN_TEXTENC)->Set(ID3TE_UNICODE);
    NSString *newTitle = @"Titulo2";
    frame.GetField(ID3FN_TEXT)->Set((unicode_t *) [newTitle cStringUsingEncoding:NSUTF16StringEncoding]);
    

    tag.AddFrame(frame);

    tag.SetPadding(false);
    tag.SetUnsync(false);
    tag.Update(ID3TT_ID3V2);
    
    
}


- (void)changeTagsOfVideo:(JPVideo *)video {
    
    
    NSString *title = [[NSString alloc]init];
    NSString *artist = [[NSString alloc]init];
    NSString *album = [[NSString alloc]init];
    

    title = video.title;
    artist = video.artist;
    album= video.albumOfSong;
    
    NSString *path = video.filePath;
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [[docPaths objectAtIndex:0] stringByAppendingPathComponent:video.title];
    
    [[NSFileManager defaultManager] copyItemAtPath:path toPath:docPath error:nil];
    
    // Read title tag
    ID3_Tag tag;
    tag.Link([path UTF8String]);
   // ID3_Frame *titleFrame = tag.Find(ID3FID_TITLE);

    
    
    // Write title tag
    
    tag.Link([docPath UTF8String]);
    tag.Strip(ID3TT_ALL);
    tag.Clear();

    //titulo
    
    ID3_Frame frame;
    frame.SetID(ID3FID_TITLE);
    frame.GetField(ID3FN_TEXT)->Set([title UTF8String]);
    tag.AddFrame(frame);
    
    
    //artista
    frame.SetID(ID3FID_COMPOSER);
    frame.GetField(ID3FN_TEXT)->Set([artist UTF8String]);
    tag.AddFrame(frame);
    
    //artista
    frame.SetID(ID3FID_ALBUM);
    frame.GetField(ID3FN_TEXT)->Set([album UTF8String]);
    tag.AddFrame(frame);
    
    tag.SetPadding(false);
    tag.SetUnsync(true);
    tag.Update(ID3TT_ID3V2);
    

    

}


@end
