//
//  GameScene.m
//  TextShooter
//
//  Created by Alex Chekodanov on 31.08.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import "BIDLevelScene.h"
#import "BidPlayerNode.h"

@interface BIDLevelScene ()

@property (strong, nonatomic) BidPlayerNode *playerNode;

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
    }
}



@end
