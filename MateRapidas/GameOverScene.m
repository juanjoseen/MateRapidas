//
//  GameOverScene.m
//  MateRapidas
//
//  Created by Juan on 11/08/14.
//  Copyright (c) 2014 AxkanSoftware. All rights reserved.
//

#import "GameOverScene.h"
#import "Boton.h"
#import "LoadingScene.h"

@implementation GameOverScene{
    SKLabelNode *title;
    LoadingScene *homeScene;
}

- (id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]){
        int puntos = 0;
        title = [SKLabelNode labelNodeWithFontNamed:@"Noteworthy"];
        title.fontColor = [UIColor whiteColor];
        title.fontSize = [self scaleValue:30.0];
        title.text = [NSString stringWithFormat:@"%@ %d %@",NSLocalizedString(@"final_msg", nil),puntos,NSLocalizedString(@"puntos", nil)];
        title.position = CGPointMake(self.centralX, self.alto-[self alto:title]*1.5);
        [self addChild:title];
        
        Boton *home = [[Boton alloc] initWithText:NSLocalizedString(@"home", nil) FontSize:[self scaleValue:25] normalImage:@"boton" andselectedImage:@"boton_sel"];
        home.name = @"home";
        home.position = self.centro;
        [self addChild:home];
        
        homeScene = [[LoadingScene alloc] initWithSize:size];
        
    }
    return self;
}

- (void)didMoveToView:(SKView *)view{
    title.text = [NSString stringWithFormat:@"%@ %d %@",NSLocalizedString(@"final_msg", nil),_final_score,NSLocalizedString(@"puntos", nil)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [[touches anyObject] locationInNode:self];
    SKNode *home = [self childNodeWithName:@"home"];
    if (CGRectContainsPoint(home.frame, touchPoint)){
        SKTransition *trans = [SKTransition moveInWithDirection:SKTransitionDirectionRight duration:0.5];
        [self.view presentScene:homeScene transition:trans];
    }
}

@end
