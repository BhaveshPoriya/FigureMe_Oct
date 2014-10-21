//
//  SocialConnectLinkedInController.m
//  FigureMe
//
//  Created by bhavesh on 10/20/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "SocialConnectLinkedInController.h"


@interface SocialConnectLinkedInController ()

@end

@implementation SocialConnectLinkedInController

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
    _client = [self client];
    [self.client getAuthorizationCode:^(NSString *code) {
        [self.client getAccessToken:code success:^(NSDictionary *accessTokenData)
        {
            NSString *accessToken = [accessTokenData objectForKey:@"access_token"];
            NSLog(@"%@",accessToken);
        }
                            failure:^(NSError *error)
        {
            NSLog(@"Quering accessToken failed %@", error);
        }];
    }
                               cancel:^
    {
        NSLog(@"Authorization was cancelled by user");
    }
                              failure:^(NSError *error) {
        NSLog(@"Authorization failed %@", error);
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LIALinkedInHttpClient *)client {
    LIALinkedInApplication *application = [LIALinkedInApplication applicationWithRedirectURL:@"http://www.ecsprojects.com/figureme/linkedins/data"
                                                                                    clientId:@"75k4xlh0t6hkh6"
                                                                                clientSecret:@"bHSODMzSKOnKdNgI"
                                                                                       state:@"ECSPROJECTS3sdffef424"
                                                                               grantedAccess:@[@"r_fullprofile", @"r_network"]];
    return [LIALinkedInHttpClient clientForApplication:application presentingViewController:nil];
}
@end
