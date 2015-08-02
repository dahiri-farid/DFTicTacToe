//
//  DFGameViewController.m
//  TicTacToe
//
//  Created by Dahiri Farid on 8/1/15.
//  Copyright (c) 2015 Dahiri Farid. All rights reserved.
//

#import "DFGameViewController.h"
#import "DFGameController.h"

@interface DFGameViewController ()

@property (nonatomic, strong)   IBOutlet    NSLayoutConstraint* ncLeadingGameSpace;
@property (nonatomic, strong)   IBOutlet    NSLayoutConstraint* ncTrailingGameSpace;
@property (nonatomic, strong)   IBOutlet    NSLayoutConstraint* ncTopGameSpace;
@property (nonatomic, strong)   IBOutlet    NSLayoutConstraint* ncBottomGameSpace;

@property (nonatomic, strong)               DFGameController*   gameController;

@end

@implementation DFGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gameController = [DFGameController controllerWithGameType:self.gameType];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = self.gameController.gameTitle;
    
    [self updateGameViewContraintsWithSize:self.view.bounds.size];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateGameViewContraintsWithSize:(CGSize)aSize
{
    [self.view removeConstraints:@[self.ncLeadingGameSpace, self.ncTrailingGameSpace, self.ncTopGameSpace, self.ncBottomGameSpace]];
    
    if (aSize.width > aSize.height)
    {
        [self.view addConstraints:@[self.ncTopGameSpace, self.ncBottomGameSpace]];
    }
    else
    {
        [self.view addConstraints:@[self.ncLeadingGameSpace, self.ncTrailingGameSpace]];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    // Code here will execute before the rotation begins.
    // Equivalent to placing it in the deprecated method -[willRotateToInterfaceOrientation:duration:]
    
    [self updateGameViewContraintsWithSize:size];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        // Place code here to perform animations during the rotation.
        // You can pass nil or leave this block empty if not necessary.
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        // Code here will execute after the rotation has finished.
        // Equivalent to placing it in the deprecated method -[didRotateFromInterfaceOrientation:]
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - User Interaction

- (IBAction)didPressOnGrid:(UIButton *)sender
{
    [sender setTitle:@"X" forState:UIControlStateNormal];
}

@end
