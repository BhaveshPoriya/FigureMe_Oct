//
//  SocialConnectLinkedInController.h
//  FigureMe
//
//  Created by bhavesh on 10/20/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIALinkedInHttpClient.h"
#import "LIALinkedInApplication.h"

@interface SocialConnectLinkedInController : UIViewController
{
    LIALinkedInHttpClient *_client;
}
@end
