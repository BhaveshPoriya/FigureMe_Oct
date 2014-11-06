//
//  NotificationController.m
//  FigureMe
//
//  Created by GauravPC on 10/31/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "NotificationController.h"
#import "Constant.h"
#import "NotificationTestCell.h"
#import "NotificationRequestCell.h"
@interface NotificationController ()
{
    NSMutableArray *arrNotification;
    
}
@end

@implementation NotificationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableURLRequest *_request = [CommanFunctions getNotificationRequest:@"12"];
    
   
    
    
   
    
    _request.timeoutInterval = 30;
    
    [NSURLConnection sendAsynchronousRequest:_request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             NSString *status = [[greeting  objectForKey:@"data"] objectForKey:@"status"];
             if([status isEqualToString:@"success"])
                 
             {
                 arrNotification = [[NSMutableArray alloc]init];
                 NSDictionary *notifications = [[greeting objectForKey:@"data"] objectForKey:@"notifications"];
                 
                 for(NSDictionary *_notifications in notifications)
                     
                 {
                     // NSDictionary *tempDist = [scores objectForKey:_Score];
                     
                     Notification *NotificationDetail = [[Notification alloc]init];
                     
                     
                     NotificationDetail.UserID = [_notifications objectForKey:@"UserID"];
                     NotificationDetail.image = [_notifications objectForKey:@"Test_picture"];
                     NotificationDetail.NotificationID = [_notifications objectForKey:@"NotificationID"];
                     NotificationDetail.friend_request_id = [_notifications objectForKey:@"friend_request_id"];
                     NotificationDetail.TestID = [_notifications objectForKey:@"TestID"];
                     NotificationDetail.Type = [_notifications objectForKey:@"Type"];
                     
                     NotificationDetail.url = [_notifications objectForKey:@"url"];
                     NotificationDetail.Score = [_notifications objectForKey:@"Score"];
                     NotificationDetail.scoreuserid = [_notifications objectForKey:@"scoreuserid"];
                     NotificationDetail.TimeStamp = [_notifications objectForKey:@"TimeStamp"];
                     NotificationDetail.date = [_notifications objectForKey:@"date"];
                     NotificationDetail.time = [_notifications objectForKey:@"time"];
                     NotificationDetail.notify_status = [_notifications objectForKey:@"notify_status"];
                     [arrNotification addObject:NotificationDetail];
                     
                     
                     
                 }
                 
                 [self.tblviewNotification reloadData];
             }
             
             
         }
     }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return arrNotification.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    NotificationTestCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        Notification *NotificationDetail = [arrNotification objectAtIndex:indexPath.row];
        
        cell = [[NotificationTestCell alloc] initWithNotification:NotificationDetail reuseIdentifier:CellIdentifier NotificationType:NotificationDetail.Type];
        
        
        cell.primaryLabel.text = NotificationDetail.time;
        cell.secondaryLabel.text = NotificationDetail.date;
                
        cell.myImageView.image = [UIImage imageNamed:@"images.png"];
        
        NSString *str = [[arrNotification objectAtIndex:indexPath.row]notify_status];
        
        if ([str isEqualToString:@"Read"])
        {
            [cell.button setTitle:@"Show Score" forState:UIControlStateNormal];
        }
               
        
        cell.button.tag = indexPath.row;
        [cell.button addTarget:self action:@selector(OpenTestClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }

    
    return cell;
}

-(void)OpenTestClicked:(UIButton*)sender
{
   
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
    
    NSString *User = [[arrNotification objectAtIndex:indexPath.row] UserID];
    NSString *Notification = [[arrNotification objectAtIndex:indexPath.row] NotificationID];
    
    
    NSLog(@"%@ %@",User,Notification);
    
    NSMutableURLRequest *_Notificationrequest = [CommanFunctions changeNotificationRequest:User NotificationId:Notification];
    
    
    _Notificationrequest.timeoutInterval = 30;
    
    [NSURLConnection sendAsynchronousRequest:_Notificationrequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             NSString *status = [[greeting  objectForKey:@"data"] objectForKey:@"status"];
             if([status isEqualToString:@"success"])
                 
             {
                 
                
                 
                 
                 
                 
             }
             
             
         }
     }];
    //here you get its each button action you can identirire which button click by its tag
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    NSLog(@"%d",indexPath.row);
    
    NSString *str = [[arrNotification objectAtIndex:indexPath.row]NotificationID];
    NSLog(@"%@",str);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
