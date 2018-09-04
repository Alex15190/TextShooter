//
//  BIDBulletNode.h
//  TextShooter
//
//  Created by Alex Chekodanov on 03.09.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BIDBulletNode : SKNode

+ (instancetype)bulletForm:(CGPoint)start toward:(CGPoint)destination;
- (void)applyRecurringForce;

@end
