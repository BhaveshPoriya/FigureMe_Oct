//
//  NotificationController.h
//  FigureMe
//
//  Created by GauravPC on 10/31/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notification.h"
@interface NotificationController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblviewNotification;
@end
