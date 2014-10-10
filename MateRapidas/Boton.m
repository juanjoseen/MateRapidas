//
//  Boton.m
//  MateRapidas
//
//  Created by Juan on 31/07/14.
//  Copyright (c) 2014 AxkanSoftware. All rights reserved.
//

#import "Boton.h"

@implementation Boton{
    SKLabelNode *texto;
    SKSpriteNode *background;
}

- (id)initWithText:(NSString *)text FontSize:(CGFloat)fontSize normalImage:(NSString *)normalImage andselectedImage:(NSString*)selectedImage{
    if (self = [super init]){
        //self.size = CGSizeMake(100.0, 100.0);
        texto = [SKLabelNode labelNodeWithFontNamed:@"Noteworthy"];
        
        _normalImage = normalImage;
        _selectedImage = selectedImage;
        texto.text = text;
        texto.fontSize = fontSize;
        //texto.fontColor = [UIColor blackColor];
        background = [SKSpriteNode spriteNodeWithImageNamed:normalImage];
        background.centerRect = CGRectMake(21.0/100.0, 21.0/100.0, 58.0/100.0, 58.0/100.0);
        background.xScale = (texto.frame.size.width+20)/background.size.width;
        background.yScale = (texto.frame.size.height+20)/background.size.height;
        background.position = self.position;
        texto.position = CGPointMake(self.position.x, self.position.y-texto.frame.size.height*0.35);
        
        self.size = background.size;
        [self addChild:background];
        [self addChild:texto];
        
        
    }
    
    return self;
}

- (void)setFontColor:(UIColor *)color{
    texto.fontColor = color;
}

- (void)selected:(BOOL)sel{
    [background removeFromParent];
    if (!sel){
        background = [SKSpriteNode spriteNodeWithImageNamed:_normalImage];
    } else {
        background = [SKSpriteNode spriteNodeWithImageNamed:_selectedImage];
    }
    background.centerRect = CGRectMake(21.0/100.0, 21.0/100.0, 58.0/100.0, 58.0/100.0);
    background.xScale = (texto.frame.size.width/background.size.width)*1.3;
    background.yScale = (texto.frame.size.height/background.size.height)*1.3;
    [self addChild:background];
}
@end
