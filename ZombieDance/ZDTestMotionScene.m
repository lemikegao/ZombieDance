//
//  ZDTestMotionScene.m
//  ZombieDance
//
//  Created by Michael Gao on 3/30/14.
//  Copyright (c) 2014 Chin and Cheeks LLC. All rights reserved.
//

#import "ZDTestMotionScene.h"
#import <CoreMotion/CoreMotion.h>
#import "ZDDanceMoveYMCA.h"
#import "ZDDanceMoveBernie.h"

@interface ZDTestMotionScene()

// temp variables for gyroscope tutorial
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) SKLabelNode *yawLabel;
@property (nonatomic, strong) SKLabelNode *pitchLabel;
@property (nonatomic, strong) SKLabelNode *rollLabel;
@property (nonatomic, strong) SKLabelNode *userAccelerationLabel;

// Dance move detection
@property (nonatomic, strong) ZDDanceMove *danceMove;
@property (nonatomic) int currentStep;
@property (nonatomic) int currentPart;
@property (nonatomic, strong) NSArray *currentDanceStepParts;

@end

@implementation ZDTestMotionScene

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self)
    {
        // Labels
        _yawLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        _pitchLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        _rollLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        _userAccelerationLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        
        _yawLabel.fontSize = 20;
        _pitchLabel.fontSize = 20;
        _rollLabel.fontSize = 20;
        _userAccelerationLabel.fontSize = 20;
        
        _yawLabel.text = @"Yaw: ";
        _pitchLabel.text = @"Pitch: ";
        _rollLabel.text = @"Roll: ";
        _userAccelerationLabel.text = @"User acceleration: ";
        
        _yawLabel.position = CGPointMake(100, 240);
        _pitchLabel.position = CGPointMake(100, 300);
        _rollLabel.position = CGPointMake(100, 360);
        _userAccelerationLabel.position = CGPointMake(100, 420);
        
        [self addChild:_yawLabel];
        [self addChild:_pitchLabel];
        [self addChild:_rollLabel];
        [self addChild:_userAccelerationLabel];
        
        // Motion manager
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = 1.0/60.0f;
        [_motionManager startDeviceMotionUpdates];
        
        // Dance move detcton
        _danceMove = [[ZDDanceMoveYMCA alloc] init];
        _currentDanceStepParts = _danceMove.stepsArray[0];
        _currentStep = 1;
        _currentPart = 1;
    }
    
    return self;
}

- (void)detectDancePart
{
    CGFloat yaw = (RadiansToDegrees(self.motionManager.deviceMotion.attitude.yaw));
    CGFloat pitch = (RadiansToDegrees(self.motionManager.deviceMotion.attitude.pitch));
    CGFloat roll = (RadiansToDegrees(self.motionManager.deviceMotion.attitude.roll));
    CMAcceleration totalAcceleration = self.motionManager.deviceMotion.userAcceleration;
    
    ZDMotionRequirements *currentPartMotionRequirements = self.currentDanceStepParts[self.currentPart-1];
    if ((totalAcceleration.x > currentPartMotionRequirements.accelerationXMin) &&
        (totalAcceleration.x < currentPartMotionRequirements.accelerationXMax) &&
        (totalAcceleration.y > currentPartMotionRequirements.accelerationYMin) &&
        (totalAcceleration.y < currentPartMotionRequirements.accelerationYMax) &&
        (totalAcceleration.z > currentPartMotionRequirements.accelerationZMin) &&
        (totalAcceleration.z < currentPartMotionRequirements.accelerationZMax)) {
        if ((currentPartMotionRequirements.rollRollover == MotionRolloverTypeMin && fabsf(roll) > currentPartMotionRequirements.rollMin) || (currentPartMotionRequirements.rollRollover == MotionRolloverTypeMax && fabsf(roll) > fabsf(currentPartMotionRequirements.rollMax)) ||
            (currentPartMotionRequirements.rollRollover == MotionRolloverTypeNone && (roll > currentPartMotionRequirements.rollMin) && (roll < currentPartMotionRequirements.rollMax)))
        {
            if ((yaw > currentPartMotionRequirements.yawMin) &&
                (yaw < currentPartMotionRequirements.yawMax) &&
                (pitch > currentPartMotionRequirements.pitchMin) &&
                (pitch < currentPartMotionRequirements.pitchMax))
            {

                NSLog(@"step: %lu, part: %lu detected", (unsigned long)self.currentStep, (unsigned long)self.currentPart);
                
                [self moveOnToNextPart];
            }
        }
    }
}

- (void)moveOnToNextPart
{
    if (self.currentPart == self.currentDanceStepParts.count)
    {
        [self moveOnToNextStep];
    }
    else
    {
        // Move on to next part
        self.currentPart++;
    }
}

- (void)moveOnToNextStep
{
    if (self.currentStep == self.danceMove.stepsArray.count)
    {
        // Finished iteration!
        self.currentStep = 1;
        self.currentPart = 1;
        self.currentDanceStepParts = _danceMove.stepsArray[0];
    }
    else
    {
        self.currentStep++;
        self.currentDanceStepParts = self.danceMove.stepsArray[self.currentStep-1];
        self.currentPart = 1;
    }
}

- (void)update:(NSTimeInterval)currentTime
{
    CGFloat yaw = (CGFloat)(RadiansToDegrees(self.motionManager.deviceMotion.attitude.yaw));
    CGFloat pitch = (CGFloat)(RadiansToDegrees(self.motionManager.deviceMotion.attitude.pitch));
    CGFloat roll = (CGFloat)(RadiansToDegrees(self.motionManager.deviceMotion.attitude.roll)); // roll is +90 (right-handed) and -90 (left-handed) when perpendicular to ground in landscape mode
    
    CMAcceleration totalAcceleration = self.motionManager.deviceMotion.userAcceleration;
    CMAcceleration gravity = self.motionManager.deviceMotion.gravity;
    CMAcceleration onlyUserAcceleration;
    onlyUserAcceleration.x = totalAcceleration.x - gravity.x;
    onlyUserAcceleration.y = totalAcceleration.y - gravity.y;
    onlyUserAcceleration.z = totalAcceleration.z - gravity.z;
    
    self.yawLabel.text = [NSString stringWithFormat:@"Yaw: %.0f", yaw];
    self.pitchLabel.text = [NSString stringWithFormat:@"Pitch: %.0f", pitch];
    self.rollLabel.text = [NSString stringWithFormat:@"Roll: %.0f", roll];
    if (fabsf(totalAcceleration.x > 0.5) || fabsf(totalAcceleration.y) > 0.5 || fabsf(totalAcceleration.z > 0.5))
    {
        NSString *text = [NSString stringWithFormat:@"User acceleration: (%.2f, %.2f, %.2f)", totalAcceleration.x, totalAcceleration.y, totalAcceleration.z];
        self.userAccelerationLabel.text = text;
//        NSLog(text);
    }
    
    [self detectDancePart];
}

- (void)dealloc
{
    [_motionManager stopDeviceMotionUpdates];
}

@end
