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

#import "TPKeyboardAvoidingScrollView.h"
@class TPKeyboardAvoidingScrollView;

#import "GalleryPhotoCell.h"


#pragma mark - iOS Devices

#define IS_IPAD   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_35 ([[UIScreen mainScreen] bounds].size.height == 480)
#define IS_IPHONE_40 ([[UIScreen mainScreen] bounds].size.height == 568)


#pragma mark - API

#define APIRootURL "http://www.ecsprojects.com/figureme/api"
#define APIRootURL_LOCAL "http://192.168.1.116:82/figureme/api"


#endif
