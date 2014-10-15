//
//  Score.h
//  FigureMe
//
//  Created by GauravPC on 10/10/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject

{
    
    NSString *Name;
    NSString *Score;
    NSString *image;
    NSString *Userid;
    
}

@property(nonatomic,retain)NSString *Name;
@property(nonatomic,retain)NSString *Score;
@property(nonatomic,retain)NSString *image;
@property(nonatomic,retain)NSString *Userid;
@end
