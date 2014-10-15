//
//  RegisterController.h
//  FigureMe
//
//  Created by ECSMac2 on 10/2/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface RegisterController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UIView *viewUsernameValidation;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewUsernameValidation;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIView *viewEmailValidation;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewEmailValidation;

@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UITextField *txtRepeatPassword;
@property (weak, nonatomic) IBOutlet UIView *viewPasswordValidation;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewPasswordValidation;

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@property (nonatomic) BOOL isValidUsername,isValidEmail,isValidPassword;

@property (strong, nonatomic) IBOutlet UIView *spinnerOverlay;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;

- (IBAction)btnRegisterClicked:(id)sender;
- (IBAction)btnCancelClicked:(id)sender;

@end
