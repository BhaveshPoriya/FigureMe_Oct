//
//  MenuContainerVC.m
//  FigureMe
//
//  Created by ECSMac2 on 10/2/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "MenuContainerVC.h"

@interface MenuContainerVC ()

@end

@implementation MenuContainerVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*----------------------------------------------------*/
#pragma mark - Overriden Methods -
/*----------------------------------------------------*/


- (NSString *)segueIdentifierForIndexPathInRightMenu:(NSIndexPath *)indexPath
{
    //UIColor *highlightedColor = [UIColor colorWithRed:72./255. green:218./255. blue:33./255. alpha:1.0f];
    UIColor *highlightedColor = [UIColor yellowColor];
    
    RightMenuVC *rightMenuObject = [[RightMenuVC alloc] init];
    
    NSString *identifier = @"";
    switch (indexPath.row) {
        case 0:
            identifier = @"dashboard";
            rightMenuObject.cellHome.backgroundColor = highlightedColor;
            break;
        case 1:
            identifier = @"gallery";
            rightMenuObject.cellGallery.backgroundColor = highlightedColor;
            break;
        case 2:
            identifier = @"profile";
            rightMenuObject.cellProfile.backgroundColor = highlightedColor;
            break;
        case 3:
            identifier = @"notification";
            rightMenuObject.cellNotification.backgroundColor = highlightedColor;
            break;
        case 4:
            identifier = @"stats";
            rightMenuObject.cellStats.backgroundColor = highlightedColor;
            break;
        case 5:
            identifier = @"bump";
            rightMenuObject.cellBump.backgroundColor = highlightedColor;
            break;
        case 6:
            identifier = @"logout";
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:nil forKey:@"isLoggedIn"];
            [defaults setObject:nil forKey:@"userID"];
            
            [defaults synchronize];
            
            [self performSegueWithIdentifier:@"PushLogOut" sender:Nil];
            
            break;
    }
    return identifier;
}

- (CGFloat)rightMenuWidth
{
    return 180;
}

- (void)configureRightNotificationButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame = CGRectMake(10, 8, 30, 24);
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    //[button setTitleEdgeInsets:UIEdgeInsetsMake(20.0, -65.0, 5.0, 5.0)];
    //[button setTitle:[NSString stringWithFormat:@"%d",1] forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setImage:[UIImage imageNamed:@"notification"] forState:UIControlStateNormal];
}

- (void)configureRightMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame = CGRectMake(50, 15, 20, 15);
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
}



- (void) configureSlideLayer:(CALayer *)layer
{
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 1;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowRadius = 5;
    layer.masksToBounds = NO;
    layer.shadowPath =[UIBezierPath bezierPathWithRect:self.view.layer.bounds].CGPath;
}

- (AMPrimaryMenu)primaryMenu
{
    return AMPrimaryMenuRight;
}


// Enabling Deepnes on left menu
- (BOOL)deepnessForRightMenu
{
    return YES;
}

// Enabling darkness while right menu is opening
- (CGFloat)maxDarknessWhileRightMenu
{
    return 0.5;
}



@end
