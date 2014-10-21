//
//  Constant.h
//  FigureMe
//
//  Created by ECSMac2 on 10/2/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#ifndef FigureMe_Constant_h
#define FigureMe_Constant_h
#import "AMSlideMenuMainViewController.h"
#import "CommanFunctions.h"
#import "IIIFlowView.h"
#import "UIImageView+WebCache.h"
#import "TPKeyboardAvoidingScrollView.h"
@class TPKeyboardAvoidingScrollView;

#import "GalleryPhotoCell.h"


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

#define APIRootURL "http://www.ecsprojects.com/figureme/api"
#define APIRootURL_LOCAL "http://192.168.1.116:82/figureme/api"

enum NetworkType {
    NetworkTypeFacebook = 0,
    NetworkTypeTwitter = 1,
    NetworkTypeInstaGram = 2,
    NetworkTypeLinkedIn = 3
};

#endif
