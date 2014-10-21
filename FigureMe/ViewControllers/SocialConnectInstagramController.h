//
//  SocialConnectInstagramController.h
//  FigureMe
//
//  Created by bhavesh on 10/20/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface SocialConnectInstagramController : UIViewController<UIWebViewDelegate,UIAlertViewDelegate>
{
    UIWebView *_webView;
}

@property (retain) IBOutlet UIWebView *webView;

- (IBAction)btnCloseClicked:(id)sender;
- (void)checkForInstagramAccessToken:(NSString *)urlString;

@end
