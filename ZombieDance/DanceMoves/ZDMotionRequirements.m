//
//  ZDMotionRequirements.m
//  ZombieDance
//
//  Created by Michael Gao on 3/18/14.
//  Copyright (c) 2014 Chin and Cheeks LLC. All rights reserved.
//

#import "ZDMotionRequirements.h"

#define kYawMin -400.0
#define kYawMax 400.0
#define kPitchMin -400.0
#define kPitchMax 400.0
#define kRollMin -400.0
#define kRollMax 400.0
#define kAccelerationXMin -1000.0
#define kAccelerationXMax 1000.0
#define kAccelerationYMin -1000.0
#define kAccelerationYMax 1000.0
#define kAccelerationZMin -1000.0
#define kAccelerationZMax 1000.0

@implementation ZDMotionRequirements

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        self.yawMin = kYawMin;
        self.yawMax = kYawMax;
        self.pitchMin = kPitchMin;
        self.pitchMax = kPitchMax;
        self.rollMin = kRollMin;
        self.rollMax = kRollMax;
        self.accelerationXMin = kAccelerationXMin;
        self.accelerationXMax = kAccelerationXMax;
        self.accelerationYMin = kAccelerationYMin;
        self.accelerationYMax = kAccelerationYMax;
        self.accelerationZMin = kAccelerationZMin;
        self.accelerationZMax = kAccelerationZMax;
        
        _rollRollover = MotionRolloverTypeNone;
    }
    
    return self;
}

@end
