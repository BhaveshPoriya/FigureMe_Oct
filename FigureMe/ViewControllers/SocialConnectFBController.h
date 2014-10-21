//
//  SocialConnectFBController.h
//  FigureMe
//
//  Created by bhavesh on 10/18/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface SocialConnectFBController : UIViewController <UIWebViewDelegate,UIAlertViewDelegate>
{
    UIWebView *_webView;
    NSString *_apiKey;
    NSString *_requestedPermissions;
}

@property (retain) IBOutlet UIWebView *webView;
@property (copy) NSString *apiKey;
@property (copy) NSString *requestedPermissions;

- (IBAction)btnCloseClicked:(id)sender;
- (void)checkForFBAccessToken:(NSString *)urlString;

@end
