//
//  LoadingScene.m
//  MateRapidas
//
//  Created by Juan on 31/07/14.
//  Copyright (c) 2014 AxkanSoftware. All rights reserved.
//

#import "LoadingScene.h"

@implementation LoadingScene{
    NSArray *cambios;
}

- (id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]){
        
        self.backgroundColor = [UIColor blackColor];
        
    }
    return self;
}

- (void)didMoveToView:(SKView *)view{
    _menu = [[Menu alloc] initWithSize:self.size];
    cambios = @[[SKTransition crossFadeWithDuration:0.5], [SKTransition doorsCloseHorizontalWithDuration:0.5], [SKTransition doorsCloseVerticalWithDuration:0.5], [SKTransition doorsOpenHorizontalWithDuration:0.5], [SKTransition doorsOpenVerticalWithDuration:0.5], [SKTransition doorwayWithDuration:0.5], [SKTransition fadeWithColor:[UIColor redColor] duration:0.5], [SKTransition fadeWithDuration:0.5], [SKTransition flipHorizontalWithDuration:0.5], [SKTransition flipVerticalWithDuration:0.5], [SKTransition pushWithDirection:SKTransitionDirectionUp duration:0.5],[SKTransition revealWithDirection:SKTransitionDirectionDown duration:0.5]];
    SKLabelNode *loading = [SKLabelNode labelNodeWithFontNamed:@"Noteworthy"];
    loading.fontSize = [_menu scaleValue:30.0];
    loading.fontColor = [UIColor whiteColor];
    loading.text = [NSString stringWithFormat:@"%@...",NSLocalizedString(@"cargando", nil)];
    loading.position = _menu.centro;
    
    [self addChild:loading];
    
    SKAction *wait = [SKAction waitForDuration:0.5];
    SKAction *change = [SKAction runBlock:^{
        [self cambia];
    }];
    SKAction *sequense = [SKAction sequence:@[wait,change]];
    [self runAction:sequense];
}

- (void)cambia{
    SKTransition *cambio = [SKTransition crossFadeWithDuration:0.5];
    [self.view presentScene:_menu transition:cambio];
}

@end
