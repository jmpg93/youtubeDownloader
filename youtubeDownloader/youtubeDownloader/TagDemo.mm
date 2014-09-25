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


- (void)changeTagsOfVideo:(JPVideo *)video {
    
    
    NSString *title = [[NSString alloc]init];
    NSString *artist = [[NSString alloc]init];
    NSString *album = [[NSString alloc]init];
    

    title = video.title;
    artist = video.artist;
    album= video.albumOfSong;
    
    NSString *path = video.filePath;
    
    // Read title tag
    ID3_Tag tag;
    tag.Link([path UTF8String]);

    
    
    // Write title tag
    
    tag.Link([path UTF8String]);
    tag.Strip(ID3TT_ALL);
    tag.Clear();

    //titulo
    
    ID3_Frame frame;
    frame.SetID(ID3FID_TITLE);
    frame.GetField(ID3FN_TEXT)->Set([title UTF8String]);
    tag.AddFrame(frame);
    
    
    //artista
    frame.SetID(ID3FID_LEADARTIST);
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
