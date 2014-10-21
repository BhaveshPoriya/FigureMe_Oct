//
//  ProfileEditViewController.h
//  FigureMe
//
//  Created by ECSMac2 on 10/3/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocialConnectTwitterController.h"
#import "Constant.h"

@interface ProfileEditViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *viewKeyboardToolbar;


@property (weak, nonatomic) IBOutlet UIButton *btnSaveProfile;
@property (weak, nonatomic) IBOutlet UIButton *btnEditProfilePic;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfile;

@property (weak, nonatomic) IBOutlet UITableView *tblViewInterests;

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtDOB;
@property (weak, nonatomic) IBOutlet UITextView *txtViewAboutUs;

@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;
@property (weak, nonatomic) IBOutlet UIButton *btnTwitter;


- (IBAction)btnSaveProfileClicked:(id)sender;
- (IBAction)btnEditProfilePicClicked:(id)sender;

- (IBAction)btnFacebookClicked:(id)sender;
- (IBAction)btnTwitterClicked:(id)sender;
- (IBAction)btnInstalgramClicked:(id)sender;
- (IBAction)btnLinkedInClicked:(id)sender;

@end
