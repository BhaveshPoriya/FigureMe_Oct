//
//  ProfileController.h
//  FigureMe
//
//  Created by ECSMac2 on 10/3/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIIFlowView.h"
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"

@interface ProfileController : UIViewController<UITextViewDelegate>
{
    UserProfile *objUserProfile;
}

@property (retain, nonatomic) UserProfile *objUserProfile;

@property (weak, nonatomic) IBOutlet UIView *viewLocationContainer;
@property (weak, nonatomic) IBOutlet UIView *viewScoreContainer;
@property (weak, nonatomic) IBOutlet UIView *viewDOBContainer;
@property (weak, nonatomic) IBOutlet UIView *viewAboutMeContainer;


@property (weak, nonatomic) IBOutlet UIButton *btnEditProfile;

@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewProfilePic;
@property (strong, nonatomic) IBOutlet UILabel *lblLocationDetail;
@property (strong, nonatomic) IBOutlet UILabel *lblDateOfBirthDetail;
@property (strong, nonatomic) IBOutlet UILabel *lblScoreDetail;
@property (strong, nonatomic) IBOutlet UITextView *txtViewAboutMeDetail;

- (IBAction)btnEditProfileClicked:(id)sender;

@end
