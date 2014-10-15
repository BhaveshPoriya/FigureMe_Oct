//
//  AMSlideMenuRightTableViewController.m
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

#import "AMSlideMenuMainViewController.h"

#import "AMSlideMenuContentSegue.h"
@interface AMSlideMenuRightTableViewController ()

@end

@implementation AMSlideMenuRightTableViewController

/*----------------------------------------------------*/
#pragma mark - Lifecycle -
/*----------------------------------------------------*/

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)openContentNavigationController:(UINavigationController *)nvc
{
#ifdef AMSlideMenuWithoutStoryboards
    AMSlideMenuContentSegue *contentSegue = [[AMSlideMenuContentSegue alloc] initWithIdentifier:@"contentSegue" source:self destination:nvc];
    [contentSegue perform];
#else
    NSLog(@"This methos is only for NON storyboard use! You must define AMSlideMenuWithoutStoryboards \n (e.g. #define AMSlideMenuWithoutStoryboards)");
#endif
}

/*----------------------------------------------------*/
#pragma mark - TableView delegate -
/*----------------------------------------------------*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if ([self.mainVC respondsToSelector:@selector(navigationControllerForIndexPathInRightMenu:)]) {
        UINavigationController *navController = [self.mainVC navigationControllerForIndexPathInRightMenu:indexPath];
        AMSlideMenuContentSegue *segue = [[AMSlideMenuContentSegue alloc] initWithIdentifier:@"ContentSugue" source:self destination:navController];
        [segue perform];
    } else {
        NSString *segueIdentifier = [self.mainVC segueIdentifierForIndexPathInRightMenu:indexPath];
        if (segueIdentifier && segueIdentifier.length > 0)
        {
            [self resetAllMenuCell:tableView];

            UIColor *highlightedColor = [UIColor colorWithRed:72./255. green:218./255. blue:33./255. alpha:1.0f];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.backgroundColor = highlightedColor;

            UIImageView *imgView;
            UILabel *textLable;
            
            for (UIView *vw in cell.contentView.subviews) {
                if(vw.tag == 100)
                    imgView = (UIImageView*)vw;
                else if (vw.tag ==101)
                    textLable = (UILabel*)vw;
            }
            
            textLable.textColor = [UIColor whiteColor];
            
            switch (cell.tag)
            {
                case 0:
                    imgView.image = [UIImage imageNamed:@"home-hover"];
                    break;
                    
                case 1:
                    imgView.image = [UIImage imageNamed:@""];
                    break;
                    
                case 2:
                    imgView.image = [UIImage imageNamed:@"my-profile-hover"];
                    break;
                    
                case 3:
                    imgView.image = [UIImage imageNamed:@"notificatrion-hover"];
                    break;
                    
                case 4:
                    imgView.image = [UIImage imageNamed:@"stats-hover"];
                    break;
                    
                case 5:
                    imgView.image = [UIImage imageNamed:@"bump-hover"];
                    break;
                    
                case 6:
                    imgView.image = [UIImage imageNamed:@"logout-hover"];
                    break;
                    
                default:
                    break;
            }

            
            if(![segueIdentifier isEqualToString:@"logout"])
                [self performSegueWithIdentifier:segueIdentifier sender:self];
            else
                [self performSegueWithIdentifier:@"UnwindToLoginSegueID" sender:self];
        }
    }
}

-(void)resetAllMenuCell:(UITableView*)tableview
{
    int cellCount = [tableview numberOfRowsInSection:0];
    
    for (int i =0; i<cellCount; i++) {
        UITableViewCell *cell = [tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.backgroundColor = [UIColor colorWithRed:29./255. green:56./255. blue:99./255. alpha:1.0f];
        
        UIImageView *imgView;
        UILabel *textLable;
        
        for (UIView *vw in cell.contentView.subviews) {
            if(vw.tag == 100)
                imgView = (UIImageView*)vw;
            else if (vw.tag ==101)
                textLable = (UILabel*)vw;
        }
        textLable.textColor = [UIColor colorWithRed:162./255. green:185./255. blue:253./255. alpha:1.0f];
        switch (cell.tag)
        {
            case 0:
                imgView.image = [UIImage imageNamed:@"home"];
                break;
            
            case 1:
                imgView.image = [UIImage imageNamed:@""];
                break;
                
            case 2:
                imgView.image = [UIImage imageNamed:@"my-profile"];
                break;
                
            case 3:
                imgView.image = [UIImage imageNamed:@"notification"];
                break;
                
            case 4:
                imgView.image = [UIImage imageNamed:@"stats"];
                break;
                
            case 5:
                imgView.image = [UIImage imageNamed:@"bump"];
                break;
                
            case 6:
                imgView.image = [UIImage imageNamed:@"logout"];
                break;
                
            default:
                break;
        }
    }

}

@end
