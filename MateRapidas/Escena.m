//
//  Escena.m
//  MateRapidas
//
//  Created by Juan on 31/07/14.
//  Copyright (c) 2014 AxkanSoftware. All rights reserved.
//

#import "Escena.h"

@implementation Escena

- (id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]){
        _centro = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        _centralX = _centro.x;
        _centralY = _centro.y;
        _alto = size.height;
        _ancho = size.width;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            _iScale = 1.0;
        } else {
            _iScale = 2.0;
        }
    }
    return self;
}

- (CGFloat)ancho:(SKNode *)nodo{
    return nodo.frame.size.width;
}

- (CGFloat)alto:(SKNode *)nodo{
    return nodo.frame.size.height;
}

- (CGPoint)centro:(SKNode *)nodo{
    return CGPointMake(CGRectGetMidX(nodo.frame), CGRectGetMidY(nodo.frame));
}

- (SKNode *)escala:(SKNode *)nodo{
    nodo.xScale *= _iScale;
    nodo.yScale *= _iScale;
    return nodo;
}

- (CGFloat)scaleValue:(CGFloat)value{
    return value*_iScale;
}

@end
