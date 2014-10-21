//
//  SocialConnectInstagramController.m
//  FigureMe
//
//  Created by bhavesh on 10/20/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "SocialConnectInstagramController.h"

@interface SocialConnectInstagramController ()

@end

@implementation SocialConnectInstagramController

@synthesize webView = _webView;

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
    
    NSString *fullURL = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=1190cfbdcb034420a5ea513caed82817&redirect_uri=http://www.ecsprojects.com/figureme/instagram/getcode&response_type=token"];
    NSURL *url = [NSURL URLWithString:fullURL];
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
    [self checkForInstagramAccessToken:urlString];
    return TRUE;
}

#pragma mark Helper functions

-(void)checkForInstagramAccessToken:(NSString *)urlString {
    NSArray *UrlParts = [urlString componentsSeparatedByString:@"http://www.ecsprojects.com/figureme/instagram/getcode"];
    if ([UrlParts count] > 1) {
        // do any of the following here
        urlString = [UrlParts objectAtIndex:1];
        NSRange accessToken = [urlString rangeOfString: @"access_token="];
        if (accessToken.location != NSNotFound) {
            NSString* strAccessToken = [urlString substringFromIndex: NSMaxRange(accessToken)];
            NSLog(@"AccessToken = %@ ",strAccessToken);
            
            [[NSUserDefaults standardUserDefaults] setValue:strAccessToken forKey:kInstagramTokenKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            NSMutableURLRequest *_request = [CommanFunctions getPostInstagramTokenRequest:@"18" accessToken:strAccessToken];
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
                         UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Your Profile Successfully Connected To Instalgram." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
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
