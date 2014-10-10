//
//  Escena.h
//  MateRapidas
//
//  Created by Juan on 31/07/14.
//  Copyright (c) 2014 AxkanSoftware. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Escena : SKScene

@property (nonatomic, assign) CGPoint centro;
@property (nonatomic, assign) CGFloat alto;
@property (nonatomic, assign) CGFloat ancho;
@property (nonatomic, assign) CGFloat iScale;
@property (nonatomic, assign) CGFloat centralX;
@property (nonatomic, assign) CGFloat centralY;

- (id)initWithSize:(CGSize)size;

- (CGFloat)alto:(SKNode *)nodo;
- (CGFloat)ancho:(SKNode *)nodo;
- (CGPoint)centro:(SKNode *)nodo;
- (SKNode*)escala:(SKNode *)nodo;
- (CGFloat)scaleValue:(CGFloat)value;

@end
