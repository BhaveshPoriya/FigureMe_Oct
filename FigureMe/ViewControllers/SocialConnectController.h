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

@interface SocialConnectController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView *webview;
    OAConsumer* consumer;
    OAToken* requestToken;
    OAToken* accessToken;
}

@property (nonatomic,strong) OAToken* accessToken;
@property (nonatomic, retain) IBOutlet UIWebView *webview;
@property (nonatomic, retain) NSString *isLogin;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;
- (IBAction)btnCloseClicked:(id)sender;

@end
