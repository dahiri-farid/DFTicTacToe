//
//  DFAboutViewController.m
//  TicTacToe
//
//  Created by Dahiri Farid on 8/4/15.
//  Copyright (c) 2015 Dahiri Farid. All rights reserved.
//

#import "DFAboutViewController.h"

@interface DFAboutViewController ()

@property (nonatomic, strong)   IBOutlet    UITextView* tvContent;

@end

@implementation DFAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"About";
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                target:self
                                                action:@selector(onExit)];
    self.navigationItem.leftBarButtonItem.tintColor = UIColor.darkGrayColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)onExit
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
