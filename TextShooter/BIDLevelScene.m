//
//  GameScene.m
//  TextShooter
//
//  Created by Alex Chekodanov on 31.08.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import "BIDLevelScene.h"
#import "BidPlayerNode.h"
#import "BIDEnemyNode.h"
#import "BIDBulletNode.h"

#define ARC4RANDOM_MAX 0x100000000


@interface BIDLevelScene ()

@property (strong, nonatomic) BidPlayerNode *playerNode;
@property (strong, nonatomic) SKNode *enemies;
@property (strong, nonatomic) SKNode *playerBullets;

@end

@implementation BIDLevelScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

+ (instancetype)sceneWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber
{
    return [[self alloc] initWithSize:size levelNumber:levelNumber];
}

- (instancetype)initWithSize:(CGSize)size
{
    return [self initWithSize:size levelNumber:1];
}

- (instancetype)initWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber
{
    if (self = [super initWithSize:size])
    {
        _levelNumber = levelNumber;
        _playerLives = 5;
        
        self.backgroundColor = [SKColor whiteColor];
        
        SKLabelNode *lives = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        lives.fontSize = 16;
        lives.fontColor = [SKColor blackColor];
        lives.name = @"LivesLabel";
        lives.text = [NSString stringWithFormat:@"Lives: %lu", (unsigned long)_playerLives];
        lives.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        lives.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        lives.position = CGPointMake(self.frame.size.width, self.frame.size.height);
        [self addChild:lives];
        
        SKLabelNode *level = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        level.fontSize = 16;
        level.fontColor = [SKColor blackColor];
        level.name = @"LevelLabel";
        level.text = [NSString stringWithFormat:@"Level: %lu", (unsigned long)_levelNumber];
        level.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        level.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level.position = CGPointMake(0, self.frame.size.height);
        [self addChild:level];
        
        _playerNode = [BidPlayerNode node];
        _playerNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame)*0.1);
        [self addChild: _playerNode];
        
        _enemies = [SKNode node];
        [self addChild:_enemies];
        [self spawnEnemies];
        
        _playerBullets = [SKNode node];
        [self addChild:_playerBullets];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        if (location.y < CGRectGetHeight(self.frame) * 0.2)
        {
            CGPoint target = CGPointMake(location.x, self.playerNode.position.y);
            CGFloat duration = [self.playerNode moveToward:target];
        }
        else
        {
            BIDBulletNode *bullet = [BIDBulletNode bulletForm:self.playerNode.position toward:location];
            if (bullet) [self.playerBullets addChild:bullet];
        }
    }
}

- (void)spawnEnemies
{
    NSUInteger count = log(self.levelNumber) + self.levelNumber;
    for (NSUInteger i = 0; i < count; i++)
    {
        BIDEnemyNode *enemy = [BIDEnemyNode node];
        CGSize size = self.frame.size;
        CGFloat x = (size.width * 0.8 * arc4random()/ARC4RANDOM_MAX) + (size.width *0.1);
        CGFloat y = (size.height * 0.5 * arc4random()/ARC4RANDOM_MAX) + (size.height * 0.5);
        enemy.position = CGPointMake(x, y);
        [self.enemies addChild:enemy];
    }
}

- (void)update:(NSTimeInterval)currentTime
{
    if (self.finished) return;
    
    [self updateBullets];
    [self updateEnemies];
    [self checkForNextLevel];
}

- (void)checkForNextLevel
{
    if ([self.enemies.children count] == 0)
        [self goToNextLevel];
}

- (void)goToNextLevel
{
    self.finished = YES;
    
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
    label.text = @"Level Complete!";
    label.fontColor = [SKColor blueColor];
    label.fontSize = 32;
    label.position = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    [self addChild:label];
    
    BIDLevelScene *nextLevel = [[BIDLevelScene alloc] initWithSize:self.frame.size levelNumber:self.levelNumber +1];
    nextLevel.playerLives = self.playerLives;
    [self.view presentScene:nextLevel transition:[SKTransition flipHorizontalWithDuration:1.0]];
}

- (void)updateEnemies
{
    NSMutableArray *enemiesToRemove = [NSMutableArray array];
    for (SKNode *node in self.enemies.children)
    {
        if (!CGRectContainsPoint(self.frame, node.position))
        {
            [enemiesToRemove addObject:node];
            continue;
        }
    }
    if ([enemiesToRemove count] > 0) [self.enemies removeChildrenInArray:enemiesToRemove];
}

- (void)updateBullets
{
    NSMutableArray * bulletsToRemove = [NSMutableArray array];
    for (BIDBulletNode *bullet in self.playerBullets.children)
    {
        if (!CGRectContainsPoint(self.frame, bullet.position))
        {
            [bulletsToRemove addObject:bullet];
            continue;
        }
        [bullet applyRecurringForce];
    }
    [self.playerBullets removeChildrenInArray:bulletsToRemove];
}

@end
