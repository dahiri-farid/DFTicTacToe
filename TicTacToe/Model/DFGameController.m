//
//  DFGameController.m
//  TicTacToe
//
//  Created by Dahiri Farid on 8/2/15.
//  Copyright (c) 2015 Dahiri Farid. All rights reserved.
//

#import "DFGameController.h"

@interface DFGameController ()

@property (nonatomic, assign, readwrite)    DFGameType  gameType;

@end

@implementation DFGameController

+ (instancetype)controllerWithGameType:(DFGameType)aGameType
{
    return [[[self class] alloc] initWithGameType:aGameType];
}

- (instancetype)initWithGameType:(DFGameType)aGameType
{
    self = super.init;
    if (self)
    {
        self.gameType = aGameType;
    }
    return self;
}

- (NSString *)gameTitle
{
    if (self.gameType == DFGameHumavVsHuman)
    {
        return @"Human vs Human";
    }
    else if (self.gameType == DFGameHumanVsAI)
    {
        return @"Human vs AI";
    }
    else if (self.gameType == DFGameAIVsHuman)
    {
        return @"AI vs Human";
    }
    return @"Unknown game";
}

@end
