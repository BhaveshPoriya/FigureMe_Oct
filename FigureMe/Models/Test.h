//
//  Test.h
//  FigureMe
//
//  Created by bhavesh on 11/3/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Test : NSObject
{
    
    NSString *Name;
    NSString *Test_picture;
    NSString *TestID;
    NSMutableArray *Questions;
    NSString *Score;

}

@property(nonatomic,retain)NSString *Name;
@property(nonatomic,retain)NSString *Test_picture;
@property(nonatomic,retain)NSString *TestID;
@property(nonatomic,retain)NSMutableArray *Questions;
@property(nonatomic,retain)NSString *Score;


@end
