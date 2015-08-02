//
//  DFGameViewController.m
//  TicTacToe
//
//  Created by Dahiri Farid on 8/1/15.
//  Copyright (c) 2015 Dahiri Farid. All rights reserved.
//

#import "DFGameViewController.h"
#import "DFGameController.h"
#import "DFGrid.h"

@interface DFGameViewController ()

@property (nonatomic, strong)   IBOutlet    NSLayoutConstraint* ncLeadingGameSpace;
@property (nonatomic, strong)   IBOutlet    NSLayoutConstraint* ncTrailingGameSpace;
@property (nonatomic, strong)   IBOutlet    NSLayoutConstraint* ncTopGameSpace;
@property (nonatomic, strong)   IBOutlet    NSLayoutConstraint* ncBottomGameSpace;

@property (nonatomic, strong)               NSLayoutConstraint* ncCenterXGame;
@property (nonatomic, strong)               NSLayoutConstraint* ncCenterYGame;

@property (nonatomic, strong)   IBOutlet    UIView*             gridView;

@property (nonatomic, strong)               DFGameController*   gameController;
@property (nonatomic, strong)               DFGrid*             gridModel;

@end

@implementation DFGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gameController = [DFGameController controllerWithGameType:self.gameType];
    self.gridModel      = DFGrid.new;
    
    self.ncCenterYGame =
    [NSLayoutConstraint constraintWithItem:self.gridView
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0f
                                  constant:0.0f];
    
    
    self.ncCenterXGame =
    [NSLayoutConstraint constraintWithItem:self.gridView
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0f
                                  constant:0.0f];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateGameViewContraintsWithSize:(CGSize)aSize
{
    [self.view removeConstraints:@[self.ncLeadingGameSpace,
                                   self.ncTrailingGameSpace,
                                   self.ncTopGameSpace,
                                   self.ncBottomGameSpace,
                                   self.ncCenterXGame,
                                   self.ncCenterYGame]];
    
    if (aSize.width > aSize.height)
    {
        [self.view addConstraints:@[self.ncTopGameSpace, self.ncBottomGameSpace]];
        
        [self.view addConstraint:self.ncCenterXGame];
    }
    else
    {
        self.ncLeadingGameSpace.constant = -16.0f;
        self.ncTrailingGameSpace.constant = -16.0f;
        [self.view addConstraints:@[self.ncLeadingGameSpace, self.ncTrailingGameSpace]];
        
        [self.view addConstraint:self.ncCenterYGame];
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
    [self.gridModel putGridValue:self.gameController.currentGridValue
                         atIndex:[self gridIDFromButtonTag:sender.tag]];
    
    if (self.gameController.currentGridValue == DFGridValueX)
    {
        [sender setTitle:@"X" forState:UIControlStateNormal];
    }
    else
    {
        [sender setTitle:@"O" forState:UIControlStateNormal];
    }
    [self.gameController toggleGridValue];
    sender.userInteractionEnabled = NO;
    
    if (self.gridModel.isWinnerX)
    {
        [self showAlertControllerWithTitle:@"Victory" message:@"X wins"];
    }
    else if (self.gridModel.isWinnerY)
    {
        [self showAlertControllerWithTitle:@"Victory" message:@"O wins"];
    }
}

- (NSUInteger)gridIDFromButtonTag:(NSUInteger)aButtonTag
{
    return aButtonTag - 100;
}

- (void)showAlertControllerWithTitle:(NSString *)aTitle message:(NSString *)aMessage
{
    __weak typeof (self)weakSelf = self;
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:aTitle
                                                                   message:aMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* action =
    [UIAlertAction actionWithTitle:@"Ok"
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction *action)
     {
         [weakSelf dismissViewControllerAnimated:alert completion:nil];
     }];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
