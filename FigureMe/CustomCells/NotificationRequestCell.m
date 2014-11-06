//
//  NotificationRequestCell.m
//  FigureMe
//
//  Created by GauravPC on 10/30/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "NotificationRequestCell.h"

@implementation NotificationRequestCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}
//-(id)initWithNotification:(NSString *)Notiication reuseIdentifier:(NSString *)reuseIdentifier NotificationType:(NSString *)Type
//{
//    
//         [self initWithNotification:@"test" reuseIdentifier:@"hello" NotificationType:@"test123"];
//    
//    return self;
//    
//}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
