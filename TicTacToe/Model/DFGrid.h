//
//  DFGrid.h
//  TicTacToe
//
//  Created by Dahiri Farid on 8/2/15.
//  Copyright (c) 2015 Dahiri Farid. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DFGridValueType)
{
    DFGridValueEmpty,
    DFGridValueX,
    DFGridValueO,
};

@interface DFGrid : NSObject

- (DFGridValueType)gridValueAtIndex:(NSUInteger)aIndex;
- (void)putGridValue:(DFGridValueType)aValue atIndex:(NSUInteger)aIndex;
- (void)makeBestMoveForValue:(DFGridValueType)aValue;
- (BOOL)isGridEmpty;

@end