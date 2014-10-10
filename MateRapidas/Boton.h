//
//  Boton.h
//  MateRapidas
//
//  Created by Juan on 31/07/14.
//  Copyright (c) 2014 AxkanSoftware. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Boton : SKSpriteNode

@property (nonatomic, assign) NSString *normalImage;
@property (nonatomic, assign) NSString *selectedImage;

- (void)setFontColor:(UIColor*)color;

- (id)initWithText:(NSString *)text FontSize:(CGFloat)fontSize normalImage:(NSString *)normalImage andselectedImage:(NSString*)selectedImage;

- (void)selected:(BOOL)sel;

@end
