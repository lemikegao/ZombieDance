//
//  ZDMyScene.m
//  ZombieDance
//
//  Created by Michael Gao on 3/18/14.
//  Copyright (c) 2014 Chin and Cheeks LLC. All rights reserved.
//

#import "ZDMyScene.h"
#import "ZDZombie.h"
#import <CoreMotion/CoreMotion.h>
#import "ZDDanceMoveBernie.h"
#import "ZDDanceMoveYMCA.h"
#import "ZDDanceMoveGangnamStyle.h"
#import "ZDGameManager.h"

@interface ZDMyScene()

@property (nonatomic, strong) NSMutableArray *zombies;
@property (nonatomic) NSTimeInterval lastUpdateTime;
@property (nonatomic) NSTimeInterval dt;
@property (nonatomic) BOOL isGameOver;
@property (nonatomic, strong) SKLabelNode *gameOverLabel;
@property (nonatomic) NSTimeInterval zombieSpawnInterval;
@property (nonatomic) NSTimeInterval zombieSpawnTimer;
@property (nonatomic) NSUInteger spawnCountPerInterval;

// Dance move detection
@property (nonatomic, strong) ZDDanceMove *danceMove;
@property (nonatomic) int currentStep;
@property (nonatomic) int currentPart;
@property (nonatomic, strong) NSArray *currentDanceStepParts;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) SKLabelNode *currentDanceMoveLabel;
@property (nonatomic) BOOL shouldDetectDanceMove;

@end

static CGFloat const kZombieMovePointsPerSec = 30;

@implementation ZDMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _spawnCountPerInterval = 0;
        _zombieSpawnInterval = 5;
        _zombieSpawnTimer = 0;
        _zombies = [[NSMutableArray alloc] initWithCapacity:50];
        _isGameOver = NO;
        _currentStep = 1;
        _currentPart = 1;
        _shouldDetectDanceMove = NO;
        
        // Motion manager
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = 1.0/60.0f;
        [_motionManager startDeviceMotionUpdates];
        
        _gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Bold"];
        _gameOverLabel.fontColor = [UIColor blackColor];
        _gameOverLabel.fontSize = 36;
        _gameOverLabel.text = @"You died!";
        _gameOverLabel.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.7);
        _gameOverLabel.hidden = YES;
        _gameOverLabel.zPosition = 10;
        [self addChild:_gameOverLabel];
        
        _currentDanceMoveLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        _currentDanceMoveLabel.fontColor = [UIColor blackColor];
        _currentDanceMoveLabel.fontSize = 24;
        _currentDanceMoveLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        _currentDanceMoveLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        _currentDanceMoveLabel.position = CGPointMake(self.size.width * 0.98, self.size.height * 0.98);
        _currentDanceMoveLabel.zPosition = 10;
        _currentDanceMoveLabel.alpha = 0;
        [self addChild:_currentDanceMoveLabel];
        
        // PLAY HAPPY!
        [[ZDGameManager sharedGameManager] playBackgroundMusic:@"happy_instrumental.mp3"];
        
        [self spawnZombie];
    }
    return self;
}

- (void)dealloc
{
    [self.motionManager stopDeviceMotionUpdates];
}

- (void)spawnZombie
{
    self.spawnCountPerInterval++;
    if (self.currentDanceMoveLabel.alpha < 1)
    {
        [self selectNextDanceMove];
    }
    
    int maxZombies = self.size.width / 25;
    int zombiePositionMultiplier = arc4random() % maxZombies - 1;
    
    ZDZombie *zombie = [[ZDZombie alloc] init];
    zombie.anchorPoint = CGPointMake(0, 1);
    zombie.position = CGPointMake(25 * zombiePositionMultiplier, self.size.height);
    [self addChild:zombie];
    
    [self.zombies addObject:zombie];
}

- (void)selectNextDanceMove
{
    self.currentStep = 1;
    self.currentPart = 1;
    
    // Select random dance move type
    NSString *sfxFilename;
    DanceMoveTypes danceMoveType = arc4random() % DanceMoveTypesCount;
    if (danceMoveType == DanceMoveTypesBernie)
    {
        self.danceMove = [[ZDDanceMoveBernie alloc] init];
        sfxFilename = @"bernie";
    }
    else if (danceMoveType == DanceMoveTypesYMCA)
    {
        self.danceMove = [[ZDDanceMoveYMCA alloc] init];
        sfxFilename = @"ymca";
    }
    else if (danceMoveType == DanceMoveTypesGangnam)
    {
        self.danceMove = [[ZDDanceMoveGangnamStyle alloc] init];
        sfxFilename = @"gangnam";
    }
    
    [[ZDGameManager sharedGameManager] playSoundEffect:[NSString stringWithFormat:@"%@.caf", sfxFilename]];
    self.currentDanceStepParts = self.danceMove.stepsArray[0];
    [self.currentDanceMoveLabel removeAllActions];
    self.currentDanceMoveLabel.text = self.danceMove.name;
    self.currentDanceMoveLabel.alpha = 1;
    
    self.shouldDetectDanceMove = YES;
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
        self.shouldDetectDanceMove = NO;
        
        // Finished iteration!
        [self killZombie];
    }
    else
    {
        self.currentStep++;
        self.currentDanceStepParts = self.danceMove.stepsArray[self.currentStep-1];
        self.currentPart = 1;
    }
}

- (void)killZombie
{
    [[ZDGameManager sharedGameManager] playSoundEffect:@"killZombie.wav"];
    ZDZombie *zombie = [self.zombies firstObject];
    [zombie runAction:[SKAction fadeOutWithDuration:0.2f] completion:^{
        [zombie removeFromParent];
        [self.zombies removeObject:zombie];
        
        if (self.zombies.count > 0)
        {
            [self selectNextDanceMove];
        }
    }];
    
    // Fade out dance move name
    [self.currentDanceMoveLabel runAction:[SKAction fadeOutWithDuration:0.1f]];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (self.isGameOver == NO)
    {
        if (self.lastUpdateTime) {
            self.dt = currentTime - self.lastUpdateTime;
        } else {
            self.dt = 0;
        }
        self.lastUpdateTime = currentTime;
        
        if (self.shouldDetectDanceMove)
        {
            [self detectDancePart];
        }
        
        if (self.zombieSpawnTimer >= self.zombieSpawnInterval)
        {
            self.zombieSpawnTimer = 0;
            if (self.zombieSpawnInterval > 2 || (self.zombieSpawnInterval == 2 && self.spawnCountPerInterval >= 30))
            {
                self.zombieSpawnInterval--;
                self.spawnCountPerInterval = 0;
            }
            [self spawnZombie];
        }
        
        [self.zombies enumerateObjectsUsingBlock:^(ZDZombie *zombie, NSUInteger idx, BOOL *stop) {
            zombie.position = CGPointMake(zombie.position.x, zombie.position.y - kZombieMovePointsPerSec * self.dt);
            
            // Check game over
            if (zombie.position.y <= zombie.size.height)
            {
                self.isGameOver = YES;
                self.gameOverLabel.hidden = NO;
                [[ZDGameManager sharedGameManager] pauseBackgroundMusic];
                [[ZDGameManager sharedGameManager] playSoundEffect:@"lose.wav"];
            }
        }];
        
        self.zombieSpawnTimer += self.dt;
    }
}

@end
