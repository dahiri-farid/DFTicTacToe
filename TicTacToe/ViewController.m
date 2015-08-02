//
//  ViewController.m
//  TicTacToe
//
//  Created by Dahiri Farid on 8/1/15.
//  Copyright (c) 2015 Dahiri Farid. All rights reserved.
//

#import "ViewController.h"
#import "DFGameViewController.h"


static const NSUInteger kDFHumanVsHumanButtonTag   = 123;
static const NSUInteger kDFHumanVsAIButtonTag      = 124;
static const NSUInteger kDFAIVsHumanButtonTag      = 125;
static const NSUInteger kDFAboutButtonTag          = 126;

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"YOUR_SEGUE_NAME_HERE"])
    {
        // Get reference to the destination view controller
        //        YourViewController *vc = [segue destinationViewController];
        //
        //        // Pass any objects to the view controller here, like...
        //        [vc setMyObjectHere:object];
        if (sender.tag == kDFHumanVsHumanButtonTag)
        {
            DFGameViewController* gameVC = segue.destinationViewController;
            gameVC.gameType = DFGameHumavVsHuman;
        }
        else if (sender.tag == kDFHumanVsAIButtonTag)
        {
            DFGameViewController* gameVC = segue.destinationViewController;
            gameVC.gameType = DFGameHumanVsAI;
        }
        else if (sender.tag == kDFAIVsHumanButtonTag)
        {
            DFGameViewController* gameVC = segue.destinationViewController;
            gameVC.gameType = DFGameAIVsHuman;
        }
//        else if (sender.tag == kDFAboutButtonTag)
//        {
//            
//        }
    }
}

@end
