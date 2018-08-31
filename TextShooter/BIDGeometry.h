//
//  BIDGeometry.h
//  TextShooter
//
//  Created by Alex Chekodanov on 31.08.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#ifndef TextShooter_BIDGeometry_h
#define TextShooter_BIDGeometry_h

static inline CGVector BIDVectorMultiply(CGVector v, CGFloat m)
{
    return CGVectorMake (v.dx * m, v.dy * m);
}

static inline CGVector BIDVectorBetweenPoints(CGPoint p1, CGPoint p2)
{
    return CGVectorMake(p2.x - p1.x, p2.y - p1.y);
}

static inline CGFloat BIDVectorLength(CGVector v)
{
    return sqrtf(powf(v.dx, 2) + powf(v.dy, 2));
}

static inline CGFloat BIDPointDistance(CGPoint p1, CGPoint p2)
{
    return sqrtf(powf(p2.x - p1.x, 2) + powf(p2.y - p1.y, 2));
}

#endif /* BIDGeometry_h */
