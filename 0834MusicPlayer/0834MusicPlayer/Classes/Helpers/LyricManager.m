//
//  LyricManager.m
//  0834MusicPlayer
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "LyricManager.h"

#import "LyricModel.h"

@interface LyricManager()
//用来存放歌词
@property(nonatomic,strong)NSMutableArray * lyrics;
@end



static LyricManager * lyricManager = nil;

@implementation LyricManager

//创建单例对象方法
+(id)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lyricManager = [LyricManager new];
    });
    return lyricManager;
}

//
-(void)loadLyricWith:(NSString *)lyricStr{
    //1.分行
    NSMutableArray * lyricStringArray = [[lyricStr componentsSeparatedByString:@"\n"] mutableCopy];//字符串截取,返回数组
    //最后一行是@""
    [lyricStringArray removeLastObject];//要先将最后一行移除
    //要先将之前歌曲的歌词移除
    [self.lyrics removeAllObjects];
    for (NSString * str in lyricStringArray) {
        NSLog(@"%@",str);
        
        if ([str isEqualToString:@""]) {
            continue;
        }
        //2.分开时间和歌词
        NSArray * timeAndLyric = [str componentsSeparatedByString:@"]"];
        //str = [00:18.030]大部分人要我学习去看 世俗的眼光
        //3.去掉时间左边的"["
        NSString * time = [timeAndLyric[0] substringFromIndex:1];
        //time = 00:18.030
        //4.截取时间获取分和秒
        NSArray * minuteAndSecond = [time componentsSeparatedByString:@":"];
        NSInteger minute = [minuteAndSecond[0] integerValue];//分
        double second = [minuteAndSecond[1] doubleValue];//秒
        //5.装成一个model
        LyricModel * model = [[LyricModel alloc]initWithTime:(minute * 60 + second) lyric:timeAndLyric[1]];
        //6.添加到数组中
        [self.lyrics addObject:model];
    }
}

#pragma mark --- 懒加载
-(NSMutableArray *)lyrics{
    if (!_lyrics) {
        _lyrics = [NSMutableArray new];
    }
    return _lyrics;
}

//getter方法
-(NSArray *)allLyric{
    return _lyrics;
}

-(NSInteger)indexWith:(NSTimeInterval)time{
    NSInteger index = 0;
    for (int i = 0; i < _lyrics.count; i++) {
        //遍历数组,找到还没有播放的那一句歌词
        LyricModel * model = _lyrics[i];
        if (model.time > time) {
            //注意如果是第0个元素,而且元素时间比要播放的时间大,i- 1就会小于0,这样tableview就会崩溃
            index = (i - 1 > 0)?i - 1 : 0;
            //一定要break,要不就会一直循环下去
            break;
        }
    }
    return index;
}

@end
