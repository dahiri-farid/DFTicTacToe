//
//  DFGrid.h
//  TicTacToe
//
//  Created by Dahiri Farid on 8/2/15.
//  Copyright (c) 2015 Dahiri Farid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFGrid : NSObject

- (DFGridValueType)gridValueAtIndex:(NSUInteger)aIndex;
- (NSUInteger)putGridValue:(DFGridValueType)aValue atIndex:(NSUInteger)aIndex;
- (NSUInteger)makeBestMoveForValue:(DFGridValueType)aValue;
- (BOOL)isGridEmpty;
- (BOOL)isWinnerX;
- (BOOL)isWinnerO;
- (BOOL)isDraw;
- (NSUInteger)gridSize;

@end
