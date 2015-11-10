//
//  MusicModel.m
//  0834MusicPlayer
//
//  Created by 郑建文 on 15/11/4.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel

//异常处理
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
    NSLog(@"error key : %@",key);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@", _mp3Url,_ID,_name,_picUrl,_blurPicUrl,_album,_singer,_duration,_artists_name,_lyric];
}

@end
