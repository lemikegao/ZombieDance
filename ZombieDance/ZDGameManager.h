//
//  ZDGameManager.h
//  ZombieDance
//
//  Created by Michael Gao on 3/30/14.
//  Copyright (c) 2014 Chin and Cheeks LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;

@interface ZDGameManager : NSObject

+(ZDGameManager*)sharedGameManager;

// Audio
- (void)playBackgroundMusic:(NSString *)filename;
- (void)pauseBackgroundMusic;
- (void)playSoundEffect:(NSString*)filename;

@end
