//
//  Question.h
//  FigureMe
//
//  Created by bhavesh on 11/3/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject
{
    
    NSString *Question;
    NSString *Answer;
    NSInteger Points;
}

@property(nonatomic,retain)NSString *Question;
@property(nonatomic,retain)NSString *Answer;
@property(nonatomic)NSInteger Points;

@end
