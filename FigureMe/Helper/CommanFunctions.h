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
+(NSString*)imageToBase64:(UIImage *)inputimage;


+(NSMutableURLRequest *)generateAPIRequest:(NSString *)APIUrl reqDist:(NSMutableDictionary* )reqDist;
+(NSMutableURLRequest *)getLogInRequest:(NSString *)Username Password:(NSString* )Password pushToken:(NSString* )pushToken;
+(NSMutableURLRequest *)getRegisterRequest:(NSString *)Username Email:(NSString* )Email Password:(NSString* )Password;
+(NSMutableURLRequest *)getCheckUsernameRequest:(NSString *)Username;
+(NSMutableURLRequest *)getCheckEmailRequest:(NSString *)Email;
+(NSMutableURLRequest *)getGalleryRequest:(NSString *)UserId;
+(NSMutableURLRequest *)getScoreRequest:(NSString *)Score;
+(NSMutableURLRequest *)getProfileRequest:(NSString *)UserId;
+(NSMutableURLRequest *)getUpdateProfileRequest:(NSString *)UserId userName:(NSString*)userName DOB:(NSString*)DOB interests:(NSString*)interests location:(NSString*)location aboutMe:(NSString*)aboutMe profilePic:(NSString*)profilePic;
+(NSMutableURLRequest *)getTest:(NSString *)TestId;
+(NSMutableURLRequest *)submitTest:(NSString *)UserId TestId:(NSString *)TestId Score:(NSString *)Score;

+(NSMutableURLRequest *)getPostTokenRequest:(NSString *)UserId accessToken:(NSString *)accessToken screteKey:(NSString *)screteKey;
+(NSMutableURLRequest *)getPostFacebookTokenRequest:(NSString *)UserId accessToken:(NSString *)accessToken;
+(NSMutableURLRequest *)getPostInstagramTokenRequest:(NSString *)UserId accessToken:(NSString *)accessToken;
+(NSMutableURLRequest *)getNotificationRequest:(NSString *)UserId;
+(NSMutableURLRequest *)changeNotificationRequest:(NSString *)UserId NotificationId:(NSString *)NotificationId;
@end
