//
//  ViewController.m
//  DDSqueezeImageView
//
//  Created by LEE CHIEN-MING on 12/23/14.
//  Copyright (c) 2014 cheesecake. All rights reserved.
//

#import "ViewController.h"
#import "DDSqueezeImageView.h"

@interface ViewController ()
@property (nonatomic, strong) DDSqueezeImageView *squeezeImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.squeezeImageView = [[DDSqueezeImageView alloc] initWithImage:[UIImage imageNamed:@"dollar9.png"] highlightedImage:[UIImage imageNamed:@"dollar9-2.png"]];
    [self.view addSubview:self.squeezeImageView];
    self.squeezeImageView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.squeezeImageView autoSwitchingWithInterval:1.5f];
}

@end
