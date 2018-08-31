//
//  GameScene.h
//  TextShooter
//
//  Created by Alex Chekodanov on 31.08.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BIDLevelScene : SKScene

@property (assign, nonatomic) NSUInteger levelNumber;
@property (assign, nonatomic) NSUInteger playerLives;
@property (assign, nonatomic) BOOL finished;

+ (instancetype)sceneWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber;
- (instancetype)initWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber;

@end
