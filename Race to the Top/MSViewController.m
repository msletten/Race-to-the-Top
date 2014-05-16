//
//  MSViewController.m
//  Race to the Top
//
//  Created by Mat Sletten on 5/13/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSViewController.h"
#import "MSPathView.h"
#import "MSMountainPath.h"

#define MSMAP_STARTING_SCORE 15000
#define MSMAP_SCORE_DECREMENT_AMOUNT 100
#define MSTIMER_INTERVAL 0.1
#define MSWALL_PENALTY 500

@interface MSViewController ()
//made this property private because no other classes will need to know about this IBOutlet
@property (strong, nonatomic) IBOutlet MSPathView *pathView;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation MSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Set a gesture recognizer below to pass it a selector method
    UITapGestureRecognizer *tapRecognizer =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    //instances of TapGestureRecognizers have properties that can be accessed to customize that instance using dot notation.
    tapRecognizer.numberOfTapsRequired = 2;
    [self.pathView addGestureRecognizer:tapRecognizer];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [self.pathView addGestureRecognizer:panRecognizer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:MSTIMER_INTERVAL target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", MSMAP_STARTING_SCORE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Below we use our finger location point, then pass the bezier Path objects to the method, then we get a copy of that bezier path back (tap target) so that if our finger point is on any of the copied bezier path objects, which tells us that we hit the wall.
-(void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    //Using the method locationInView to determine where in the coordinate system the touch is occurring
    CGPoint fingerLocation = [panRecognizer locationInView:self.pathView];
    if (panRecognizer.state == UIGestureRecognizerStateBegan && fingerLocation.y < 750)
    {
        self.scoreLabel.text = [NSString stringWithFormat:@"Score %i", MSMAP_STARTING_SCORE];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:MSTIMER_INTERVAL target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    }
    else if (panRecognizer.state == UIGestureRecognizerStateChanged)
    {
    for (UIBezierPath *fingerPath in [MSMountainPath mountainPathsForRect:self.pathView.bounds])
    {
        UIBezierPath *tapTarget = [MSMountainPath tapTargetForPath:fingerPath];
        if ([tapTarget containsPoint:fingerLocation])
        {
            [self decrementScoreByAmount:MSWALL_PENALTY];
        }
    }/Users/matsletten/Desktop/Race to the Top
    }
    else if (panRecognizer.state == UIGestureRecognizerStateEnded && fingerLocation.y <= 165)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Make sure to start at the bottom of the path, hold your finger down and finish at the top of the path" delegate:nil cancelButtonTitle:@"okay" otherButtonTitles:nil];
        [alert show];
        [self.timer invalidate];
        self.timer = nil;
    }
    
}
//method called when tap detected in view
-(void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    //we set our method to tell us where we are tapping within the view.
    CGPoint tapLocation = [tapRecognizer locationInView:self.pathView];
    NSLog(@"Tapped at location (%f, %f)!", tapLocation.x, tapLocation.y);
}

-(void)timerFired
{
    [self decrementScoreByAmount:MSMAP_SCORE_DECREMENT_AMOUNT];
}
//Method below sets up a consistent decrease in score using a constant subtraction combined with a timer interval.
-(void)decrementScoreByAmount:(int)amount
{
    NSString *scoreText = [[self.scoreLabel.text componentsSeparatedByString:@" "] lastObject];
    int score = [scoreText intValue];
    score = score - amount;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score %i", score];
}

@end
