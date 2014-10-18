//
//  StatYourScore.h
//  FigureMe
//
//  Created by GauravPC on 10/10/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Score.h"

@interface StatYourScore : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblViewStatYourScore;
@property (strong, nonatomic) IBOutlet UIButton *btnInstanceHeadingStatYourScore;

- (IBAction)btnActionHeadingStatYourScore:(id)sender;
@property (strong, nonatomic) IBOutlet UITabBarItem *tabbarItemScore;
@end
