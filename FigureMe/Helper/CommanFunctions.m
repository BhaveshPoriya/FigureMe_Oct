//
//  CommanFunctions.m
//  FigureMe
//
//  Created by ECSMac2 on 10/6/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "CommanFunctions.h"

@implementation CommanFunctions

+(NSString *) URLEncodeString:(NSString *) str
{
    NSString* urlString = str;
    NSString* trimmedUrlString = [urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedUrlString;
}

+(BOOL)IsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+(NSMutableURLRequest *)generateAPIRequest:(NSString *)APIUrl reqDist:(NSMutableDictionary* )reqDist{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:reqDist
                                                       options:0
                                                         error:&error];
    NSString *jsonString;
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSURL *url = [NSURL URLWithString:APIUrl];
    NSData *requestData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    return request;
}
+(NSMutableURLRequest *)getLogInRequest:(NSString *)Username Password:(NSString* )Password{
    
    NSMutableDictionary *reqDist = [[NSMutableDictionary alloc] init];
    [reqDist setObject:@"login" forKey:@"action"];
    [reqDist setObject:Username forKey:@"username"];
    [reqDist setObject:Password forKey:@"password"];

    NSString *_URL =[NSString stringWithFormat:@"%@/login", @APIRootURL];
    
    return [self generateAPIRequest:_URL reqDist:reqDist];
}
+(NSMutableURLRequest *)getRegisterRequest:(NSString *)Username Email:(NSString* )Email Password:(NSString* )Password{
    NSMutableDictionary *reqDist = [[NSMutableDictionary alloc] init];
    [reqDist setObject:@"register" forKey:@"action"];
    [reqDist setObject:Username forKey:@"username"];
    [reqDist setObject:Email forKey:@"email"];
    [reqDist setObject:Password forKey:@"password"];
    [reqDist setObject:@"" forKey:@"gcm_id"];
    [reqDist setObject:@"" forKey:@"deviceid"];
    
    NSString *_URL =[NSString stringWithFormat:@"%@/register", @APIRootURL];
    
    return [self generateAPIRequest:_URL reqDist:reqDist];
}

+(NSMutableURLRequest *)getCheckUsernameRequest:(NSString *)Username{
    NSMutableDictionary *reqDist = [[NSMutableDictionary alloc] init];
    [reqDist setObject:@"check_user_exist" forKey:@"action"];
    [reqDist setObject:Username forKey:@"username"];
    
    NSString *_URL =[NSString stringWithFormat:@"%@/check_user_exist", @APIRootURL];
    
    return [self generateAPIRequest:_URL reqDist:reqDist];
}

+(NSMutableURLRequest *)getCheckEmailRequest:(NSString *)Email{
    NSMutableDictionary *reqDist = [[NSMutableDictionary alloc] init];
    [reqDist setObject:@"check_email_exist" forKey:@"action"];
    [reqDist setObject:Email forKey:@"email"];
    
    NSString *_URL =[NSString stringWithFormat:@"%@/check_email_exist", @APIRootURL];
    
    return [self generateAPIRequest:_URL reqDist:reqDist];
}
+(NSMutableURLRequest *)getGalleryRequest:(NSString *)UserId{
    
    NSMutableDictionary *reqDist = [[NSMutableDictionary alloc] init];
    [reqDist setObject:@"get_galary" forKey:@"action"];
    [reqDist setObject:UserId forKey:@"userid"];
    
    NSString *_URL =[NSString stringWithFormat:@"%@/get_galary", @APIRootURL];
    
    return [self generateAPIRequest:_URL reqDist:reqDist];
}
@end
