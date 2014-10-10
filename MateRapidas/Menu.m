//
//  Menu.m
//  MateRapidas
//
//  Created by Juan on 31/07/14.
//  Copyright (c) 2014 AxkanSoftware. All rights reserved.
//

#import "Menu.h"
#import "Boton.h"
#import "GameScene.h"

@implementation Menu{
    BOOL insideButton;
    GameScene *game;
}

- (id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]){
        
        self.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:204.0/255.0 blue:1.0 alpha:1.0];
        Boton *inicio = [[Boton alloc] initWithText:NSLocalizedString(@"comienza", nil) FontSize:[self scaleValue:25.0] normalImage:@"boton" andselectedImage:@"boton_sel"];
        inicio.name = @"boton_ini";
        inicio.position = self.centro;
        inicio.xScale = 0.01;
        inicio.yScale = 0.01;
        [self addChild:inicio];
        
        game = [[GameScene alloc] initWithSize:size];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view{
    Boton *b = (Boton*)[self childNodeWithName:@"boton_ini"];
    SKAction *crece = [SKAction scaleTo:[self scaleValue:1.1] duration:0.3];
    SKAction *baja = [SKAction scaleTo:[self scaleValue:0.8] duration:0.13];
    SKAction *cien = [SKAction scaleTo:[self scaleValue:1.0] duration:0.07];
    SKAction *sequense = [SKAction sequence:@[crece,baja,cien]];
    
    [b runAction:sequense];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [[touches anyObject] locationInNode:self];
    Boton *b = (Boton*)[self childNodeWithName:@"boton_ini"];
    if (CGRectContainsPoint(b.frame, touchPoint)){
        insideButton = YES;
        [b selected:YES];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    Boton *b = (Boton*)[self childNodeWithName:@"boton_ini"];
    if (insideButton){
        SKAction *encoje = [SKAction scaleTo:0.01 duration:0.20];
        [b runAction:encoje];
        SKAction *wait = [SKAction waitForDuration:0.5];
        SKAction *cambia = [SKAction runBlock:^{
            [self.view presentScene:game transition:[SKTransition pushWithDirection:SKTransitionDirectionRight duration:0.5]];
        }];
        [self runAction:[SKAction sequence:@[wait,cambia]]];
    }
    [b selected:NO];
    insideButton = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [[touches anyObject] locationInNode:self];
    Boton *b = (Boton*)[self childNodeWithName:@"boton_ini"];
    if (!insideButton){
        if (CGRectContainsPoint(b.frame, touchPoint)){
            [b selected:YES];
            insideButton = YES;
        }
    } else {
        if (!CGRectContainsPoint(b.frame, touchPoint)){
            [b selected:NO];
            insideButton = NO;
        }
    }
}
@end
