//
//  AnimationViewController.m
//  iOSTest
//
//  Created by App Partner on 12/13/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "AnimationViewController.h"
#import "MenuViewController.h"
#import "AppDelegate.h"

@interface AnimationViewController ()
@end

@implementation AnimationViewController
#define M_PI   3.14159265358979323846264338327950288


/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make the UI look like it does in the mock-up.
 *
 * 2) Logo should spin when the user hits the spin button
 *
 * 3) User should be able to drag the logo around the screen with his/her fingers
 *
 * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
 *    section in Swfit to show off your skills. Anything your heart desires!
 *
 **/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Animation";
    CGSize size = self.imageView.frame.size;
    [self.view setCenter:CGPointMake(size.width/2, size.height/2)];
    
    // shadow effect
    self.imageView.layer.shadowOffset = CGSizeMake(10, 10);
    self.imageView.layer.shadowRadius = 5.0;
    self.imageView.layer.shadowOpacity = 0.6;
    self.imageView.layer.masksToBounds = NO;
    
    UIPanGestureRecognizer *panGesture =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragging:)];
    [self.imageView addGestureRecognizer:panGesture];
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.imageView];
    CGPoint previousLocation = [aTouch previousLocationInView:self.imageView];
    self.imageView.frame = CGRectOffset(self.imageView.frame, (location.x - previousLocation.x), (location.y - previousLocation.y));
 
}
-(void)dragging:(UIPanGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        //NSLog(@"Received a pan gesture");
        self->pointLocation = [gesture locationInView:gesture.view];
    }
    CGPoint newLocation = [gesture locationInView:gesture.view];
    float dX = newLocation.x-pointLocation.x;
    float dY = newLocation.y-pointLocation.y;
    
    gesture.view.frame = CGRectMake(gesture.view.frame.origin.x+dX, gesture.view.frame.origin.y+dY, gesture.view.frame.size.width, gesture.view.frame.size.height);
}

- (IBAction)didPressSpinButton:(id)sender

{
    NSString *buttonTitle = [(UIButton *)sender currentTitle];
    
    if([buttonTitle  isEqual: @"Spin"]){
        [_spinButton setTitle:@"Stop" forState:UIControlStateNormal];
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat: 5*M_PI];
        animation.duration = 10.0f;
        animation.repeatCount = INFINITY;
        [self.imageView.layer addAnimation:animation forKey:@"SpinAnimation"];
        
    }else{
        [_spinButton setTitle:@"Spin" forState:UIControlStateNormal];
         [self.imageView.layer removeAnimationForKey:@"SpinAnimation"];
    }
    
}

@end
