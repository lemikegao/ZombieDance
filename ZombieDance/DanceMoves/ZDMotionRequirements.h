//
//  ZDMotionRequirements.h
//  ZombieDance
//
//  Created by Michael Gao on 3/18/14.
//  Copyright (c) 2014 Chin and Cheeks LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MotionRolloverType)
{
    MotionRolloverTypeNone = 0,
    MotionRolloverTypeMin,
    MotionRolloverTypeMax,
};

@interface ZDMotionRequirements : NSObject

@property (nonatomic) CGFloat yawMin;
@property (nonatomic) CGFloat yawMax;
@property (nonatomic) CGFloat pitchMin;
@property (nonatomic) CGFloat pitchMax;
@property (nonatomic) CGFloat rollMin;
@property (nonatomic) CGFloat rollMax;
@property (nonatomic) CGFloat accelerationXMin;
@property (nonatomic) CGFloat accelerationXMax;
@property (nonatomic) CGFloat accelerationYMin;
@property (nonatomic) CGFloat accelerationYMax;
@property (nonatomic) CGFloat accelerationZMin;
@property (nonatomic) CGFloat accelerationZMax;

@property (nonatomic) MotionRolloverType rollRollover;

@end
