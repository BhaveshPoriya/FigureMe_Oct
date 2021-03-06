//
//  Constant.h
//  FigureMe
//
//  Created by ECSMac2 on 10/2/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#ifndef FigureMe_Constant_h
#define FigureMe_Constant_h

#import "AppDelegate.h"

#pragma mark - ViewControllers

#import "ProfileEditViewController.h"

#pragma mark - Helper Classes

#import <AVFoundation/AVFoundation.h>
#import "AMSlideMenuMainViewController.h"
#import "CommanFunctions.h"
#import "IIIFlowView.h"
#import "UIImageView+WebCache.h"
#import "TPKeyboardAvoidingScrollView.h"
@class TPKeyboardAvoidingScrollView;
#import "SSCheckBoxView.h"
#import "UIHelpers.h"


#pragma mark - Categories

#import "NSString+Score.h"


#pragma mark - Custom Classes

#import "GalleryPhotoCell.h"

#pragma mark - Custom View

#import "ResultView.h"


#pragma mark - Models

#import "Score.h"
#import "UserProfile.h"
#import "Notification.h"

#pragma mark - iOS Devices

#define IS_IPAD   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_35 ([[UIScreen mainScreen] bounds].size.height == 480)
#define IS_IPHONE_40 ([[UIScreen mainScreen] bounds].size.height == 568)

#pragma mark - Push Notification

#define kDeviceTokenKey @"kDeviceTokenKey"

#pragma mark - Social Connect

#define kTwitterTokenKey @"kTwitterTokenKey"
#define kTwitterSecretKey @"kTwitterSecretKey"

#define kFacebookTokenKey @"kFacebookTokenKey"

#define kInstagramTokenKey @"kInstagramTokenKey"


#pragma mark - API

//#define APIRootURL "https://184.107.30.175:21/figureme/api"
#define APIRootURL "http://www.ecsprojects.com/figureme/api"
//#define APIRootURL "http://192.168.1.105:82/figureme/api"

enum NetworkType {
    NetworkTypeFacebook = 0,
    NetworkTypeTwitter = 1,
    NetworkTypeInstaGram = 2,
    NetworkTypeLinkedIn = 3
};

#endif
