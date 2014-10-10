//
//  GameScene.m
//  MateRapidas
//
//  Created by Juan on 31/07/14.
//  Copyright (c) 2014 AxkanSoftware. All rights reserved.
//

#import "GameScene.h"
#import "Boton.h"
#import "GameOverScene.h"

static const int MAX_SECS = 6;

@implementation GameScene{
    NSArray *signos;
    CGPoint posiciones[4];
    int tope;
    int nivel;
    int aciertos;
    int totalAciertos;
    UIColor *blueSky;
    NSTimeInterval lastUpdate;
    int segundos;
    BOOL conteo;
    int puntos;
    SKAction *dingSound;
    
    GameOverScene *gameOver;
}

- (id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]){
        
        blueSky = [UIColor colorWithRed:102.0/255.0 green:204.0/255.0 blue:1.0 alpha:1.0];
        
        self.backgroundColor = blueSky;
        
        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Noteworthy"];
        title.fontColor = [UIColor whiteColor];
        title.text = NSLocalizedString(@"cuanto es", nil);
        title.fontSize = [self scaleValue:30.0];
        title.position = CGPointMake(self.centralX, self.alto-([self alto:title]*2));
        title.name = @"titulo";
        [self addChild:title];
        
        signos = @[@"+",@"_",@"x",@"÷"];
        nivel = 0;
        tope = 10;
        
        posiciones[0] = CGPointMake(self.ancho/4.0, self.centralY+[self scaleValue:20.0]);
        posiciones[1] = CGPointMake(self.ancho*3.0/4.0, self.centralY+[self scaleValue:20.0]);
        posiciones[2] = CGPointMake(self.ancho/4.0, self.centralY-[self scaleValue:50.0]);
        posiciones[3] = CGPointMake(self.ancho*3.0/4.0, self.centralY-[self scaleValue:50.0]);
        
        aciertos = 0;
        totalAciertos = 0;
        
        lastUpdate = 0.0;
        conteo = NO;
        
        segundos = MAX_SECS;
        
        SKLabelNode *segsLbl = [SKLabelNode labelNodeWithFontNamed:@"Noteworthy"];
        segsLbl.name = @"segundero";
        segsLbl.fontColor = [UIColor whiteColor];
        segsLbl.fontSize = [self scaleValue:20.0];
        segsLbl.text = [NSString stringWithFormat:@"%@: %d",NSLocalizedString(@"segundos", nil),segundos];
        segsLbl.position = CGPointMake([self ancho:segsLbl]*0.6, [self scaleValue:30.0]);
        [self addChild:segsLbl];
        
        puntos = 0;
        SKLabelNode *pnts = [SKLabelNode labelNodeWithFontNamed:@"Noteworthy"];
        pnts.name = @"puntos";
        pnts.fontColor = [UIColor whiteColor];
        pnts.fontSize = [self scaleValue:20.0];
        pnts.text = [NSString stringWithFormat:@"%@: %d",NSLocalizedString(@"puntos", nil),puntos];
        pnts.position = CGPointMake(self.ancho-[self ancho:pnts]*0.6, [self scaleValue:30.0]);
        
        [self addChild:pnts];
        
        dingSound = [SKAction playSoundFileNamed:@"ding.mp3" waitForCompletion:NO];
        
        gameOver = [[GameOverScene alloc] initWithSize:size];
        
    }
    return self;
}

- (void)didMoveToView:(SKView *)view{
    [self nuevoReto];
}

- (BOOL)esDivisible:(int)n1 con:(int)n2{
    return (n1%n2 == 0);
}

- (NSMutableArray *)divisoresDe:(int)n{
    NSMutableArray *div = nil;
    for (int i=2;i<n;i++){
        if (n%i==0){
            if (div == nil)
                div = [NSMutableArray  array];
            [div addObject:[NSNumber numberWithInt:i]];
        }
    }
    return div;
}

