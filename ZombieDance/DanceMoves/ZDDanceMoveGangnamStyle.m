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
        
        self.name = @"YMCA";
    }
    
    return self;
}

- (void)_setUpMotionRequirements
{
    /* step 1 breakdown - 1 part */
    // part 1
    ZDMotionRequirements *step1_1 = [[ZDMotionRequirements alloc] init];
    step1_1.pitchMin = -80;
    step1_1.pitchMax = -20;
    
    /* step 2 breakdown - 4 parts */
    // part 1
    ZDMotionRequirements *step2_1 = [[ZDMotionRequirements alloc] init];
    step2_1.pitchMin = -80;
    step2_1.pitchMax = -20;
    step2_1.accelerationZMin = 0.3;
    
    // part 2
    ZDMotionRequirements *step2_2 = [[ZDMotionRequirements alloc] init];
    step2_2.pitchMin = -80;
    step2_2.pitchMax = -20;
    step2_2.accelerationZMax = -0.3;
    
    // part 3
    ZDMotionRequirements *step2_3 = [[ZDMotionRequirements alloc] init];
    step2_3.pitchMin = -80;
    step2_3.pitchMax = -20;
    step2_3.accelerationZMin = 0.3;
    
    // part 4
    ZDMotionRequirements *step2_4 = [[ZDMotionRequirements alloc] init];
    step2_4.pitchMin = -80;
    step2_4.pitchMax = -20;
    step2_4.accelerationZMax = -0.3;
    
    NSArray *step1Array = [NSArray arrayWithObject:step1_1];
    NSArray *step2Array = [NSArray arrayWithObjects:step2_1, step2_2, step2_3, step2_4, nil];
    
    self.stepsArray = [NSArray arrayWithObjects:step1Array, step2Array, nil];
}

@end
