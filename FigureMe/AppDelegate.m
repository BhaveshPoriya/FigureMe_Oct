//
//  AppDelegate.m
//  FigureMe
//
//  Created by ECSMac2 on 10/2/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
    // Handle launching from a notification
     //[[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    application.applicationIconBadgeNumber = 0;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if(application.applicationIconBadgeNumber > 0)
        application.applicationIconBadgeNumber = application.applicationIconBadgeNumber-1;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Push Notification Delegation methods

/*
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"Fetching...");
    [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber+1;
    completionHandler(UIBackgroundFetchResultNewData);
}
*/

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo NS_AVAILABLE_IOS(3_0)
{
    
    if([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground)
    {
        NSLog(@"Background");
    }
    else if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateInactive)
    {
        NSLog(@"Inactive");
    }
    else if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
    {
        NSLog(@"Active");
    }
    
    //NSLog(@"%@",userInfo);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        
        UIView *customView = [[UIView alloc] initWithFrame:self.window.frame];
        customView.backgroundColor = [UIColor blackColor];
        customView.alpha = 0.6f;
        
        [self.window addSubview:customView];
    }
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
}


- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken
{
    NSString *token = [[devToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"token: %@", token);
    
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:kDeviceTokenKey];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    NSLog(@"Error in registration. Error: %@", err);
}

@end
