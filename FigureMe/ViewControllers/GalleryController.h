//
//  GalleryController.h
//  FigureMe
//
//  Created by bhavesh on 10/13/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"


@interface GalleryController : UIViewController <IIIFlowViewDelegate>

@property (strong, nonatomic) IIIFlowView *galleryFlowview;
@property (strong, nonatomic)NSMutableArray *dataSource;
@property (strong, nonatomic)NSMutableArray *testA;


@end
