//
//  NotificationTestCell.h
//  FigureMe
//
//  Created by GauravPC on 10/30/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface NotificationTestCell : UITableViewCell


{
    UILabel *primaryLabel;
    
    UILabel *secondaryLabel;
    UIImageView *myImageView;
    UIButton *button;
    
}

@property(nonatomic,retain)UILabel *primaryLabel;
@property(nonatomic,retain)UILabel *secondaryLabel;
@property(nonatomic,retain)UIImageView *myImageView;
@property(nonatomic,retain)UIButton *button;


- (id)initWithNotification:(Notification *)Notiication reuseIdentifier:(NSString *)reuseIdentifier NotificationType:(NSString *)Type;
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier;

-(void)buttonTapped:(UIButton*)sender;
@end
