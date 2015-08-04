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
    
    
    if (self.gameType == DFGameAIVsHuman)
    {
        self.view.userInteractionEnabled = NO;
        [self performSelector:@selector(performFirstComputerMove) withObject:nil afterDelay:0.3f];
    }
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

- (void)performFirstComputerMove
{
    self.view.userInteractionEnabled = YES;
    [self performComputerMove];
}

- (void)performComputerMove
{
    __block NSUInteger move = 0;
    if (self.gameType == DFGameAIVsHuman)
    {
        move = [self.gridModel makeBestMoveForValue:DFGridValueX];
       
        UIButton* btn = [self buttonForTag:[self buttonTagFromGridID:move]];
        [btn setTitle:@"X" forState:UIControlStateNormal];
        [self.gridModel putGridValue:DFGridValueX atIndex:move];
    }
    else if (self.gameType == DFGameHumanVsAI)
    {
        move = [self.gridModel makeBestMoveForValue:DFGridValueO];
        
        UIButton* btn = [self buttonForTag:[self buttonTagFromGridID:move]];
        [btn setTitle:@"O" forState:UIControlStateNormal];
        [self.gridModel putGridValue:DFGridValueO atIndex:move];
    }
    
    [self udpdateGridButtons];
}

- (UIButton *)buttonForTag:(NSUInteger)aTag
{
    return (UIButton *)[[self.gridView viewWithTag:aTag + 100] viewWithTag:aTag];
}

#pragma mark - User Interaction

- (IBAction)didPressOnGrid:(UIButton *)sender
{
    if (self.gameType == DFGameHumavVsHuman)
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
    }
    else if (self.gameType == DFGameHumanVsAI)
    {
        [self.gridModel putGridValue:self.gameController.currentGridValue
                             atIndex:[self gridIDFromButtonTag:sender.tag]];
        
        if (self.gameController.currentGridValue == DFGridValueX)
        {
            [sender setTitle:@"X" forState:UIControlStateNormal];
        }
        
        [self performComputerMove];
    }
    else if (self.gameType == DFGameAIVsHuman)
    {
        [self.gridModel putGridValue:self.gameController.currentGridValue
                             atIndex:[self gridIDFromButtonTag:sender.tag]];
        
        if (self.gameController.currentGridValue == DFGridValueO)
        {
            [sender setTitle:@"O" forState:UIControlStateNormal];
        }
        
        [self performComputerMove];
    }
    
    if (self.gridModel.isWinnerX)
    {
        [self showAlertControllerWithTitle:@"Victory" message:@"X wins"];
    }
    else if (self.gridModel.isWinnerO)
    {
        [self showAlertControllerWithTitle:@"Victory" message:@"O wins"];
    }
    else if (self.gridModel.isDraw)
    {
        [self showAlertControllerWithTitle:@"Draw" message:@"Nobody wins"];
    }
    
    [self udpdateGridButtons];
}

- (NSUInteger)gridIDFromButtonTag:(NSUInteger)aButtonTag
{
    return aButtonTag - 100;
}

- (NSUInteger)buttonTagFromGridID:(NSUInteger)aGridID
{
    return aGridID + 100;
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
         [weakSelf dismissViewControllerAnimated:YES completion:nil];
     }];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)udpdateGridButtons
{
    for (NSUInteger i = 0; i < self.gridModel.gridSize; ++i)
    {
        DFGridValueType gridValue = [self.gridModel gridValueAtIndex:i];
        UIButton* btn = [self buttonForTag:[self buttonTagFromGridID:i]];
        if (gridValue != DFGridValueEmpty)
        {
            
            btn.userInteractionEnabled = NO;
        }
        else
            btn.userInteractionEnabled = YES;
    }
}

@end
