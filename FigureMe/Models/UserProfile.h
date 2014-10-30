//
//  UserProfile.h
//  FigureMe
//
//  Created by bhavesh on 10/21/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserProfile : NSObject

{
    
    NSString *strUserName;
    NSString *strProfilePic;
    NSString *strLocationCity;
    NSString *strLocationState;
    NSString *strScore;
    NSString *strDOB;
    NSString *strAboutMe;
    
}

@property(nonatomic,retain)NSString *strUserName;
@property(nonatomic,retain)NSString *strProfilePic;
@property(nonatomic,retain)NSString *strLocationCity;
@property(nonatomic,retain)NSString *strLocationState;
@property(nonatomic,retain)NSString *strScore;
@property(nonatomic,retain)NSString *strDOB;
@property(nonatomic,retain)NSString *strAboutMe;

@end
