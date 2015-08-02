//
//  DFGameController.h
//  TicTacToe
//
//  Created by Dahiri Farid on 8/2/15.
//  Copyright (c) 2015 Dahiri Farid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFGameController : NSObject

@property (nonatomic, assign, readonly)    DFGameType  gameType;
@property (nonatomic, assign, readonly)    DFGridValueType currentGridValue;

+ (instancetype)controllerWithGameType:(DFGameType)aGameType;

- (void)toggleGridValue;

- (NSString *)gameTitle;

@end
