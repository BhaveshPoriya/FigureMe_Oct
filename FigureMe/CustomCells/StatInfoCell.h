//
//  StatInfoCell.h
//  FigureMe
//
//  Created by GauravPC on 10/10/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatInfoCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgviewStatInfoCell;
@property (strong, nonatomic) IBOutlet UILabel *lblNameStatInfoCell;
@property (strong, nonatomic) IBOutlet UILabel *lblScoreStatInfoCell;
@property (strong, nonatomic) IBOutlet UIButton *btnDeleteInstanceStatInfoCell;

- (IBAction)btnDeleteStatInfoCell:(id)sender;

@end
