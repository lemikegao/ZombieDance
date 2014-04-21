//
//  ZDDanceMoveGangnamStyle.m
//  ZombieDance
//
//  Created by Michael Gao on 3/30/14.
//  Copyright (c) 2014 Chin and Cheeks LLC. All rights reserved.
//

#import "ZDDanceMoveGangnamStyle.h"

@implementation ZDDanceMoveGangnamStyle

- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        [self _setUpMotionRequirements];
        
        self.name = @"Gangnam Style";
    }
    
    return self;
}

- (void)_setUpMotionRequirements
{
    // Step 1
    ZDMotionRequirements *step1_1 = [[ZDMotionRequirements alloc] init];
    step1_1.rollMin = 0;
    step1_1.rollMax = 40;
    step1_1.pitchMin = -30;
    step1_1.pitchMax = 10;
    step1_1.accelerationZMax = -0.3;
    
    ZDMotionRequirements *step1_2 = [[ZDMotionRequirements alloc] init];
    step1_2.rollMin = -40;
    step1_2.rollMax = 0;
    step1_2.pitchMin = -20;
    step1_2.pitchMax = 30;
    step1_2.accelerationZMin = 0.3;
    
    // Step 1
    ZDMotionRequirements *step2_1 = [[ZDMotionRequirements alloc] init];
    step2_1.rollMin = 0;
    step2_1.rollMax = 40;
    step2_1.pitchMin = -30;
    step2_1.pitchMax = 10;
    step2_1.accelerationZMax = -0.3;
    
    ZDMotionRequirements *step2_2 = [[ZDMotionRequirements alloc] init];
    step2_2.rollMin = -40;
    step2_2.rollMax = 0;
    step2_2.pitchMin = -20;
    step2_2.pitchMax = 30;
    step2_2.accelerationZMin = 0.3;
    
    // Step 1
    ZDMotionRequirements *step3_1 = [[ZDMotionRequirements alloc] init];
    step3_1.rollMin = 0;
    step3_1.rollMax = 40;
    step3_1.pitchMin = -30;
    step3_1.pitchMax = 10;
    step3_1.accelerationZMax = -0.3;
    
    ZDMotionRequirements *step3_2 = [[ZDMotionRequirements alloc] init];
    step3_2.rollMin = -40;
    step3_2.rollMax = 0;
    step3_2.pitchMin = -20;
    step3_2.pitchMax = 30;
    step3_2.accelerationZMin = 0.3;
    
    // Step 1
    ZDMotionRequirements *step4_1 = [[ZDMotionRequirements alloc] init];
    step4_1.rollMin = 0;
    step4_1.rollMax = 40;
    step4_1.pitchMin = -30;
    step4_1.pitchMax = 10;
    step4_1.accelerationZMax = -0.3;
    
    ZDMotionRequirements *step4_2 = [[ZDMotionRequirements alloc] init];
    step4_2.rollMin = -40;
    step4_2.rollMax = 0;
    step4_2.pitchMin = -20;
    step4_2.pitchMax = 30;
    step4_2.accelerationZMin = 0.3;
    
    NSArray *step1Array = @[step1_1, step1_2];
    NSArray *step2Array = @[step2_1, step2_2];
    NSArray *step3Array = @[step3_1, step3_2];
    NSArray *step4Array = @[step4_1, step4_2];
    
    self.stepsArray = @[step1Array, step2Array, step3Array, step4Array];
}

@end
