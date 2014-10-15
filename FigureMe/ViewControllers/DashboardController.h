//
//  DashboardController.h
//  FigureMe
//
//  Created by ECSMac2 on 10/2/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface DashboardController : UIViewController <IIIFlowViewDelegate>

#pragma mark - IIIFlowView Properties
@property (strong, nonatomic) IIIFlowView *galleryFlowview;
@property (strong, nonatomic)NSMutableArray *dataSource;
@property (strong, nonatomic)NSMutableArray *testA;

@property (weak, nonatomic) IBOutlet UIButton *btnSeeAll;

@property (strong, nonatomic) IBOutlet UIView *spinnerOverlay;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;

- (IBAction)btnSeeAllClicked:(id)sender;

@end
