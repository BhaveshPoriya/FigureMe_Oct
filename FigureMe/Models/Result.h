//
//  Result.h
//  FigureMe
//
//  Created by bhavesh on 11/5/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject
{
    
    NSString *TestID;
    NSString *UserID;
    NSString *Name;
    NSString *Score;
    NSString *Test_picture;
}

@property(nonatomic,retain)NSString *TestID;
@property(nonatomic,retain)NSString *UserID;
@property(nonatomic,retain)NSString *Name;
@property(nonatomic,retain)NSString *Score;
@property(nonatomic,retain)NSString *Test_picture;

@end
