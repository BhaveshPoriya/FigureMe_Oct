//
//  MCFadeSegue.m
//  FigureMe
//
//  Created by bhavesh on 11/3/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "MCFadeSegue.h"

@implementation MCFadeSegue

- (void)perform
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionFade;
    
    [[[[[self sourceViewController] view] window] layer] addAnimation:transition
                                                               forKey:kCATransitionFade];
    
    [[self sourceViewController]
     presentViewController:[self destinationViewController]
     animated:NO completion:NULL];
}

@end
