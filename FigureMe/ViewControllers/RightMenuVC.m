//
//  RightMenuVC.m
//  AMSlideMenu
//
// The MIT License (MIT)
//
// Created by : arturdev
// Copyright (c) 2014 SocialObjects Software. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

#import "RightMenuVC.h"

@implementation RightMenuVC

@synthesize cellHome = _cellHome,
cellGallery = _cellGallery,
cellProfile = _cellProfile,
cellStats = _cellStats,
cellNotification = _cellNotification,
cellBump = _cellBump,
cellLogout = _cellLogout;

- (void)viewDidLoad
{
    NSLog(@"----->once");
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu-main-bg"]];
    
    self.tableViewMenu.alwaysBounceVertical = NO;
    self.tableViewMenu.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"devider"]];
    
    self.cellHome.selectionStyle =
    self.cellGallery.selectionStyle =
    self.cellProfile.selectionStyle =
    self.cellNotification.selectionStyle =
    self.cellStats.selectionStyle =
    self.cellBump.selectionStyle =
    self.cellLogout.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cellHome.backgroundColor =[UIColor colorWithRed:72./255. green:218./255. blue:33./255. alpha:1.0f];
    
    self.cellGallery.backgroundColor =
    self.cellProfile.backgroundColor =
    self.cellNotification.backgroundColor =
    self.cellStats.backgroundColor =
    self.cellBump.backgroundColor =
    self.cellLogout.backgroundColor = [UIColor colorWithRed:29./255. green:56./255. blue:99./255. alpha:1.0f];
    
    self.lblDashboard.font =
    self.lblGallery.font =
    self.lblProfile.font =
    self.lblNotification.font =
    self.lblStats.font =
    self.lblBump.font =
    self.lblLogout.font = [UIFont fontWithName:@"OpenSans-Semibold" size:12];
   
    self.lblDashboard.textColor = [UIColor whiteColor];
    
    self.lblGallery.textColor =
    self.lblProfile.textColor =
    self.lblNotification.textColor =
    self.lblStats.textColor =
    self.lblBump.textColor =
    self.lblLogout.textColor = [UIColor colorWithRed:162./255. green:185./255. blue:253./255. alpha:1.0f];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && ![UIApplication sharedApplication].isStatusBarHidden)
    {
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    }
}

- (IBAction)unwindToLogin:(UIStoryboardSegue *)unwindSegue
{
    NSLog(@"logoutClicked");
}

@end
