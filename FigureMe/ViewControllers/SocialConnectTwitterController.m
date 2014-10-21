//
//  SocialConnectController.m
//  FigureMe
//
//  Created by bhavesh on 10/17/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "SocialConnectTwitterController.h"

NSString *client_id;
NSString *secret;
NSString *callback;
NSString *strRequestTokenUrl;
NSString *strAuthorizeUrl;
NSString *strAccessTokenUrl;

@interface SocialConnectTwitterController ()

@end

@implementation SocialConnectTwitterController

@synthesize webview, isLogin,accessToken;

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
 
    client_id = @"GJHVJl5s9tVIaQFWkSi64QTtd";
    secret = @"qWvXsdSXNJlrn23KkRZQqEeVebx6BJ6mWkDfGaM8YIPDpSywsh";
    callback = @"http://www.ecsprojects.com/figureme/twitter/callback";
    strRequestTokenUrl = @"https://api.twitter.com/oauth/request_token";
    strAuthorizeUrl = @"https://api.twitter.com/oauth/authorize";
    strAccessTokenUrl = @"https://api.twitter.com/oauth/access_token";
    
    consumer = [[OAConsumer alloc] initWithKey:client_id secret:secret realm:nil];
    NSURL* requestTokenUrl = [NSURL URLWithString:strRequestTokenUrl];
    OAMutableURLRequest* requestTokenRequest = [[OAMutableURLRequest alloc] initWithURL:requestTokenUrl
                                                                               consumer:consumer
                                                                                  token:nil
                                                                                  realm:nil
                                                                      signatureProvider:nil];
    OARequestParameter* callbackParam = [[OARequestParameter alloc] initWithName:@"oauth_callback" value:callback];
    [requestTokenRequest setHTTPMethod:@"POST"];
    [requestTokenRequest setParameters:[NSArray arrayWithObject:callbackParam]];
    OADataFetcher* dataFetcher = [[OADataFetcher alloc] init];
    [dataFetcher fetchDataWithRequest:requestTokenRequest
                             delegate:self
                    didFinishSelector:@selector(didReceiveRequestToken:data:)
                      didFailSelector:@selector(didFailOAuth:error:)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCloseClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}

#pragma mark - OAuthCunsumerDelegates

- (void)didReceiveRequestToken:(OAServiceTicket*)ticket data:(NSData*)data {
    NSString* httpBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    requestToken = [[OAToken alloc] initWithHTTPResponseBody:httpBody];
    
    NSURL* authorizeUrl = [NSURL URLWithString:strAuthorizeUrl];
    OAMutableURLRequest* authorizeRequest = [[OAMutableURLRequest alloc] initWithURL:authorizeUrl
                                                                            consumer:nil
                                                                               token:nil
                                                                               realm:nil
                                                                   signatureProvider:nil];
    NSString* oauthToken = requestToken.key;
    OARequestParameter* oauthTokenParam = [[OARequestParameter alloc] initWithName:@"oauth_token" value:oauthToken];
    [authorizeRequest setParameters:[NSArray arrayWithObject:oauthTokenParam]];
    
    [webview loadRequest:authorizeRequest];
}

- (void)didReceiveAccessToken:(OAServiceTicket*)ticket data:(NSData*)data {
    
    NSString* httpBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    accessToken = [[OAToken alloc] initWithHTTPResponseBody:httpBody];
    
    NSLog(@"Access Token/OAuth Token := %@",accessToken.key);
    NSLog(@"OAuth Secret := %@",accessToken.secret);
    
    [[NSUserDefaults standardUserDefaults] setValue:accessToken.key forKey:kTwitterTokenKey];
    [[NSUserDefaults standardUserDefaults] setValue:accessToken.secret forKey:kTwitterSecretKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSMutableURLRequest *_request = [CommanFunctions getPostTokenRequest:@"18" accessToken:accessToken.key screteKey:accessToken.secret];
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
                 UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Your Profile Successfully Connected To Twitter." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
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

- (void)didFailOAuth:(OAServiceTicket*)ticket error:(NSError*)error {
    // ERROR!
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{

    NSString *temp = [NSString stringWithFormat:@"%@",request];
    NSRange textRange = [[temp lowercaseString] rangeOfString:[callback lowercaseString]];
    
    if(textRange.location != NSNotFound)
    {   
        // Extract oauth_verifier from URL query
        NSString* verifier = nil;
        NSArray* urlParams = [[[request URL] query] componentsSeparatedByString:@"&"];
        for (NSString* param in urlParams) {
            NSArray* keyValue = [param componentsSeparatedByString:@"="];
            NSString* key = [keyValue objectAtIndex:0];
            if ([key isEqualToString:@"oauth_verifier"]) {
                verifier = [keyValue objectAtIndex:1];
                break;
            }
        }
        
        if (verifier) {
            NSURL* accessTokenUrl = [NSURL URLWithString:strAccessTokenUrl];
            OAMutableURLRequest* accessTokenRequest = [[OAMutableURLRequest alloc] initWithURL:accessTokenUrl consumer:consumer token:requestToken realm:nil signatureProvider:nil];
            OARequestParameter* verifierParam = [[OARequestParameter alloc] initWithName:@"oauth_verifier" value:verifier];
            [accessTokenRequest setHTTPMethod:@"POST"];
            [accessTokenRequest setParameters:[NSArray arrayWithObject:verifierParam]];
            OADataFetcher* dataFetcher = [[OADataFetcher alloc] init];
            [dataFetcher fetchDataWithRequest:accessTokenRequest
                                     delegate:self
                            didFinishSelector:@selector(didReceiveAccessToken:data:)
                              didFailSelector:@selector(didFailOAuth:error:)];
        } else {
            // ERROR!
        }
        
        return NO;
    }
    
    return YES;
}

- (void)webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error {
    // ERROR!
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    // [indicator stopAnimating];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