- (void)nuevoReto{
    conteo = NO;
    int n1 = (arc4random()%tope)+1;
    int n2 = (arc4random()%tope)+1;
    int iSign = arc4random()%MIN(MAX(1, nivel), signos.count);
    int res = 0;
    switch (iSign) {
        case 0:
            res = n1+n2;
            break;
        case 1:
            if (nivel < 6){
                if (n2 > n1){
                    int aux = n1;
                    n1 = n2;
                    n2 = aux;
                }
            }
            res = n1-n2;
            break;
        case 2:
            n1 = (n1%(7+nivel));
            n2 = (n2%(7+nivel));
            res = n1*n2;
            break;
        case 3:
            if (![self esDivisible:n1 con:n2]){
                NSMutableArray *div = [self divisoresDe:n1];
                if (div && div.count > 1){
                    NSNumber *number = div[arc4random()%div.count];
                    n2 = [number intValue];
                } else {
                    div = [self divisoresDe:n2];
                    if (div && div.count > 1){
                        NSNumber *number = div[arc4random()%div.count];
                        n1 = n2;
                        n2 = [number intValue];
                    } else {
                        int mul = n1*n2;
                        n2 = MIN(n1, n2);
                        n1 = mul;
                    }
                }
            }
            res = n1/n2;
            break;
        default:
            break;
    }
    
    NSString *s1 = [NSString stringWithFormat:@"%d",n1];
    Boton *b1 = [[Boton alloc] initWithText:s1 FontSize:[self scaleValue:50.0] normalImage:@"boton_lleno" andselectedImage:@"boton_lleno"];
    [b1 setFontColor:blueSky];
    b1.position = CGPointMake(self.ancho/4.0, self.alto-[self alto:b1]*2);
    
    [self runAction:[SKAction runBlock:^{
        [self aparece:b1];
    }]];
    
    Boton *b2 = [[Boton alloc] initWithText:signos[iSign] FontSize:[self scaleValue:50.0] normalImage:@"boton_lleno" andselectedImage:@"boton_lleno"];
    b2.position = CGPointMake(self.ancho/2.0, self.alto-[self alto:b1]*2.0);
    [b2 setFontColor:[UIColor redColor]];
    [self runAction:[SKAction sequence:@[[SKAction waitForDuration:MAX(0.5-nivel*0.05,0.35)],[SKAction runBlock:^{
        [self aparece:b2];
    }]]]];
    
    NSString *s2 = [NSString stringWithFormat:@"%d",n2];
    Boton *b3 = [[Boton alloc] initWithText:s2 FontSize:[self scaleValue:50.0] normalImage:@"boton_lleno" andselectedImage:@"boton_lleno"];
    b3.position = CGPointMake(self.ancho*3.0/4.0, self.alto-[self alto:b1]*2.0);
    [b3 setFontColor:blueSky];
    [self runAction:[SKAction sequence:@[[SKAction waitForDuration:MAX(1.0-nivel*0.05,0.7)],[SKAction runBlock:^{
        [self aparece:b3];
    }]]]];
    
    [self generaOpciones:res];
}

- (void)generaOpciones:(int)res{
    int v1=0,v2=0,v3=0;
    int ran = (arc4random()%10)-5;
    while (ran==0) {
        ran = arc4random()%10-5;
    }
    v1 = res+ran;
    ran = (arc4random()%10)-5;
    while (ran==0 || v1==res+ran) {
        ran = arc4random()%10-5;
    }
    v2 = res+ran;
    ran = (arc4random()%10)-5;
    while (ran==0 || v1==res+ran || v2==res+ran ) {
        ran = arc4random()%10-5;
    }
    v3 = res+ran;
    
    NSString *s1 = [NSString stringWithFormat:@"%d",res];
    NSString *s2 = [NSString stringWithFormat:@"%d",v1];
    NSString *s3 = [NSString stringWithFormat:@"%d",v2];
    NSString *s4 = [NSString stringWithFormat:@"%d",v3];
    
    int cambios = 0;
    while (cambios<13) {
        int r1 = arc4random()%4;
        int r2 = arc4random()%4;
        if (r1!=r2){
            CGPoint aux = posiciones[r1];
            posiciones[r1] = posiciones[r2];
            posiciones[r2] = aux;
            cambios++;
        }
    }
    
    Boton *opc1 = [[Boton alloc] initWithText:s1 FontSize:[self scaleValue:50] normalImage:@"boton_lleno" andselectedImage:@"boton_lleno"];
    [opc1 setFontColor:blueSky];
    opc1.position = posiciones[0];
    opc1.name = @"respuesta";
    Boton *opc2 = [[Boton alloc] initWithText:s2 FontSize:[self scaleValue:50] normalImage:@"boton_lleno" andselectedImage:@"boton_lleno"];
    [opc2 setFontColor:blueSky];
    opc2.position = posiciones[1];
    opc2.name = @"opcion1";
    Boton *opc3 = [[Boton alloc] initWithText:s3 FontSize:[self scaleValue:50] normalImage:@"boton_lleno" andselectedImage:@"boton_lleno"];
    [opc3 setFontColor:blueSky];
    opc3.position = posiciones[2];
    opc3.name = @"opcion2";
    Boton *opc4 = [[Boton alloc] initWithText:s4 FontSize:[self scaleValue:50] normalImage:@"boton_lleno" andselectedImage:@"boton_lleno"];
    [opc4 setFontColor:blueSky];
    opc4.position = posiciones[3];
    opc4.name = @"opcion3";
    
    
    SKAction *wait = [SKAction waitForDuration:MAX(1.5-nivel*0.5,1.05)];
    SKAction *aparecen = [SKAction runBlock:^{
        [self aparece:opc1];
        [self aparece:opc2];
        [self aparece:opc3];
        [self aparece:opc4];
        conteo = YES;
    }];
    SKAction *sequense = [SKAction sequence:@[wait,aparecen]];
    
    [self runAction:sequense];
    
    segundos = MAX_SECS;
    
}

