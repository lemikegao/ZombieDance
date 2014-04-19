//
//  ZDConstants.h
//  ZombieDance
//
//  Created by Michael Gao on 3/30/14.
//  Copyright (c) 2014 Chin and Cheeks LLC. All rights reserved.
//

#ifndef ZombieDance_ZDConstants_h
#define ZombieDance_ZDConstants_h

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

#define DegreesToRadians(d) (M_PI * (d) / 180.0f)
#define RadiansToDegrees(r) ((r) * 180.0f / M_PI)

#define RGBA(r,g,b,a)				[SKColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)					RGBA(r, g, b, 1.0f)

#endif
