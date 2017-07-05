//
//  AudioWrapper.h
//  Mp3Record
//
//  Created by Double on 2017/7/4.
//  Copyright © 2017年 Double. All rights reserved.
//

#ifndef AudioWrapper_h
#define AudioWrapper_h


#endif /* AudioWrapper_h */

#import <AVFoundation/AVFoundation.h>
#import "lame/lame.h"

@interface AudioWrapper:NSObject{
    // 类变量声明
}
// 类属性声明
// 类方法和声明

+ (void)audioPCMtoMP3:(NSString *)audioFileSavePath :(NSString *)mp3FilePath;


+ (void)convertFromWavToMp3:(NSString *)filePath;

+ (void)convertMp3Finish:(NSString *)mp3FilePath;

+ (void)toMp3:(NSString *)audioFileSavePath :(NSString *)mp3FilePath;

@end
