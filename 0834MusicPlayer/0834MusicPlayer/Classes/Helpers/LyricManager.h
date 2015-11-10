//
//  LyricManager.h
//  0834MusicPlayer
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LyricManager : NSObject
//对外的歌词数组
@property(nonatomic,strong)NSArray * allLyric;

+(id)sharedManager;
-(void)loadLyricWith:(NSString *)lyricStr;
/**
 *  根据播放时间获取到该播放的歌词的索引
 *
 *  @param time <#time description#>
 *
 *  @return <#return value description#>
 */

-(NSInteger)indexWith:(NSTimeInterval)time;
@end
