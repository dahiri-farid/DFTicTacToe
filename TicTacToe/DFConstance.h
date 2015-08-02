//
//  DFConstance.h
//  TicTacToe
//
//  Created by Dahiri Farid on 8/1/15.
//  Copyright (c) 2015 Dahiri Farid. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DFGameType)
{
    DFGameHumavVsHuman,
    DFGameHumanVsAI,
    DFGameAIVsHuman,
};

typedef NS_ENUM(NSUInteger, DFGridValueType)
{
    DFGridValueEmpty,
    DFGridValueX,
    DFGridValueO,
};

@interface DFConstance : NSObject

@end
