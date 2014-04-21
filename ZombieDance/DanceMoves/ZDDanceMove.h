//
//  ZDDanceMove.h
//  ZombieDance
//
//  Created by Michael Gao on 3/21/14.
//  Copyright (c) 2014 Chin and Cheeks LLC. All rights reserved.
//

#import "ZDMotionRequirements.h"

typedef NS_ENUM(NSInteger, DanceMoveTypes)
{
    DanceMoveTypesNone = -1,
    DanceMoveTypesBernie,
    DanceMoveTypesYMCA,
    DanceMoveTypesGangnam,
    DanceMoveTypesCount,
};

@interface ZDDanceMove : NSObject

@property (nonatomic, strong) NSArray *stepsArray;
@property (nonatomic) NSString *name;

@end
