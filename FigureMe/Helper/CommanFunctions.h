//
//  CommanFunctions.h
//  FigureMe
//
//  Created by ECSMac2 on 10/6/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"

@interface CommanFunctions : NSObject

+(NSString *) URLEncodeString:(NSString *) str;
+(BOOL)IsValidEmail:(NSString *)checkString;

+(NSMutableURLRequest *)generateAPIRequest:(NSString *)APIUrl reqDist:(NSMutableDictionary* )reqDist;
+(NSMutableURLRequest *)getLogInRequest:(NSString *)Username Password:(NSString* )Password;
+(NSMutableURLRequest *)getRegisterRequest:(NSString *)Username Email:(NSString* )Email Password:(NSString* )Password;
+(NSMutableURLRequest *)getCheckUsernameRequest:(NSString *)Username;
+(NSMutableURLRequest *)getCheckEmailRequest:(NSString *)Email;
+(NSMutableURLRequest *)getGalleryRequest:(NSString *)UserId;
+(NSMutableURLRequest *)getScoreRequest:(NSString *)Score;
+(NSMutableURLRequest *)getProfileRequest:(NSString *)UserId;
+(NSMutableURLRequest *)getPostTokenRequest:(NSString *)UserId accessToken:(NSString *)accessToken screteKey:(NSString *)screteKey;
+(NSMutableURLRequest *)getPostFacebookTokenRequest:(NSString *)UserId accessToken:(NSString *)accessToken;
+(NSMutableURLRequest *)getPostInstagramTokenRequest:(NSString *)UserId accessToken:(NSString *)accessToken;
@end
