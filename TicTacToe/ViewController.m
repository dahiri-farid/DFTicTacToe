//
//  ViewController.m
//  TicTacToe
//
//  Created by Dahiri Farid on 8/1/15.
//  Copyright (c) 2015 Dahiri Farid. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet  UIButton* bHumanVsHuman;
@property (nonatomic, strong) IBOutlet  UIButton* bHumanVsAI;
@property (nonatomic, strong) IBOutlet  UIButton* bAIVsHuman;
@property (nonatomic, strong) IBOutlet  UIButton* bAbout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
}

- (void)setupUI
{
    self.bHumanVsHuman.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.bHumanVsHuman.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.bHumanVsHuman setTitle: @"Human\nvs\nHuman" forState: UIControlStateNormal];

    self.bHumanVsAI.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.bHumanVsAI.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.bHumanVsAI setTitle: @"Human\nvs\nAI" forState: UIControlStateNormal];
    
    self.bAIVsHuman.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.bAIVsHuman.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.bAIVsHuman setTitle: @"AI\nvs\nHuman" forState: UIControlStateNormal];

    [self.bAbout setTitle: @"About" forState: UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
