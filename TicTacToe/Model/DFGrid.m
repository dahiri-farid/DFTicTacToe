//
//  DFGrid.m
//  TicTacToe
//
//  Created by Dahiri Farid on 8/2/15.
//  Copyright (c) 2015 Dahiri Farid. All rights reserved.
//

#import "DFGrid.h"

@interface DFGrid ()

@property (nonatomic, strong)   NSMutableArray* gridValues;
@property (nonatomic, strong)   NSMutableArray* solutions;

@end

@implementation DFGrid

- (instancetype)init
{
    self = super.init;
    if (self)
    {
        self.gridValues = NSMutableArray.array;
        
        [self clearGridValues];
        [self generateAllSolutions];
    }
    return self;
}

- (void)clearGridValues
{
    [self.gridValues removeAllObjects];
    for (NSUInteger i = 0; i < self.gridSize; ++i)
    {
        [self.gridValues addObject:@(DFGridValueEmpty)];
    }
}

- (DFGridValueType)gridValueAtIndex:(NSUInteger)aIndex
{
    NSParameterAssert(aIndex < self.gridValues.count);
    return [self.gridValues[aIndex] integerValue];
}

- (void)putGridValue:(DFGridValueType)aValue atIndex:(NSUInteger)aIndex
{
    NSParameterAssert(aIndex < self.gridValues.count);
    self.gridValues[aIndex] = @(aValue);
}

- (void)makeBestMoveForValue:(DFGridValueType)aValue
{
    if (self.isGridEmpty == YES)
    {
        [self randomMoveForValue:aValue];
    }
    else
    {
        
    }
}

- (BOOL)isGridEmpty
{
    for (NSNumber* value in self.gridValues)
    {
        if (value.integerValue != DFGridValueEmpty)
            return NO;
    }
    return YES;
}

- (void)randomMoveForValue:(DFGridValueType)aValue
{
    NSUInteger randomMove = arc4random_uniform((u_int32_t)self.gridValues.count - 1);
    [self putGridValue:aValue atIndex:randomMove];
}

- (void)minimaxForValue:(DFGridValueType)aValue
{
//    for (NSUInteger i = 0; i < self.so)
}

- (BOOL)isWinnerX
{
    return  [self isWinner:DFGridValueX];
}

- (BOOL)isWinnerY
{
    return  [self isWinner:DFGridValueO];
}

- (BOOL)isWinner:(DFGridValueType)aValue
{
    for (NSArray* solution in self.solutions)
    {
        DFGridValueType firtValue = [solution[0] integerValue];
        DFGridValueType secondValue = [solution[1] integerValue];
        DFGridValueType thirdValue = [solution[2] integerValue];
        
        if (firtValue == secondValue == thirdValue == aValue)
            return YES;
    }
    return NO;
}

- (void)generateAllSolutions
{
    NSMutableArray* allSolutions = NSMutableArray.array;
    
    for (NSUInteger i = 0; i < self.solutionsCount; ++i)
    {
        [allSolutions addObject:NSMutableArray.array];
    }
    
    for (int iX = 0; iX < self.sideLength; ++iX)
    {
        for (int jY = 0; jY < self.sideLength; ++jY)
        {
            NSMutableArray* solution = allSolutions[iX];
            [solution addObject:@(iX * self.sideLength + jY)];
            
            solution = allSolutions[self.sideLength + jY];
            [solution addObject:@(iX * self.sideLength + jY)];
            
            if (iX == jY)
            {
                solution = allSolutions[self.sideLength * 2];
                [solution addObject: @((iX * self.sideLength) + jY)];
            }
            
            if ((iX + jY) == (self.sideLength - 1))
            {
                solution = allSolutions[self.sideLength * 2 + 1];
                [solution addObject:@(iX * self.sideLength + jY)];
            }
        }
    }
    self.solutions = allSolutions;
}

- (NSUInteger)sideLength
{
    return 3;
}

- (NSUInteger)solutionsCount
{
    return self.sideLength * 2 + 2;
}

- (NSUInteger)gridSize
{
    return self.sideLength * self.sideLength;
}


@end
