//
//  ViewController.m
//  MateRapidas
//
//  Created by Juan on 31/07/14.
//  Copyright (c) 2014 AxkanSoftware. All rights reserved.
//

#import "ViewController.h"
#import "LoadingScene.h"

@implementation ViewController{
    LoadingScene *loading;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    if (!loading){
        SKView * skView = (SKView *)self.view;
        skView.showsFPS = NO;
        skView.showsNodeCount = NO;
        loading = [[LoadingScene alloc] initWithSize:skView.bounds.size];
        
        // Present the scene.
        [skView presentScene:loading];
    }
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
