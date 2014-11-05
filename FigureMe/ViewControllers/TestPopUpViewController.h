//
//  TestPopUpViewController.h
//  FigureMe
//
//  Created by bhavesh on 10/30/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"

@interface TestPopUpViewController : UIViewController

@property (strong, nonatomic) Test *currentTest;
@property (strong, nonatomic) IBOutlet UIView *viewTestOverViewContainer;
@property (strong, nonatomic) IBOutlet UIView *viewTestPicContainer;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewTestPic;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
- (IBAction)btnCloseTestClicked:(id)sender;
- (IBAction)btnOpenTestClicked:(id)sender;

@end
