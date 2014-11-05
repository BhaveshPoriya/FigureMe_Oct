//
//  ProfileEditViewController.h
//  FigureMe
//
//  Created by ECSMac2 on 10/3/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SocialConnectTwitterController.h"
#import "Constant.h"
#import "UserProfile.h"
#import "ProfileController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface ProfileEditViewController : UIViewController <UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UserProfile *objUserProfile;
}

@property (strong, nonatomic) IBOutlet UIView *spinnerOverlay;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;

@property (retain, nonatomic) UserProfile *objUserProfile;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *viewKeyboardToolbar;

@property (retain, nonatomic) IBOutlet UIImage *imgUpdatedImage;
@property (retain, nonatomic) IBOutlet UIView *viewCameraOverlay;
@property (retain, nonatomic) IBOutlet UIView *viewCameraContainer;


@property (weak, nonatomic) IBOutlet UIButton *btnSaveProfile;
@property (weak, nonatomic) IBOutlet UIButton *btnEditProfilePic;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfile;

@property (weak, nonatomic) IBOutlet UITableView *tblViewInterests;

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtDOB;
@property (weak, nonatomic) IBOutlet UITextView *txtViewAboutUs;

@property (nonatomic, retain) IBOutlet UIToolbar *accessoryView;
@property (nonatomic, retain) IBOutlet UIDatePicker *customInput;

@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;
@property (weak, nonatomic) IBOutlet UIButton *btnTwitter;
@property (weak, nonatomic) IBOutlet UIButton *btnSocialConnectGPlus;
@property (weak, nonatomic) IBOutlet UIButton *btnSocialConnectLinkedIn;
@property (weak, nonatomic) IBOutlet UIButton *btnSocialConnectYT;
@property (weak, nonatomic) IBOutlet UIButton *btnSocialConnectInstagram;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewInterest;
@property (nonatomic, strong) NSMutableArray *checkboxes;

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (strong, nonatomic) AVCaptureSession *session;

- (IBAction)dateChanged:(id)sender;
- (IBAction)doneEditing:(id)sender;

- (IBAction)btnSaveProfileClicked:(id)sender;
- (IBAction)btnEditProfilePicClicked:(id)sender;

- (IBAction)btnFacebookClicked:(id)sender;
- (IBAction)btnTwitterClicked:(id)sender;
- (IBAction)btnInstalgramClicked:(id)sender;
- (IBAction)btnLinkedInClicked:(id)sender;

@end
