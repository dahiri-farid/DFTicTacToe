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

- (NSUInteger)putGridValue:(DFGridValueType)aValue atIndex:(NSUInteger)aIndex
{
    NSParameterAssert(aIndex < self.gridValues.count);
    self.gridValues[aIndex] = @(aValue);
    
    return aValue;
}

- (NSUInteger)makeBestMoveForValue:(DFGridValueType)aValue
{
    if (self.isGridEmpty)
    {
        return [self randomMoveForValue:aValue];
    }
    else
    {
        return  [self negamaxForMarker:aValue withBoard:self.gridValues.mutableCopy depth:1 alpha:-10000 beta:10000];
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

- (NSUInteger)randomMoveForValue:(DFGridValueType)aValue
{
    NSUInteger randomMove = arc4random_uniform((u_int32_t)self.gridValues.count - 1);
    
    while ([self.gridValues[randomMove]  integerValue] != DFGridValueEmpty)
    {
        randomMove = arc4random_uniform((u_int32_t)self.gridValues.count - 1);
    }
    
    [self putGridValue:aValue atIndex:randomMove];
    
    return randomMove;
}

- (BOOL)isWinnerX
{
    return  [self isWinner:DFGridValueX];
}

- (BOOL)isWinnerO
{
    return  [self isWinner:DFGridValueO];
}

- (BOOL)isDraw
{
    return [self isDrawForValues:self.gridValues];
}

- (BOOL)isDrawForValues:(NSArray *)aGrid
{
    for (NSNumber* value in aGrid)
    {
        if (value.integerValue == DFGridValueEmpty)
            return NO;
    }
    return YES;
}

- (BOOL)isWinner:(DFGridValueType)aValue
{
    return [self isWinner:aValue forGridValues:self.gridValues];
}
               
- (BOOL)isWinner:(DFGridValueType)aValue forGridValues:(NSArray *)aGrid
{

    for (NSArray* solution in self.solutions)
    {
        NSUInteger matchesCount = 0;
        for (NSNumber* index in solution)
        {
            DFGridValueType valueType = [aGrid[index.integerValue] integerValue];
            
            if (valueType == aValue)
                ++matchesCount;
        }
        if (matchesCount == self.sideLength)
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

- (NSInteger) negamaxForMarker:(DFGridValueType)marker
                     withBoard:(NSMutableArray*)board
                         depth:(NSInteger)depth
                         alpha:(NSInteger)alpha
                          beta:(NSInteger)beta
{
    NSInteger bestMove = 0;
    NSInteger bestAlpha = -10000;
    DFGridValueType opponent = [self oppositeValue:marker];
    
    NSArray *legalMoves = [self availableMovesForGrid:board];
    
    if ([self isWinner:DFGridValueO forGridValues:board] ||
        [self isWinner:DFGridValueX forGridValues:board] ||
        [self isDrawForValues:board])
    {
        DFGridValueType winner = DFGridValueEmpty;
        if ([self isWinner:DFGridValueX forGridValues:board])
            winner = DFGridValueX;
        else if ([self isWinner:DFGridValueO forGridValues:board])
            winner = DFGridValueO;
        
        if (winner == marker)
            return 1;
        else if (winner == opponent)
            return -1;
        
        return 0;
    }
    
    for (NSUInteger i = 0; i < [legalMoves count]; i++)
    {
        NSInteger move = [legalMoves[i] integerValue];
        
        board[move] = @(marker);
        
        NSInteger score = -[self negamaxForMarker:opponent withBoard:board depth:depth + 1 alpha:-beta beta:-alpha];
        
        board[move] = @(DFGridValueEmpty);
        
        if (score > alpha)
        {
            alpha = score;
        }
        
        if (alpha >= beta)
        {
            break;
        }
        
        if (depth == 1 && alpha > bestAlpha)
        {
            bestAlpha = alpha;
            bestMove = move;
        }
    }
    
    if (depth == 1)
    {
        return bestMove;
    }
    else
    {
        return alpha;
    }
}

- (DFGridValueType)oppositeValue:(DFGridValueType)aValue
{
    return aValue == DFGridValueO ? DFGridValueX : DFGridValueO;
}

- (NSArray *)availableMovesForGrid:(NSArray *)aGrid
{
    NSMutableArray* freeMoves = NSMutableArray.array;
    
    for (NSUInteger i = 0; i < aGrid.count; ++i)
    {
        NSNumber* value = aGrid[i];
        if (value.integerValue == DFGridValueEmpty)
        {
            [freeMoves addObject:@(i)];
        }
    }
    
    return freeMoves;
}

@end
