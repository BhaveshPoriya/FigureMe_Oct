//
//  RightMenuVC.h
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

#import "AMSlideMenuRightTableViewController.h"

@interface RightMenuVC : AMSlideMenuRightTableViewController
@property (strong, nonatomic) IBOutlet UITableView *tableViewMenu;

@property (weak, nonatomic) IBOutlet UITableViewCell *cellHome;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellGallery;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellProfile;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellNotification;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellStats;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellBump;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellLogout;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewHome;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewGallery;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfile;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewNotification;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewStats;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewBump;
@property (weak, nonatomic) IBOutlet UILabel *lblDashboard;
@property (weak, nonatomic) IBOutlet UILabel *lblGallery;
@property (weak, nonatomic) IBOutlet UILabel *lblProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblNotification;
@property (weak, nonatomic) IBOutlet UILabel *lblStats;
@property (weak, nonatomic) IBOutlet UILabel *lblBump;
@property (weak, nonatomic) IBOutlet UILabel *lblLogout;

@end
