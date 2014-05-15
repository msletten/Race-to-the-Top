//
//  MSMountainPath.m
//  Race to the Top
//
//  Created by Mat Sletten on 5/14/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSMountainPath.h"

#define PATH_WIDTH 60

@implementation MSMountainPath

+(NSArray *)mountainPathsForRect:(CGRect)mountainRect;
{//The [@[] is literal syntax for the NSArray, and we're using a mutable array to add a number of bezier paths to the array
//    NSMutableArray *variousPaths = [@[] mutableCopy];
//    CGPoint firstPoint = CGPointMake(mountainRect.size.width * (1/6.0), CGRectGetMaxY(mountainRect));
//    CGPoint secondPoint = CGPointMake(mountainRect.size.width * (1/3.0), mountainRect.size.height * (5/6.0));
//    
//    UIBezierPath *labyrinthPath = [UIBezierPath bezierPath];
//    labyrinthPath.lineWidth = 5.0;
//    [labyrinthPath moveToPoint:firstPoint];
//    [labyrinthPath addLineToPoint:secondPoint];
//    
//    [variousPaths addObject:labyrinthPath];

    NSMutableArray *variousPaths = [@[] mutableCopy];
    
    // First Path
    
    CGPoint firstPoint = CGPointMake(mountainRect.size.width * (1/6.0), CGRectGetMaxY(mountainRect));
    CGPoint secondPoint = CGPointMake(mountainRect.size.width * (1/3.0), mountainRect.size.height * (5/6.0));
    CGPoint thirdPoint = CGPointMake(CGRectGetMaxX(mountainRect), mountainRect.size.height * (5/6.0));
    CGPoint fourthPoint = CGPointMake(CGRectGetMaxX(mountainRect), mountainRect.size.height * (2/3.0));
    CGPoint fifthPoint = CGPointMake(mountainRect.size.width * (1/6.0), mountainRect.size.height * (6/12.0));
    CGPoint sixthPoint = CGPointMake(mountainRect.size.width * (1/6.0), mountainRect.size.height * (6/12.0));
    CGPoint seventhPoint = CGPointMake(mountainRect.size.width * (1/3.0), mountainRect.size.height * (2/6.0));
    CGPoint eigthPoint = CGPointMake(mountainRect.size.width * (2/3.0), mountainRect.size.height * (6/12.0));
    CGPoint ninthPoint = CGPointMake(mountainRect.size.width * (11/20.0), mountainRect.size.height * (5/24.0));
    CGPoint controlPoint = CGPointMake(mountainRect.size.width * (6 / 8.0), mountainRect.size.height * (1/ 3.0));
    
    // Second Path
    
    CGPoint firstPointForSecondPath = CGPointMake(mountainRect.size.width * (1/6.0) - PATH_WIDTH, CGRectGetMaxY(mountainRect));
    CGPoint secondPointForSecondPath = CGPointMake(mountainRect.size.width * (1/3.0), mountainRect.size.height * (5/6.0) - PATH_WIDTH);
    CGPoint thirdPointForSecondPath = CGPointMake(CGRectGetMaxX(mountainRect) - PATH_WIDTH, mountainRect.size.height * (5/6.0) - PATH_WIDTH);
    CGPoint fourthPointForSecondPath = CGPointMake(CGRectGetMaxX(mountainRect)- PATH_WIDTH, mountainRect.size.height * (2/3.0) + PATH_WIDTH);
    CGPoint fifthPointForSecondPath = CGPointMake(mountainRect.size.width * (1/6.0) - PATH_WIDTH, mountainRect.size.height * (6/12.0) + PATH_WIDTH / 2);
    CGPoint sixthPointForSecondPath = CGPointMake(mountainRect.size.width * (1/6.0) - PATH_WIDTH, mountainRect.size.height * (6/12.0));
    CGPoint seventhPointForSecondPath = CGPointMake(mountainRect.size.width * (1/3.0) - PATH_WIDTH / 4, mountainRect.size.height * (2/6.0) - PATH_WIDTH);
    CGPoint eigthPointForSecondPath = CGPointMake(mountainRect.size.width * (2/3.0) - PATH_WIDTH, mountainRect.size.height * (6/12.0) - PATH_WIDTH);
    CGPoint ninthPointForSecondPath = CGPointMake(mountainRect.size.width * (11/20.0) - PATH_WIDTH, mountainRect.size.height * (5/24.0));
    CGPoint controlPointForSecondpath = CGPointMake(mountainRect.size.width * (6 / 8.0) - PATH_WIDTH, mountainRect.size.height * (1/ 3.0));
    
    UIBezierPath *rightMountainPath = [UIBezierPath bezierPath]; // alternative to alloc, init, nested method calls
    UIBezierPath *leftMountainPath = [UIBezierPath bezierPath];
    
    rightMountainPath.lineWidth = 6.0;
    leftMountainPath.lineWidth = 4.0;
    //using control points we can use the method addQuadCurveToPoint to draw curved lines. Control Points act as an apex toward which a line will curve between two other points. It essentially "pulls" and arc out of the the other two points in a triangle.
    [rightMountainPath moveToPoint:firstPoint];
    [rightMountainPath addLineToPoint:secondPoint];
    [rightMountainPath addLineToPoint:thirdPoint];
    [rightMountainPath addLineToPoint:fourthPoint];
    [rightMountainPath addLineToPoint:fifthPoint];
    [rightMountainPath addLineToPoint:sixthPoint];
    [rightMountainPath addLineToPoint:seventhPoint];
    [rightMountainPath addLineToPoint:eigthPoint];
    [rightMountainPath addQuadCurveToPoint:ninthPoint controlPoint:controlPoint];
    
    [leftMountainPath moveToPoint:firstPointForSecondPath];
    [leftMountainPath addLineToPoint:secondPointForSecondPath];
    [leftMountainPath addLineToPoint:thirdPointForSecondPath];
    [leftMountainPath addLineToPoint:fourthPointForSecondPath];
    [leftMountainPath addLineToPoint:fifthPointForSecondPath];
    [leftMountainPath addLineToPoint:sixthPointForSecondPath];
    [leftMountainPath addLineToPoint:seventhPointForSecondPath];
    [leftMountainPath addLineToPoint:eigthPointForSecondPath];
    [leftMountainPath addQuadCurveToPoint:ninthPointForSecondPath controlPoint:controlPointForSecondpath];
    
    [variousPaths addObject:rightMountainPath];
    [variousPaths addObject:leftMountainPath];
    return [variousPaths copy];
}
@end