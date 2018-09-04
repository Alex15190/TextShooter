//
//  SKNode+Extra.h
//  TextShooter
//
//  Created by Alex Chekodanov on 04.09.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKNode (Extra)

- (void)receiveAttacker:(SKNode *)attacker contact:(SKPhysicsContact *)contact;
- (void)friendlyBumpFrom:(SKNode *)node;

@end
