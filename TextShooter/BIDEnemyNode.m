//
//  BIDEnemyNode.m
//  TextShooter
//
//  Created by Alex Chekodanov on 03.09.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import "BIDEnemyNode.h"
#import "BIDPhysicsCategories.h"
#import "BIDGeometry.h"

@implementation BIDEnemyNode

- (instancetype)init
{
    if (self = [super init])
    {
        self.name = [NSString stringWithFormat:@"Enemy %p", self];
        [self initNodeGraph];
        [self initPhysicsBody];
    }
    return self;
}

- (void)initPhysicsBody
{
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(40, 40)];
    body.affectedByGravity = NO;
    body.categoryBitMask = EnemyCategory;
    body.contactTestBitMask = PlayerCategory|EnemyCategory;
    body.mass = 0.2;
    body.angularDamping = 0.0f;
    body.linearDamping = 0.0f;
    self.physicsBody = body;
}

- (void)initNodeGraph
{
    SKLabelNode *topRow = [SKLabelNode labelNodeWithFontNamed:@"Courier-Bold"];
    topRow.fontColor = [SKColor brownColor];
    topRow.fontSize = 20;
    topRow.text = @"x x";
    topRow.position = CGPointMake(0,15);
    [self addChild:topRow];
    
    SKLabelNode *middleRow = [SKLabelNode labelNodeWithFontNamed:@"Courier-Bold"];
    middleRow.fontColor = [SKColor brownColor];
    middleRow.fontSize = 20;
    middleRow.text = @"x";
    [self addChild:middleRow];
    
    SKLabelNode *bottomRow = [SKLabelNode labelNodeWithFontNamed:@"Courier-Bold"];
    bottomRow.fontColor = [SKColor brownColor];
    bottomRow.fontSize = 20;
    bottomRow.text = @"x x";
    bottomRow.position = CGPointMake(0, -15);
    [self addChild:bottomRow];
}


@end
