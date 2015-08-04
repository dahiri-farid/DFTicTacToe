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
#import "CALayer+ScalingAnimation.h"

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
        [self performDelayedComputerMove];
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

- (void)performDelayedComputerMove
{
    if (self.gameController.gameFinished == YES)
        return;
    
    self.view.userInteractionEnabled = NO;
    [self performSelector:@selector(makeComputerMove) withObject:nil afterDelay:0.3f];
}

- (void)makeComputerMove
{
    __block NSUInteger move = 0;
    if (self.gameType == DFGameAIVsHuman)
    {
        move = [self.gridModel makeBestMoveForValue:DFGridValueX];
       
        UIButton* btn = [self buttonForTag:[self buttonTagFromGridID:move]];
        [self drawMarker:DFGridValueX forButton:btn];
        [self.gridModel putGridValue:DFGridValueX atIndex:move];
    }
    else if (self.gameType == DFGameHumanVsAI)
    {
        move = [self.gridModel makeBestMoveForValue:DFGridValueO];
        
        UIButton* btn = [self buttonForTag:[self buttonTagFromGridID:move]];
        [self drawMarker:DFGridValueO forButton:btn];
        [self.gridModel putGridValue:DFGridValueO atIndex:move];
    }
    
    [self updateGameFlow];

    self.view.userInteractionEnabled = YES;
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
            [self drawMarker:DFGridValueX forButton:sender];
        }
        else
        {
            [self drawMarker:DFGridValueO forButton:sender];
        }
        [self.gameController toggleGridValue];
        sender.userInteractionEnabled = NO;
        
        [self updateGameFlow];
    }
    else if (self.gameType == DFGameHumanVsAI)
    {
        [self.gridModel putGridValue:self.gameController.currentGridValue
                             atIndex:[self gridIDFromButtonTag:sender.tag]];
        
        if (self.gameController.currentGridValue == DFGridValueX)
        {
            [self drawMarker:DFGridValueX forButton:sender];
        }
        
        [self updateGameFlow];
        
        [self performDelayedComputerMove];
    }
    else if (self.gameType == DFGameAIVsHuman)
    {
        [self.gridModel putGridValue:self.gameController.currentGridValue
                             atIndex:[self gridIDFromButtonTag:sender.tag]];
        
        if (self.gameController.currentGridValue == DFGridValueO)
        {
            [self drawMarker:DFGridValueO forButton:sender];
        }
        
        [self updateGameFlow];
        
        [self performDelayedComputerMove];
    }
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

- (void)updateGameFlow
{
    if (self.gridModel.isWinnerX)
    {
        self.gameController.gameFinished = YES;
        [self showAlertControllerWithTitle:@"Victory" message:@"X wins"];
    }
    else if (self.gridModel.isWinnerO)
    {
        self.gameController.gameFinished = YES;
        [self showAlertControllerWithTitle:@"Victory" message:@"O wins"];
    }
    else if (self.gridModel.isDraw)
    {
        self.gameController.gameFinished = YES;
        [self showAlertControllerWithTitle:@"Draw" message:@"Nobody wins"];
    }

    [self udpdateGridButtons];
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

- (void)drawMarker:(DFGridValueType)aMarker forButton:(UIButton *)aButton
{
    CGSize figureSize = CGSizeMake(aButton.bounds.size.width * 0.8f,
                                   aButton.bounds.size.height * 0.8f);
    
    CGPoint centerPosition = CGPointMake(CGRectGetMidX(aButton.frame),
                                         CGRectGetMidY(aButton.frame));
    
    if (aMarker == DFGridValueO)
    {
        CAShapeLayer *circle1 = [self createCircleWithRadius:figureSize.width / 2.0f
                                                       color:UIColor.darkGrayColor
                                                    position:centerPosition
                                                   fillColor:UIColor.clearColor
                                                   lineWidth:figureSize.width * 0.1f];
        // Add to parent layer
        [aButton.layer addSublayer:circle1];
        [circle1 animateScaleX:0.92f scaleY:0.92f numberOfBounces:6];
    }
    else
    {
        CAShapeLayer *cross = [self createCrossWithSize:figureSize.width
                                                  color:UIColor.darkGrayColor
                                               position:centerPosition
                                              fillColor:UIColor.clearColor
                                              lineWidth:figureSize.width * 0.1f];
        [aButton.layer addSublayer:cross];
        [cross animateScaleX:0.92f scaleY:0.92f numberOfBounces:6];
    }
}

- (CAShapeLayer *)createCircleWithRadius:(CGFloat)radius
                                   color:(UIColor *)color
                                position:(CGPoint)position
                               fillColor:(UIColor *)fillColor
                               lineWidth:(CGFloat)lineWidth
{
    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0 * radius, 2.0 * radius)
                                             cornerRadius:radius].CGPath;
    // Center the shape in self.view
    circle.position = position;
    
    // Configure the apperence of the circle
    circle.fillColor = fillColor.CGColor;
    circle.strokeColor = color.CGColor;
    circle.lineWidth = lineWidth;
    circle.bounds = CGRectMake(0, 0, 2.0 * radius, 2.0 * radius);
    circle.anchorPoint = CGPointMake(0.5, 0.5);
    return circle;
}

- (CAShapeLayer *)createCrossWithSize:(CGFloat)size
                                   color:(UIColor *)color
                                position:(CGPoint)position
                               fillColor:(UIColor *)fillColor
                               lineWidth:(CGFloat)lineWidth
{
    CAShapeLayer *lineFirstLayer = [CAShapeLayer layer];
    
    UIBezierPath *linePathFirst = [UIBezierPath bezierPath];
    [linePathFirst moveToPoint: CGPointZero];
    [linePathFirst addLineToPoint:CGPointMake(size, size)];
    lineFirstLayer.path = linePathFirst.CGPath;
    lineFirstLayer.fillColor = fillColor.CGColor;
    lineFirstLayer.strokeColor = color.CGColor;
    lineFirstLayer.lineWidth = lineWidth;
    lineFirstLayer.opacity = 1.0;
    
    CAShapeLayer *lineSecondLayer = [CAShapeLayer layer];
    
    UIBezierPath *linePathSecond = [UIBezierPath bezierPath];
    [linePathSecond moveToPoint: CGPointMake(size, 0)];
    [linePathSecond addLineToPoint:CGPointMake(0, size)];
    lineSecondLayer.path = linePathSecond.CGPath;
    lineSecondLayer.fillColor = fillColor.CGColor;
    lineSecondLayer.strokeColor = color.CGColor;
    lineSecondLayer.lineWidth = lineWidth;
    lineSecondLayer.opacity = 1.0;

    CAShapeLayer *cross = [CAShapeLayer layer];
    // Make a circular shape
    // Center the shape in self.view
    cross.position = position;
    
    // Configure the apperence of the circle
    cross.fillColor = fillColor.CGColor;
    cross.strokeColor = color.CGColor;
    cross.lineWidth = lineWidth;
    cross.bounds = CGRectMake(0, 0, size, size);
//    cross.anchorPoint = CGPointMake(0.5, 0.5);
    [cross addSublayer:lineFirstLayer];
    [cross addSublayer:lineSecondLayer];
    return cross;
}

@end