- (void)aparece:(SKNode *)node{
    node.xScale = 0.01;
    node.yScale = 0.01;
    [self addChild:node];
    float unidad = MAX(1.0-nivel*0.05,0.7);
    SKAction *crece = [SKAction scaleTo:[self scaleValue:1.1] duration:0.3*unidad];
    SKAction *baja = [SKAction scaleTo:[self scaleValue:0.8] duration:0.13*unidad];
    SKAction *cien = [SKAction scaleTo:[self scaleValue:1.0] duration:0.07*unidad];
    SKAction *sequense = [SKAction sequence:@[crece,baja,cien]];
    [node runAction:sequense];
}

- (void)desaparece: (SKNode*)node{
    float unidad = MAX(1.0-nivel*0.05,0.7);
    SKAction *reduce = [SKAction scaleTo:0.01 duration:0.3*unidad];
    SKAction *quita = [SKAction removeFromParent];
    SKAction *sequence = [SKAction sequence:@[reduce,quita]];
    [node runAction:sequence];
}

- (void)desapareceTodoMenosTitulo{
    for (SKNode *node in self.children){
        if (![node.name isEqualToString:@"titulo"] && ![node.name isEqualToString:@"segundero"] && ![node.name isEqualToString:@"puntos"]){
            [self desaparece:node];
        }
    }
}

- (void)pierde{
    conteo = NO;
    segundos = 0;
    gameOver.final_score = puntos;
    [self desapareceTodoMenosTitulo];
    SKAction *wait = [SKAction waitForDuration:0.5];
    SKAction *cambia = [SKAction runBlock:^{
        SKTransition *trans = [SKTransition fadeWithDuration:0.5];
        [self.view presentScene:gameOver transition:trans];
    }];
    SKAction *sequense = [SKAction sequence:@[wait,cambia]];
    [self runAction:sequense];
}

- (void)update:(NSTimeInterval)currentTime{
    if (conteo){
        NSTimeInterval dif = currentTime - lastUpdate;
        if (dif >= 1.0){
            lastUpdate = currentTime;
            SKLabelNode *timer = (SKLabelNode *)[self childNodeWithName:@"segundero"];
            timer.text = [NSString stringWithFormat:@"%@: %d",NSLocalizedString(@"segundos", nil),segundos];
            if (segundos < MAX_SECS)
                [self runAction:dingSound];
            segundos--;
        }
    } else {
        segundos = MAX_SECS;
        lastUpdate = currentTime;
    }
    
    if (segundos < 0){
        [self pierde];
    }
    if (aciertos >= 5){
        nivel++;
        aciertos = 0;
    }
    tope = 10 + nivel*5;
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [[touches anyObject] locationInNode:self];
    
    Boton *res = (Boton*)[self childNodeWithName:@"respuesta"];
    if (CGRectContainsPoint(res.frame, touchPoint)){
        segundos = MAX_SECS;
        aciertos++;
        totalAciertos++;
        SKAction *limpia = [SKAction runBlock:^{
            [self desapareceTodoMenosTitulo];
        }];
        SKAction *wait = [SKAction waitForDuration:1.0];
        SKAction *empieza = [SKAction runBlock:^{
            [self nuevoReto];
        }];
        puntos++;
        [self runAction:[SKAction sequence:@[limpia,wait,empieza]]];
        SKLabelNode *pnts = (SKLabelNode *)[self childNodeWithName:@"puntos"];
        pnts.text = [NSString stringWithFormat:@"%@: %d",NSLocalizedString(@"puntos", nil),puntos];
        pnts.position = CGPointMake(self.ancho-[self ancho:pnts]*0.5, [self scaleValue:30.0]);
        
    } else{
        
        Boton *o1 = (Boton *)[self childNodeWithName:@"opcion1"];
        Boton *o2 = (Boton *)[self childNodeWithName:@"opcion2"];
        Boton *o3 = (Boton *)[self childNodeWithName:@"opcion3"];
        
        if (CGRectContainsPoint(o1.frame, touchPoint) || CGRectContainsPoint(o2.frame, touchPoint) || CGRectContainsPoint(o3.frame, touchPoint)){
            [self pierde];
        }
    }
}

@end
