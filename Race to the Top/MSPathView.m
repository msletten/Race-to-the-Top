//
//  MSPathView.m
//  Race to the Top
//
//  Created by Mat Sletten on 5/14/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSPathView.h"
#import "MSMountainPath.h"

@implementation MSPathView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

//Below we use the method initWithCoder to make sure that the background color for this view object will always be transparent. initWithCoder instructs the objects to initialize itself from data in the coder provided. It returns an object initialized from data in a given unarchiver. This is like the viewDidLoad method in the ViewController class.
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
}

//setting method to change background color of our PathView
-(void)setup
{
    self.backgroundColor = [UIColor clearColor];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code and using the MountainPath files as the drawing data source
    for (UIBezierPath *path in [MSMountainPath mountainPathsForRect:self.bounds])
         {
             [[UIColor colorWithRed:25/255.0f green:25/255.0f blue:112/255.0f alpha:1/1.0f] setStroke];
             [path stroke];
         }
}


@end
