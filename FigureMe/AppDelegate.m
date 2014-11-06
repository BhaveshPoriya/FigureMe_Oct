//
//  AppDelegate.m
//  FigureMe
//
//  Created by ECSMac2 on 10/2/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize sharedArray;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    sharedArray = [[NSMutableArray alloc]init];
    [sharedArray addObject:@"Biking"];
    [sharedArray addObject:@"Movies"];
    [sharedArray addObject:@"Music"];
    [sharedArray addObject:@"Painting"];
    [sharedArray addObject:@"Photography"];
    [sharedArray addObject:@"Writing"];
    [sharedArray addObject:@"Sports"];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        } else {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
        }
#else
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
#endif
    
    // Handle launching from a notification
     //[[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    application.applicationIconBadgeNumber = 0;

    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"footer-bg"]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"footer-hover-bg"]];
    
    
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
    
    NSLog(@"%@",userInfo);
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
