//
//  StatInfoCell.m
//  FigureMe
//
//  Created by GauravPC on 10/10/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "StatInfoCell.h"

@implementation StatInfoCell
@synthesize imgviewStatInfoCell,lblNameStatInfoCell,lblScoreStatInfoCell,btnDeleteInstanceStatInfoCell;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnDeleteStatInfoCell:(id)sender
{
    
}
@end
