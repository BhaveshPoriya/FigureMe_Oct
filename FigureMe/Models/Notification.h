//
//  GetNotification.h
//  FigureMe
//
//  Created by GauravPC on 10/30/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notification : NSObject
{
    
    
    NSString *url;
    NSString *NotificationID;
    NSString *friend_request_id;
    NSString *TestID;
    NSString *UserID;
    NSString *Type;
    NSString *Score;
    NSString *scoreuserid;
    NSString *TimeStamp;
    NSString *date;
    NSString *time;
    NSString *Image;
    NSString *notify_status;
    
}


@property(nonatomic,retain)NSString *url;
@property(nonatomic,retain)NSString *NotificationID;
@property(nonatomic,retain)NSString *friend_request_id;
@property(nonatomic,retain)NSString *TestID;
@property(nonatomic,retain)NSString *UserID;
@property(nonatomic,retain)NSString *Type;
@property(nonatomic,retain)NSString *Score;
@property(nonatomic,retain)NSString *scoreuserid;
@property(nonatomic,retain)NSString *TimeStamp;
@property(nonatomic,retain)NSString *date;
@property(nonatomic,retain)NSString *time;
@property(nonatomic,retain)NSString *Image;
@property(nonatomic,retain)NSString *notify_status;
@end
