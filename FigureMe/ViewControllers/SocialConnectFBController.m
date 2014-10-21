//
//  SocialConnectFBController.m
//  FigureMe
//
//  Created by bhavesh on 10/18/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "SocialConnectFBController.h"

@interface SocialConnectFBController ()

@end

@implementation SocialConnectFBController

@synthesize webView = _webView;
@synthesize apiKey = _apiKey;
@synthesize requestedPermissions = _requestedPermissions;

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
	// Do any additional setup after loading the view.

    _apiKey = @"739811842722770";
    _requestedPermissions = @"publish_stream,user_friends";
    NSString *redirectUrlString = @"http://www.ecsprojects.com/figureme/facebooks/fblogin";
    NSString *authFormatString = @"https://graph.facebook.com/oauth/authorize?client_id=%@&redirect_uri=%@&scope=%@&type=user_agent&display=touch";
    
    NSString *urlString = [NSString stringWithFormat:authFormatString, _apiKey, redirectUrlString, _requestedPermissions];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCloseClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}

#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *urlString = request.URL.absoluteString;
    
    [self checkForFBAccessToken:urlString];
    
    return TRUE;
}

#pragma mark Helper functions

-(void)checkForFBAccessToken:(NSString *)urlString {
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"access_token=(.*)&" options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
        if (firstMatch) {
            NSRange accessTokenRange = [firstMatch rangeAtIndex:1];
            NSString *accessToken = [urlString substringWithRange:accessTokenRange];
            accessToken = [accessToken stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"FB Token : %@",accessToken);
            
            [[NSUserDefaults standardUserDefaults] setValue:accessToken forKey:kFacebookTokenKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSMutableURLRequest *_request = [CommanFunctions getPostFacebookTokenRequest:@"18" accessToken:accessToken];
            _request.timeoutInterval = 30;
            
            [NSURLConnection sendAsynchronousRequest:_request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response,
                                                       NSData *data, NSError *connectionError)
             {
                 if (data.length > 0 && connectionError == nil)
                 {
                     NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                     NSString *status = [[greeting objectForKey:@"data"] objectForKey:@"status"];
                     
                     if([status isEqualToString:@"success"])
                     {
                         UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Your Profile Successfully Connected To Facebook." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                         [successAlert show];
                         
                     }
                     else
                     {
                         NSString *message = [[greeting objectForKey:@"data"] objectForKey:@"message"];
                         NSLog(@"%@",message);
                         
                         UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Server is unavaiable" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                         [failAlert show];
                     }
                     
                 }
                 else
                 {
                     //No Data Recieved
                 }
             }];
            
        }
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
