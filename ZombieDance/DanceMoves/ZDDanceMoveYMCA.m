//
//  ZDDanceMoveYMCA.m
//  ZombieDance
//
//  Created by Michael Gao on 3/30/14.
//  Copyright (c) 2014 Chin and Cheeks LLC. All rights reserved.
//

#import "ZDDanceMoveYMCA.h"

@implementation ZDDanceMoveYMCA

- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        [self _setUpMotionRequirements];
        
        self.name = @"YMCA";
    }
    
    return self;
}

- (void)_setUpMotionRequirements
{
    /* step 1 breakdown - 1 part */
    // part 1
    ZDMotionRequirements *step1_1 = [[ZDMotionRequirements alloc] init];
    step1_1.rollMin = -30;
    step1_1.rollMax = 60;
    step1_1.pitchMin = 40;
    step1_1.pitchMax = 90;
//    step1_1.accelerationYMin = 0.3;
//    step1_1.accelerationZMax = -0.3;
    
    /* step 2 breakdown - 1 part */
    // part 1
    ZDMotionRequirements *step2_1 = [[ZDMotionRequirements alloc] init];
    step2_1.rollMin = -180;
    step2_1.rollMax = -130;
    step2_1.rollRollover = MotionRolloverTypeMax;
    step2_1.pitchMin = -30;
    step2_1.pitchMax = 50;
//    step2_1.accelerationYMin = 0.2;
//    step2_1.accelerationZMin = 0.3;
    
    /* step 3 breakdown - 1 part */
    // part 1
    ZDMotionRequirements *step3_1 = [[ZDMotionRequirements alloc] init];
    step3_1.rollMin = -30;
    step3_1.rollMax = 30;
    step3_1.pitchMin = -20;
    step3_1.pitchMax = 50;
//    step3_1.accelerationYMin = 0.3;
//    step3_1.accelerationZMax = -0.3;
    
    /* step 4 breakdown - 1 part */
    // part 1
    ZDMotionRequirements *step4_1 = [[ZDMotionRequirements alloc] init];
    step4_1.rollMin = 140;
    step4_1.rollMax = 180;
    step4_1.rollRollover = MotionRolloverTypeMin;
    step4_1.pitchMin = 20;
    step4_1.pitchMax = 70;
//    step4_1.accelerationYMin = 0.2;
//    step4_1.accelerationZMax = 0.3;
    
    NSArray *step1Array = @[step1_1];
    NSArray *step2Array = @[step2_1];
    NSArray *step3Array = @[step3_1];
    NSArray *step4Array = @[step4_1];
    
    /* step 4 breakdown - 1 part */
    // part 1
    
    self.stepsArray = @[step1Array, step2Array, step3Array, step4Array];
}

@end
