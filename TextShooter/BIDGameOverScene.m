//
//  BIDGameOverScene.m
//  TextShooter
//
//  Created by Alex Chekodanov on 04.09.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import "BIDGameOverScene.h"
#import "BIDStartScene.h"

@implementation BIDGameOverScene

-(instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor purpleColor];
        SKLabelNode *text = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        text.text = @"Game Over";
        text.fontColor = [SKColor whiteColor];
        text.fontSize = 50;
        text.position = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        [self addChild:text];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view
{
    [self performSelector:@selector(goToStart) withObject:nil afterDelay:3.0];
}

- (void)goToStart
{
    SKTransition *transition = [SKTransition flipVerticalWithDuration:1.0];
    SKScene *start = [[BIDStartScene alloc] initWithSize:self.frame.size];
    [self.view presentScene:start transition:transition];
}
@end
