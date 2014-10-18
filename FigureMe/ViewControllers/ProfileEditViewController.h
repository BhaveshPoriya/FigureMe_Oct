//
//  ProfileEditViewController.h
//  FigureMe
//
//  Created by ECSMac2 on 10/3/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileEditViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnSaveProfile;

@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;
@property (weak, nonatomic) IBOutlet UIButton *btnTwitter;

- (IBAction)btnSaveProfileClicked:(id)sender;

- (IBAction)btnFacebookClicked:(id)sender;
- (IBAction)btnTwitterClicked:(id)sender;


@end
