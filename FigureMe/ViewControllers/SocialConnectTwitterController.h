//
//  SocialConnectController.h
//  FigureMe
//
//  Created by bhavesh on 10/17/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "OAuthConsumer.h"

@interface SocialConnectTwitterController : UIViewController <UIWebViewDelegate,UIAlertViewDelegate>
{
    IBOutlet UIWebView *webview;
    OAConsumer* consumer;
    OAToken* requestToken;
    OAToken* accessToken;
}

@property (nonatomic, retain) IBOutlet UIWebView *webview;

@property (nonatomic,strong) OAToken* accessToken;
@property (nonatomic, retain) NSString *isLogin;
@property (nonatomic) enum NetworkType network;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;

- (IBAction)btnCloseClicked:(id)sender;

@end
